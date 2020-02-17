Class {
	#name : #DtmNumericalSplitter,
	#superclass : #DtmAbstractSplitter,
	#instVars : [
		'threshold'
	],
	#category : #DecisionTreeModel
}

{ #category : #enumerating }
DtmNumericalSplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [

	|  decisionTreeForSplit splitsDict |
	
	splitsDict := self getSplitsFor: aDataset.
	decisionTreeForSplit := (DtmBinaryDecisionTree withCondition: self)
		trueChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: true));
		falseChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: false));
		yourself.
	^ decisionTreeForSplit
]

{ #category : #printing }
DtmNumericalSplitter >> comparingSymbol [
	^ ' <= '
]

{ #category : #enumerating }
DtmNumericalSplitter >> condition [
	^ [ :row | (row at: feature) <= threshold ]
]

{ #category : #enumerating }
DtmNumericalSplitter >> getSplitsFor: aDataset [
	| splits |
	splits := {  
		true -> (aDataset select: self condition).
		false -> (aDataset reject: self condition).
	}.
	^ splits asDictionary 
]

{ #category : #printing }
DtmNumericalSplitter >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: feature asString;
		nextPutAll: self comparingSymbol;
		nextPutAll: threshold asString;
		nextPutAll: ')'
]

{ #category : #enumerating }
DtmNumericalSplitter >> setBestThresholdFor: aDataset withModel: aDecisionTreeModel [
	"Applies a threshold over the data, and set the best the as the threshold of the splitter"
	| scoresDict  |
	scoresDict := (aDataset featureAt: feature) uniqueValues sorted allButLast collect: [ :value | 
		threshold := value.
		value -> (aDecisionTreeModel gainMeasureOf: aDataset given: self). "Get score of setting bestThreshold to threshold"
	].
	scoresDict := scoresDict asDictionary.
	threshold := scoresDict keyAtIdentityValue: (scoresDict max)
]

{ #category : #enumerating }
DtmNumericalSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split.
	If bestThreshold is not set, find it and then return gain measure of split"
	threshold ifNil: [ self setBestThresholdFor: aDataset withModel: aDecisionTreeModel ].
	^ aDecisionTreeModel gainMeasureOf: aDataset given: self
	
]

{ #category : #accessing }
DtmNumericalSplitter >> threshold [
	^ threshold
]

{ #category : #accessing }
DtmNumericalSplitter >> threshold: anObject [
	threshold := anObject
]

{ #category : #evaluating }
DtmNumericalSplitter >> value: anObject [
	^ self condition value: anObject
]
