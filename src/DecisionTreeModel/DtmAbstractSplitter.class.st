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

{ #category : #enumerating }
DtmAbstractSplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [
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

{ #category : #enumerating }
DtmAbstractSplitter >> forDataset: aDataset splitsDo: aBlock [
	"Execute aBlock at each split of the dataset"
	^ (self getSplitsFor: aDataset) valuesDo: aBlock
]

{ #category : #enumerating }
DtmAbstractSplitter >> getSplitsFor: aDataset [
	self subclassResponsibility 
]

{ #category : #enumerating }
DtmAbstractSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split."
	self subclassResponsibility
]
