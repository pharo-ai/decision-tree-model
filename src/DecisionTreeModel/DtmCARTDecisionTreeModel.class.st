"
I implement the CART algorithm to build a decision tree.

I use gini index as an impurity measure. I use a OneVsAll splitter for categorical variables and a ThresholdSplitter for numerical variables.

I build a decision tree and store it in my root attribute. 
"
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
