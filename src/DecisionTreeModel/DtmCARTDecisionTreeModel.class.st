Class {
	#name : #DtmCARTDecisionTreeModel,
	#superclass : #DtmAbstractDecisionTreeModel,
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmCARTDecisionTreeModel >> categoricalSplitterClass [
	^ DtmOneVsAllSplitter
]

{ #category : #metrics }
DtmCARTDecisionTreeModel >> defaultDecisionFor: aDataset [
	^ DtmDecision withLabel: aDataset targetColumn mode
]

{ #category : #metrics }
DtmCARTDecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset giniIndexOfTarget 
]

{ #category : #splitting }
DtmCARTDecisionTreeModel >> numericalSplitterClass [	
	^ DtmThresholdSplitter
]
