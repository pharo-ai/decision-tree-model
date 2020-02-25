"
I represent an abstract splitter for a dataset.

My subclasses know a strategy to make a split on the dataset. They also know the instruction to build a decision tree node that is appropiate for that split. All my subclasses know a feature on which they split the dataset.
"
Class {
	#name : #DtmAbstractSplitter,
	#superclass : #Object,
	#instVars : [
		'feature'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmAbstractSplitter class >> forFeature: aFeature [
	^ self new 
		feature: aFeature;
		yourself
]

{ #category : #splitting }
DtmAbstractSplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [
	"Specify how a DecisionTreeNode should be built for the type of split"
	self subclassResponsibility 
]

{ #category : #accessing }
DtmAbstractSplitter >> condition [
	self subclassResponsibility
]

{ #category : #accessing }
DtmAbstractSplitter >> feature [
	^ feature
]

{ #category : #accessing }
DtmAbstractSplitter >> feature: anObject [
	feature := anObject
]

{ #category : #splitting }
DtmAbstractSplitter >> forDataset: aDataset splitsDo: aBlock [
	"Execute aBlock at each split of the dataset"
	^ (self splitsFor: aDataset) valuesDo: aBlock
]

{ #category : #metrics }
DtmAbstractSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split."
	self subclassResponsibility
]

{ #category : #splitting }
DtmAbstractSplitter >> splitsFor: aDataset [
	self subclassResponsibility 
]

{ #category : #evaluating }
DtmAbstractSplitter >> value: anObject [
	^ self condition value: anObject
]
