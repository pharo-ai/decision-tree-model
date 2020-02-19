Class {
	#name : #DtmOneVsAllSplitter,
	#superclass : #DtmBinarySplitter,
	#instVars : [
		'level'
	],
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmOneVsAllSplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [

	|  decisionTreeForSplit splitsDict |
	splitsDict := self getSplitsFor: aDataset.
	decisionTreeForSplit := (DtmBinaryDecisionTree withCondition: self)
		trueChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: true));
		falseChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: false));
		yourself.
	^ decisionTreeForSplit
]

{ #category : #printing }
DtmOneVsAllSplitter >> comparingSymbol [
	^ ' = '
]

{ #category : #accessing }
DtmOneVsAllSplitter >> condition [
	^ [ :row | (row at: feature) = level ]
]

{ #category : #accessing }
DtmOneVsAllSplitter >> level [
	^ level
]

{ #category : #accessing }
DtmOneVsAllSplitter >> level: anObject [
	level := anObject
]

{ #category : #printing }
DtmOneVsAllSplitter >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: feature asString;
		nextPutAll: self comparingSymbol;
		nextPutAll: level asString;
		nextPutAll: ')'
]

{ #category : #metrics }
DtmOneVsAllSplitter >> setBestLevelFor: aDataset withModel: aDecisionTreeModel [
	"Compares one level to the rest of the values, and set the best the as the level of the splitter"
	| scoresDict  |
	scoresDict := (aDataset featureAt: feature) uniqueValues collect: [ :value | 
		level := value.
		value -> (aDecisionTreeModel gainMeasureOf: aDataset given: self). "Get score of setting the level to the current value"
	].
	scoresDict := scoresDict asDictionary.
	level := scoresDict keyAtIdentityValue: scoresDict max "Set best level"
]

{ #category : #metrics }
DtmOneVsAllSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split.
	If level for split is not set, find it and then return gain measure of split"
	(aDataset featureHasOneValue: feature) ifTrue: [ ^ 0 ].
	level ifNil: [ self setBestLevelFor: aDataset withModel: aDecisionTreeModel ].
	^ aDecisionTreeModel gainMeasureOf: aDataset given: self
]
