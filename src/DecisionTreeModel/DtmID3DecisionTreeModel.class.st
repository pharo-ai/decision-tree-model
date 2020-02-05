"
Example of use

iris := DtmDataset fromDataFrame: Datasets loadIris.
discretizer := DtmDiscretizer new.
discretizer fit: iris.
discretizer transform: iris.

aTreeModel := DtmID3DecisionTreeModel new.
aTreeModel fit: iris withTarget: 'class'.
"
Class {
	#name : #DtmID3DecisionTreeModel,
	#superclass : #DtmAbstractDecisionTreeModel,
	#instVars : [
		'datasetUniqueValues'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmID3DecisionTreeModel >> defaultDecisionFor: aColumn [
	^ DtmDecision withLabel: aColumn mode
	
]

{ #category : #'as yet unclassified' }
DtmID3DecisionTreeModel >> findBestSplitIn: aDataset forFeatures: aFeatureCollection [

	| currentInformationGain bestSplit bestInformationGain |
	bestInformationGain := Float negativeInfinity .
	
	aFeatureCollection do: [ :feature | 
		currentInformationGain := aDataset informationGainOfTargetGiven: feature.
		
		(currentInformationGain > bestInformationGain) ifTrue: [ 
			bestInformationGain := currentInformationGain.
			bestSplit := feature. ] ].
	
	^ bestSplit
]

{ #category : #api }
DtmID3DecisionTreeModel >> fit: aDataset [
	| initialFeatures |
	initialFeatures := aDataset features.
	datasetUniqueValues := aDataset featuresUniqueValues. 
	^ root := self split: aDataset forFeatures: initialFeatures
	
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> split: aDatasetSubset forFeatures: aFeatureCollection [
	" Implements ID3 algorithm recursively to build a decision tree"

	| targetValues bestSplit decisionTreeForSplit nextAttributeCollection nextNode nextRows |

	targetValues := aDatasetSubset targetColumn uniqueValues.
	"Stopping criteria"
	targetValues size = 1
		ifTrue: [ ^ DtmDecision withLabel: targetValues anyOne ].
		
	aFeatureCollection isEmpty
		ifTrue: [ ^ self defaultDecisionFor: aDatasetSubset targetColumn ].
		
	"Recursion to build tree"
	bestSplit := self
		findBestSplitIn: aDatasetSubset
		forFeatures: aFeatureCollection.
		
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: bestSplit ].
		
	nextAttributeCollection := aFeatureCollection copyWithout: bestSplit.
		
	(datasetUniqueValues at: bestSplit)
		do: [ :each | 
			nextRows := aDatasetSubset
				select: [ :row | (row at: bestSplit) = each ].
			nextNode := nextRows 
				ifEmpty: [ self defaultDecisionFor: aDatasetSubset targetColumn ]
				ifNotEmpty: [ self
						split: nextRows
						forFeatures: nextAttributeCollection].
			decisionTreeForSplit at: each addChild: nextNode ].
	^ decisionTreeForSplit
]
