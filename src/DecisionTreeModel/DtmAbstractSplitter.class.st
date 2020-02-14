Class {
	#name : #DtmAbstractSplitter,
	#superclass : #Object,
	#instVars : [
		'feature'
	],
	#category : #DecisionTreeModel
}

{ #category : #enumerating }
DtmAbstractSplitter >> bestSplitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split."
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
