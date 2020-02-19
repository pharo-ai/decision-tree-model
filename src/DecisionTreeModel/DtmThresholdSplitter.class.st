Class {
	#name : #DtmThresholdSplitter,
	#superclass : #DtmAbstractSplitter,
	#instVars : [
		'threshold'
	],
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmThresholdSplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [

	|  decisionTreeForSplit splitsDict |
	splitsDict := self getSplitsFor: aDataset.
	decisionTreeForSplit := (DtmBinaryDecisionTree withCondition: self)
		trueChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: true));
		falseChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: false));
		yourself.
	^ decisionTreeForSplit
]

{ #category : #printing }
DtmThresholdSplitter >> comparingSymbol [
	^ ' <= '
]

{ #category : #accessing }
DtmThresholdSplitter >> condition [
	^ [ :row | (row at: feature) <= threshold ]
]

{ #category : #splitting }
DtmThresholdSplitter >> getSplitsFor: aDataset [
	| splits |
	splits := {  
		true -> (aDataset select: self condition).
		false -> (aDataset reject: self condition).
	}.
	^ splits asDictionary 
]

{ #category : #printing }
DtmThresholdSplitter >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: feature asString;
		nextPutAll: self comparingSymbol;
		nextPutAll: threshold asString;
		nextPutAll: ')'
]

{ #category : #metrics }
DtmThresholdSplitter >> setBestThresholdFor: aDataset withModel: aDecisionTreeModel [
	"Applies a threshold over the data, and set the best the as the threshold of the splitter"
	| scoresDict  |
	scoresDict := (aDataset featureAt: feature) uniqueValues sorted allButLast collect: [ :value | 
		threshold := value.
		value -> (aDecisionTreeModel gainMeasureOf: aDataset given: self). "Get score of setting the threshold to the current value"
	].
	scoresDict := scoresDict asDictionary.
	threshold := scoresDict keyAtIdentityValue: (scoresDict max) "Set best threshold"
]

{ #category : #metrics }
DtmThresholdSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split.
	If bestThreshold is not set, find it and then return gain measure of split"
	(aDataset featureHasOneValue: feature) ifTrue: [ ^ 0 ].
	threshold ifNil: [ self setBestThresholdFor: aDataset withModel: aDecisionTreeModel ].
	^ aDecisionTreeModel gainMeasureOf: aDataset given: self
	
]

{ #category : #accessing }
DtmThresholdSplitter >> threshold [
	^ threshold
]

{ #category : #accessing }
DtmThresholdSplitter >> threshold: anObject [
	threshold := anObject
]
