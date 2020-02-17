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
	^ (self getSplitsFor: aDataset) valuesDo: aBlock
]

{ #category : #splitting }
DtmAbstractSplitter >> getSplitsFor: aDataset [
	self subclassResponsibility 
]

{ #category : #metrics }
DtmAbstractSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split."
	self subclassResponsibility
]

{ #category : #evaluating }
DtmAbstractSplitter >> value: anObject [
	^ self condition value: anObject
]
