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
DtmID3DecisionTreeModel >> findBestSplitIn: aDataset forAttibutes: anAttributeCollection withTarget: aTargetName [ 

	| currentInformationGain bestSplit bestInformationGain |
	anAttributeCollection do: [ :each | 
		currentInformationGain := aDataset informationGainOf: aTargetName given: each.
		(bestSplit isNil or: [ currentInformationGain > bestInformationGain]) ifTrue: [ 
			bestInformationGain := currentInformationGain.
			bestSplit := each.
		]
	].
	^ bestSplit
]

{ #category : #'as yet unclassified' }
DtmID3DecisionTreeModel >> fit: aDataset withTarget: aTargetName [
	| validAttributes |
	validAttributes := aDataset columnNames reject: [ :each | each = aTargetName].
	dataset := aDataset.
	^ root := self split: aDataset forAttributes: validAttributes withTarget: aTargetName
	
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> split: aDatasetSubset forAttributes: anAttributeCollection withTarget: aTargetName [
	" Implements ID3 algorithm recursively to build a decision tree"

	| targetColumn targetValues bestSplit decisionTreeForSplit nextAttributeCollection nextNode nextRows |
	targetColumn := aDatasetSubset column: aTargetName.
	targetValues := targetColumn uniqueValues.
	"Stopping criteria"
	targetValues size = 1
		ifTrue: [ ^ DtmDecision withLabel: targetValues first ].
	anAttributeCollection isEmpty
		ifTrue: [ ^ DtmDecision withLabel: targetColumn first ].
	"TODO: Recursion to build tree"
	bestSplit := self
		findBestSplitIn: aDatasetSubset
		forAttibutes: anAttributeCollection
		withTarget: aTargetName.
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: bestSplit ].
	nextAttributeCollection := anAttributeCollection
		reject: [ :each | each = bestSplit ].
	(dataset column: bestSplit) uniqueValues
		do: [ :each | 
			nextRows := aDatasetSubset
				select: [ :row | (row at: bestSplit) = each ].
			nextNode := nextRows isEmpty
				ifTrue: [ DtmDecision withLabel: targetColumn mode ]
				ifFalse: [ self
						split: nextRows
						forAttributes: nextAttributeCollection
						withTarget: aTargetName ].
			decisionTreeForSplit at: each addChild: nextNode ].
	^ decisionTreeForSplit
]
