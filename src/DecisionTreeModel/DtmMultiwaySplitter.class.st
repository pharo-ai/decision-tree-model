Class {
	#name : #DtmMultiwaySplitter,
	#superclass : #DtmAbstractSplitter,
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmMultiwaySplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [

	|  decisionTreeForSplit |
	
	decisionTreeForSplit := DtmMultiwayDecisionTree withCondition: self.
	(self getSplitsFor: aDataset) keysAndValuesDo: [ :value :split | 
		split features: (split features copyWithout: feature).
		decisionTreeForSplit at: value addChild: (aDecisionTreeModel buildNodeFor: split) 
	].

	^ decisionTreeForSplit
]

{ #category : #accessing }
DtmMultiwaySplitter >> condition [
	^ [ :row | row at: feature ]
]

{ #category : #splitting }
DtmMultiwaySplitter >> getSplitsFor: aDataset [
	| splits selectedRowsGivenFeature |
	splits := (aDataset possibleValuesForFeatureAt: feature) collect: [ :value | 
		selectedRowsGivenFeature := aDataset select: [ :rows | (rows at: feature) = value ].
		value -> selectedRowsGivenFeature
	].
	^ splits asDictionary 
]

{ #category : #printing }
DtmMultiwaySplitter >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: feature asString;
		nextPutAll: ')'
]

{ #category : #metrics }
DtmMultiwaySplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split.
	For Multiway splits, only return the gain measure"
	^ aDecisionTreeModel gainMeasureOf: aDataset given: self
]
