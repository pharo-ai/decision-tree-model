"
I represent an One vs All binary splitter for a dataset.

I know a strategy to make a binary split on the dataset, checking if the value of a feature is equal to a corresponding value (called level). I know the instruction to build a binary decision tree node with the corresponding split in the data. 
"
Class {
	#name : 'AIDTOneVsAllSplitter',
	#superclass : 'AIDTBinarySplitter',
	#instVars : [
		'level'
	],
	#category : 'AI-DecisionTreeModel',
	#package : 'AI-DecisionTreeModel'
}

{ #category : 'printing' }
AIDTOneVsAllSplitter >> comparingSymbol [
	^ ' = '
]

{ #category : 'accessing' }
AIDTOneVsAllSplitter >> condition [
	^ [ :row | (row at: feature) = level ]
]

{ #category : 'accessing' }
AIDTOneVsAllSplitter >> level [
	^ level
]

{ #category : 'accessing' }
AIDTOneVsAllSplitter >> level: anObject [
	level := anObject
]

{ #category : 'printing' }
AIDTOneVsAllSplitter >> printOn: aStream [
	<ignoreForCoverage>
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: feature asString;
		nextPutAll: self comparingSymbol;
		nextPutAll: level asString;
		nextPutAll: ')'
]

{ #category : 'metrics' }
AIDTOneVsAllSplitter >> setBestLevelFor: aDataset withModel: aDecisionTreeModel [
	"Compares one level to the rest of the values, and set the best the as the level of the splitter"

	| scoresDict |
	scoresDict := (aDataset featureAt: feature) asSet collect: [ :value |
		              level := value.
		              value -> (aDecisionTreeModel gainMeasureOf: aDataset given: self) "Get score of setting the level to the current value" ].
	scoresDict := scoresDict asDictionary.
	level := scoresDict keyAtIdentityValue: scoresDict max "Set best level"
]

{ #category : 'metrics' }
AIDTOneVsAllSplitter >> splitScoreFor: aDataset withModel: aDecisionTreeModel [
	"Specify how to calculate the score of the split.
	If level for split is not set, find it and then return gain measure of split"
	(aDataset featureHasOneValue: feature) ifTrue: [ ^ 0 ].
	level ifNil: [ self setBestLevelFor: aDataset withModel: aDecisionTreeModel ].
	^ aDecisionTreeModel gainMeasureOf: aDataset given: self
]
