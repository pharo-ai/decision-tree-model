Class {
	#name : #DtmNumericalSplitterTest,
	#superclass : #DtmC45DecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmNumericalSplitterTest >> testGainRatio [
	| splitter actual expected|
	splitter := (DtmThresholdSplitter forFeature: #humidity) threshold: 80.
	actual := treeModel gainMeasureOf: mixedTennisDataset  given: splitter.
	expected := 0.10873666959187776.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DtmNumericalSplitterTest >> testSetBestThresholdForWithModel [
	| splitter |
	splitter := DtmThresholdSplitter forFeature: #humidity.
	splitter setBestThresholdFor: mixedTennisDataset withModel: treeModel.
	self assert: splitter threshold equals: 65.
]

{ #category : #tests }
DtmNumericalSplitterTest >> testSplitScoreForHumidity [
	| splitter actual expected|
	splitter := DtmThresholdSplitter forFeature: #humidity.
	actual := splitter splitScoreFor: mixedTennisDataset withModel: treeModel.
	expected := 0.1285155090335478.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DtmNumericalSplitterTest >> testSplitScoreForWithModel [
	| splitter actual expected|
	splitter := DtmThresholdSplitter forFeature: #humidity.
	actual := splitter splitScoreFor: mixedTennisDataset withModel: treeModel.
	expected := 0.1285155090335478.
	self assert: actual closeTo: expected
]
