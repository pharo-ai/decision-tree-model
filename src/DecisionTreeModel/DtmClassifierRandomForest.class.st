Class {
	#name : #DtmClassifierRandomForest,
	#superclass : #DtmAbstractRandomForest,
	#category : #DecisionTreeModel
}

{ #category : #accessing }
DtmClassifierRandomForest >> treeClass [
	^ DtmCARTDecisionTreeModel
]

{ #category : #classification }
DtmClassifierRandomForest >> voting: anArrayOfDecisions [
	"Specify how to mix the decisions of all the trees
	For classification return the label with the most votes"

	| arrayOfLabels |
	arrayOfLabels := anArrayOfDecisions collect: [ :each | each label ].
	^ DtmDecision withLabel: (DataSeries withValues: arrayOfLabels) asBag sortedCounts first value
]
