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
	#instVars : [
		'minSizeForSplit',
		'maxDepth'
	],
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

{ #category : #initialization }
DtmID3DecisionTreeModel >> initialize [
	minSizeForSplit := 0.
	maxDepth := Float infinity.
]

{ #category : #metrics }
DtmID3DecisionTreeModel >> isAtEnd: aDataset [
	^ aDataset targetHasOneLabel
		or: [ aDataset doesNotHaveFeatures
			or: [ aDataset numberOfSplits >= maxDepth 
				or: [ aDataset size < minSizeForSplit ] ] ]
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> maxDepth [
	^ maxDepth
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> maxDepth: aNumber [
	maxDepth := aNumber
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> minSizeForSplit [
	^ minSizeForSplit
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> minSizeForSplit: aNumber [
	minSizeForSplit := aNumber
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> numericalSplitterClass [	
	^ DtmMultiwaySplitter
]
