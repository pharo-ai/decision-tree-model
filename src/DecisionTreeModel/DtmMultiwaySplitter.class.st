"
I represent a multiway splitter for a dataset.

I know a strategy to make a multiway split on the dataset, where each split corresponds to a possible value of a feature. I know the instruction to build a multiway decision tree node with the corresponding split in the data. 
"
Class {
	#name : #DtmMultiwaySplitter,
	#superclass : #DtmAbstractSplitter,
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmMultiwaySplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [
	"Specify how a DecisionTreeNode should be built for the type of split.
	Multiway splits should build a MultiwayDecisionTree"

	|  decisionTreeForSplit |
	decisionTreeForSplit := DtmMultiwayDecisionTree withCondition: self.
	(self splitsFor: aDataset) keysAndValuesDo: [ :value :split | 
		split features: (split features copyWithout: feature).
		decisionTreeForSplit at: value addChild: (aDecisionTreeModel buildNodeFor: split) 
	].
	^ decisionTreeForSplit
]

{ #category : #accessing }
DtmMultiwaySplitter >> condition [
	^ [ :row | row at: feature ]
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

{ #category : #splitting }
DtmMultiwaySplitter >> splitsFor: aDataset [
	| splits selectedRowsGivenFeature |
	splits := (aDataset possibleValuesForFeatureAt: feature) collect: [ :value | 
		selectedRowsGivenFeature := aDataset split: [ :rows | (rows at: feature) = value ].
		value -> selectedRowsGivenFeature
	].
	^ splits asDictionary 
]
