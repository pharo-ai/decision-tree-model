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
	"Specify the class to handles the splitting of a categorical variable"
	^ DtmOneVsAllSplitter
]

{ #category : #metrics }
DtmCARTDecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset giniIndexOfTarget 
]

{ #category : #splitting }
DtmCARTDecisionTreeModel >> numericalSplitterClass [	
	"Specify the class to handles the splitting of a numerical variable"
	^ DtmThresholdSplitter
]
