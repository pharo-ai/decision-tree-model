"
I implement the ID3 algorithm to build a decision tree.

I use entropy as an impurity measure. I use a MultiwaySplitter for categorical and numerical variables.

I build a decision tree and store it in my root attribute. 


Example of use

iris := DtmDataset fromDataFrame: Datasets loadIris.
iris target: #species.

discretizer := DtmDiscretizer new.
discretizer fitTransform: iris.

aTreeModel := DtmID3DecisionTreeModel new.
aTreeModel fit: iris.
"
Class {
	#name : #DtmID3DecisionTreeModel,
	#superclass : #DtmAbstractDecisionTreeModel,
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmID3DecisionTreeModel >> categoricalSplitterClass [
	"Specify the class to handles the splitting of a categorical variable"
	^ DtmMultiwaySplitter 
]

{ #category : #classification }
DtmID3DecisionTreeModel >> defaultDecisionFor: aDataset [
	^ DtmDecision withLabel: aDataset targetColumn mode
	
]

{ #category : #api }
DtmID3DecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset entropyOfTarget
	
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> numericalSplitterClass [
	"Specify the class to handles the splitting of a numerical variable"	
	^ DtmMultiwaySplitter
]
