Class {
	#name : #AIDTNumericalSplitterTest,
	#superclass : #AIDTC45DecisionTreeModelTest,
	#category : #'AI-DecisionTreeModel-Tests'
}

{ #category : #tests }
AIDTNumericalSplitterTest >> testGainRatio [
	| splitter actual expected|
	splitter := (AIDTThresholdSplitter forFeature: #humidity) threshold: 80.
	actual := treeModel gainMeasureOf: mixedTennisDataset  given: splitter.
	expected := 0.10873666959187776.
	self assert: actual closeTo: expected
]

{ #category : #tests }
AIDTNumericalSplitterTest >> testSetBestThresholdForWithModel [
	| splitter |
	splitter := AIDTThresholdSplitter forFeature: #temperature.
	splitter setBestThresholdFor: mixedTennisDataset withModel: treeModel.
	self assert: splitter threshold equals: 83.
]

{ #category : #tests }
AIDTNumericalSplitterTest >> testSplitScoreForHumidity [
	| splitter actual expected|
	splitter := AIDTThresholdSplitter forFeature: #humidity.
	actual := splitter splitScoreFor: mixedTennisDataset withModel: treeModel.
	expected := 0.1285155090335478.
	self assert: actual closeTo: expected
]

{ #category : #tests }
AIDTNumericalSplitterTest >> testSplitScoreForWithModel [
	| splitter actual expected|
	splitter := AIDTThresholdSplitter forFeature: #humidity.
	actual := splitter splitScoreFor: mixedTennisDataset withModel: treeModel.
	expected := 0.1285155090335478.
	self assert: actual closeTo: expected
]
