"
I represent an abstract splitter for a dataset.

My subclasses know a strategy to make a split on the dataset. They also know the instruction to build a decision tree node that is appropiate for that split. All my subclasses know a feature on which they split the dataset.
"
Class {
	#name : #AIDTAbstractSplitter,
	#superclass : #Object,
	#instVars : [
		'feature'
	],
	#category : #'AI-DecisionTreeModel'
}

{ #category : #'as yet unclassified' }
AIDTAbstractSplitter class >> forFeature: aFeature [
	^ self new
		feature: aFeature;
		yourself
]

{ #category : #splitting }
AIDTAbstractSplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [
	"Specify how a DecisionTreeNode should be built for the type of split"
	self subclassResponsibility
]

{ #category : #accessing }
AIDTAbstractSplitter >> condition [
	self subclassResponsibility
]

{ #category : #accessing }
AIDTAbstractSplitter >> feature [
	^ feature
]

{ #category : #accessing }
AIDTAbstractSplitter >> feature: anObject [
	feature := anObject
]

{ #category : #splitting }
AIDTAbstractSplitter >> forDataset: aDataset splitsDo: aBlock [
	"Execute aBlock at each split of the dataset"
	^ (self splitsFor: aDataset) valuesDo: aBlock
]

{ #category : #metrics }
AIDTAbstractSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split."
	self subclassResponsibility
]

{ #category : #splitting }
AIDTAbstractSplitter >> splitsFor: aDataset [
	self subclassResponsibility
]

{ #category : #evaluating }
AIDTAbstractSplitter >> value: anObject [
	^ self condition value: anObject
]
