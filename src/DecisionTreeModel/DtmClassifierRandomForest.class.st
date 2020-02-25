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
	| arrayOfLabels label |
	arrayOfLabels := anArrayOfDecisions collect: [ :each | each label].
	label := (DataSeries withValues: arrayOfLabels) mode.
	^ DtmDecision withLabel: label
	
]
