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
DtmID3DecisionTreeModel >> findBestSplitIn: aDataset [ 

	| currentInformationGain bestSplit bestInformationGain |
	
	bestInformationGain := Float negativeInfinity .
	
	aDataset features do: [ :feature | 
		currentInformationGain := aDataset informationGainOfTargetGiven: feature.
		
		(currentInformationGain > bestInformationGain) ifTrue: [ 
			bestInformationGain := currentInformationGain.
			bestSplit := feature. ] ].
	
	^ bestSplit
]

{ #category : #api }
DtmID3DecisionTreeModel >> fit: aDataset [
	datasetUniqueValues := aDataset featuresUniqueValues. 
	^ root := self split: aDataset 
	
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> split: aDatasetSubset [
	" Implements ID3 algorithm recursively to build a decision tree"

	| targetValues bestSplit decisionTreeForSplit nextNode nextRows |
	targetValues := aDatasetSubset targetColumn uniqueValues.
	"Stopping criteria"
	targetValues size = 1
		ifTrue: [ ^ DtmDecision withLabel: targetValues anyOne ].
	aDatasetSubset features isEmpty
		ifTrue: [ ^ self defaultDecisionFor: aDatasetSubset targetColumn ].

	"Recursion to build tree"
	bestSplit := self findBestSplitIn: aDatasetSubset.
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: bestSplit ].
		
	(datasetUniqueValues at: bestSplit)
		do: [ :each | 
			nextRows := aDatasetSubset
				selectRows: [ :row | (row at: bestSplit) = each ]
				selectFeatures: [ :feat | feat ~= bestSplit ].
			nextNode := nextRows
				ifEmpty: [ self defaultDecisionFor: aDatasetSubset targetColumn ]
				ifNotEmpty: [ self split: nextRows ].
			decisionTreeForSplit at: each addChild: nextNode ].
		
	^ decisionTreeForSplit
]
