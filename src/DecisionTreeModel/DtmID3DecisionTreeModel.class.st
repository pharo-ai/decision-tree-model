"
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
DtmID3DecisionTreeModel >> buildNodeFor: aDatasetSplit [
	^ aDatasetSplit
		ifEmpty: [ self defaultDecisionFor: aDatasetSplit parent ]
		ifNotEmpty: [ self split: aDatasetSplit ].
			
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> categoricalSplitterClass [
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

{ #category : #metrics }
DtmID3DecisionTreeModel >> isAtEnd: aDataset [
	^ aDataset targetColumn uniqueValues size = 1 
		or: [ aDataset features isEmpty ]
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> numericalSplitterClass [	
	^ DtmMultiwaySplitter
]
