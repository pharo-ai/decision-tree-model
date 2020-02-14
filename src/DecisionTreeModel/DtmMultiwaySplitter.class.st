Class {
	#name : #DtmMultiwaySplitter,
	#superclass : #DtmAbstractSplitter,
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmMultiwaySplitter class >> forFeature: aFeature [
	^ self new 
		feature: aFeature;
		yourself
]

{ #category : #enumerating }
DtmMultiwaySplitter >> bestSplitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split.
	For Multiway splits, only return the gain measure"
	^ aDecisionTreeModel gainMeasureOf: aDataset given: self
]

{ #category : #enumerating }
DtmMultiwaySplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [

	|  decisionTreeForSplit |
	
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: feature ].
		
	(self getSplitsFor: aDataset) keysAndValuesDo: [ :value :split | 
		split features: (split features copyWithout: feature).
		decisionTreeForSplit at: value addChild: (aDecisionTreeModel buildNodeFor: split) 
	].

	^ decisionTreeForSplit
]

{ #category : #enumerating }
DtmMultiwaySplitter >> getSplitsFor: aDataset [
	| splits selectedRowsGivenFeature |
	splits := (aDataset possibleValuesForFeatureAt: feature) collect: [ :value | 
		selectedRowsGivenFeature := aDataset select: [ :rows | (rows at: feature) = value ].
		value -> selectedRowsGivenFeature
	].
	^ splits asDictionary 
]
