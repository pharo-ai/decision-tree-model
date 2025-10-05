Class {
	#name : 'AIDTRegressionDecisionTreeModel',
	#superclass : 'AIDTCARTDecisionTreeModel',
	#category : 'AI-DecisionTreeModel',
	#package : 'AI-DecisionTreeModel'
}

{ #category : 'classification' }
AIDTRegressionDecisionTreeModel >> defaultDecisionFor: aDataset [
	^ AIDTDecision withLabel: aDataset targetColumn average
]

{ #category : 'metrics' }
AIDTRegressionDecisionTreeModel >> impurityMeasureOf: aDataset [
	"For regression, the impurity will me the mean squared error"
	
	| meanValue |
	meanValue := aDataset targetColumn average.
	^ (aDataset targetColumn - meanValue) squared average
]
