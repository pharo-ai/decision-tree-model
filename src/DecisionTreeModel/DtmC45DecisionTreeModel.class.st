Class {
	#name : #DtmC45DecisionTreeModel,
	#superclass : #DtmAbstractDecisionTreeModel,
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmC45DecisionTreeModel >> categoricalSplitterClass [
	^ DtmMultiwayDecisionTree
]

{ #category : #metrics }
DtmC45DecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset entropyOfTarget 
]

{ #category : #splitting }
DtmC45DecisionTreeModel >> numericalSplitterClass [	
	^ DtmNumericalSplitter 
]
