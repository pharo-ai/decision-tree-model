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
		'dataset'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmID3DecisionTreeModel >> dataset: aDataset [
	dataset := aDataset
]

{ #category : #'as yet unclassified' }
DtmID3DecisionTreeModel >> defaultDecisionFor: aColumn [
	^ DtmDecision withLabel: aColumn mode
	
]

{ #category : #'as yet unclassified' }
DtmID3DecisionTreeModel >> findBestSplitIn: aDataset forFeatures: aFeatureCollection withTarget: aTargetName [ 

	| currentInformationGain bestSplit bestInformationGain |
	bestInformationGain := Float negativeInfinity .
	
	aFeatureCollection do: [ :feature | 
		currentInformationGain := aDataset informationGainOf: aTargetName given: feature.
		
		(currentInformationGain > bestInformationGain) ifTrue: [ 
			bestInformationGain := currentInformationGain.
			bestSplit := feature. ] ].
	
	^ bestSplit
]

{ #category : #api }
DtmID3DecisionTreeModel >> fit: aDataset withTarget: aTargetName [
	| validAttributes |
	validAttributes := aDataset features reject: [ :each | each = aTargetName].
	dataset := aDataset.
	^ root := self split: aDataset forFeatures: validAttributes withTarget: aTargetName
	
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> split: aDatasetSubset forFeatures: aFeatureCollection withTarget: aTargetName [
	" Implements ID3 algorithm recursively to build a decision tree"

	| targetColumn targetValues bestSplit decisionTreeForSplit nextAttributeCollection nextNode nextRows |
	targetColumn := aDatasetSubset featureAt: aTargetName.
	targetValues := targetColumn uniqueValues.
	"Stopping criteria"
	targetValues size = 1
		ifTrue: [ ^ DtmDecision withLabel: targetValues anyOne ].
		
	aFeatureCollection isEmpty
		ifTrue: [ ^ self defaultDecisionFor: targetColumn ].
		
	"Recursion to build tree"
	bestSplit := self
		findBestSplitIn: aDatasetSubset
		forFeatures: aFeatureCollection
		withTarget: aTargetName.
		
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: bestSplit ].
		
	nextAttributeCollection := aFeatureCollection
		reject: [ :each | each = bestSplit ].
		
	(dataset featureAt: bestSplit) uniqueValues
		do: [ :each | 
			nextRows := aDatasetSubset
				select: [ :row | (row at: bestSplit) = each ].
			nextNode := nextRows 
				ifEmpty: [ self defaultDecisionFor: targetColumn ]
				ifNotEmpty: [ self
						split: nextRows
						forFeatures: nextAttributeCollection
						withTarget: aTargetName ].
			decisionTreeForSplit at: each addChild: nextNode ].
	^ decisionTreeForSplit
]
