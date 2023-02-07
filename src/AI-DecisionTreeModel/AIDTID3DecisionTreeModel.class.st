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
	#name : #AIDTID3DecisionTreeModel,
	#superclass : #AIDTAbstractDecisionTreeModel,
	#category : #'AI-DecisionTreeModel'
}

{ #category : #splitting }
AIDTID3DecisionTreeModel >> categoricalSplitterClass [
	"Specify the class to handles the splitting of a categorical variable"
	^ AIDTMultiwaySplitter
]

{ #category : #api }
AIDTID3DecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset entropyOfTarget
]

{ #category : #splitting }
AIDTID3DecisionTreeModel >> numericalSplitterClass [
	"Specify the class to handles the splitting of a numerical variable"
	^ AIDTMultiwaySplitter
]
