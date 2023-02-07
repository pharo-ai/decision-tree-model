Class {
	#name : #AIDTClassifierRandomForest,
	#superclass : #AIDTAbstractRandomForest,
	#category : #'AI-DecisionTreeModel'
}

{ #category : #accessing }
AIDTClassifierRandomForest >> treeClass [
	^ AIDTCARTDecisionTreeModel
]

{ #category : #classification }
AIDTClassifierRandomForest >> voting: anArrayOfDecisions [
	"Specify how to mix the decisions of all the trees
	For classification return the label with the most votes"

	| arrayOfLabels |
	arrayOfLabels := anArrayOfDecisions collect: [ :each | each label ].
	^ AIDTDecision withLabel: (DataSeries withValues: arrayOfLabels) asBag sortedCounts first value
]
