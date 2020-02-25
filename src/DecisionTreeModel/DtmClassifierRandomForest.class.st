Class {
	#name : #DtmClassifierRandomForest,
	#superclass : #DtmAbstractRandomForest,
	#category : #DecisionTreeModel
}

{ #category : #accessing }
DtmClassifierRandomForest >> treeClass [
	^ DtmCARTDecisionTreeModel
]
