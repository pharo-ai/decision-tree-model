Class {
	#name : #DtmRegressionDecisionTreeModel,
	#superclass : #DtmCARTDecisionTreeModel,
	#category : #DecisionTreeModel
}

{ #category : #classification }
DtmRegressionDecisionTreeModel >> defaultDecisionFor: aDataset [
	^ DtmDecision withLabel: aDataset targetColumn average
]

{ #category : #metrics }
DtmRegressionDecisionTreeModel >> impurityMeasureOf: aDataset [
	"For regression, the impurity will me the mean squared error"
	| meanValue |
	meanValue := aDataset targetColumn average.
	^ (aDataset targetColumn - meanValue) squared average
]
