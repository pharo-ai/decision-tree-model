"
I implement the CART algorithm to build a decision tree.

I use gini index as an impurity measure. I use a OneVsAll splitter for categorical variables and a ThresholdSplitter for numerical variables.

I build a decision tree and store it in my root attribute. 
"
Class {
	#name : #AIDTCARTDecisionTreeModel,
	#superclass : #AIDTAbstractDecisionTreeModel,
	#category : #'AI-DecisionTreeModel'
}

{ #category : #splitting }
AIDTCARTDecisionTreeModel >> categoricalSplitterClass [
	"Specify the class to handles the splitting of a categorical variable"
	^ AIDTOneVsAllSplitter
]

{ #category : #metrics }
AIDTCARTDecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset giniIndexOfTarget
]

{ #category : #splitting }
AIDTCARTDecisionTreeModel >> numericalSplitterClass [
	"Specify the class to handles the splitting of a numerical variable"
	^ AIDTThresholdSplitter
]
