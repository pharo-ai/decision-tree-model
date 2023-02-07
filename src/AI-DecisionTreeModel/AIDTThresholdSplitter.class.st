"
I represent a threshold binary splitter for a dataset.

I know a strategy to make a binary split on the dataset, checking if the value of a feature less or equal to a threshold value. I know the instruction to build a binary decision tree node with the corresponding split in the data. 
"
Class {
	#name : #AIDTThresholdSplitter,
	#superclass : #AIDTBinarySplitter,
	#instVars : [
		'threshold'
	],
	#category : #'AI-DecisionTreeModel'
}

{ #category : #printing }
AIDTThresholdSplitter >> comparingSymbol [
	^ ' <= '
]

{ #category : #accessing }
AIDTThresholdSplitter >> condition [
	^ [ :row | (row at: feature) <= threshold ]
]

{ #category : #printing }
AIDTThresholdSplitter >> printOn: aStream [
	<ignoreForCoverage>
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: feature asString;
		nextPutAll: self comparingSymbol;
		nextPutAll: threshold asString;
		nextPutAll: ')'
]

{ #category : #metrics }
AIDTThresholdSplitter >> setBestThresholdFor: aDataset withModel: aDecisionTreeModel [
	"Applies a threshold over the data, and set the best the as the threshold of the splitter"

	| scoresDict |
	scoresDict := (aDataset featureAt: feature) asSet sorted allButLast collect: [ :value |
		              threshold := value.
		              value -> (aDecisionTreeModel gainMeasureOf: aDataset given: self) "Get score of setting the threshold to the current value" ].
	scoresDict := scoresDict asDictionary.
	threshold := scoresDict keyAtIdentityValue: scoresDict max "Set best threshold"
]

{ #category : #metrics }
AIDTThresholdSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split.
	If threshold is not set, find it and then return gain measure of split"
	(aDataset featureHasOneValue: feature) ifTrue: [ ^ 0 ].
	threshold ifNil: [ self setBestThresholdFor: aDataset withModel: aDecisionTreeModel ].
	^ aDecisionTreeModel gainMeasureOf: aDataset given: self
]

{ #category : #accessing }
AIDTThresholdSplitter >> threshold [
	^ threshold
]

{ #category : #accessing }
AIDTThresholdSplitter >> threshold: anObject [
	threshold := anObject
]
