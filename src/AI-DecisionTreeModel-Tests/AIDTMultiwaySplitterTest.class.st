Class {
	#name : 'AIDTMultiwaySplitterTest',
	#superclass : 'AIDTID3DecisionTreeModelTest',
	#category : 'AI-DecisionTreeModel-Tests',
	#package : 'AI-DecisionTreeModel-Tests'
}

{ #category : 'tests' }
AIDTMultiwaySplitterTest >> testSplitScoreForHumidity [
	| splitter actual expected|
	splitter := AIDTMultiwaySplitter forFeature: #humidity.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.15183550136234147.
	self assert: actual closeTo: expected
]

{ #category : 'tests' }
AIDTMultiwaySplitterTest >> testSplitScoreForOutlook [
	| splitter actual expected|
	splitter := AIDTMultiwaySplitter forFeature: #outlook.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.24674981977443905.
	self assert: actual closeTo: expected
]

{ #category : 'tests' }
AIDTMultiwaySplitterTest >> testSplitScoreForWind [
	| splitter actual expected|
	splitter := AIDTMultiwaySplitter forFeature: #wind.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.0481270304082696.
	self assert: actual closeTo: expected
]

{ #category : 'tests' }
AIDTMultiwaySplitterTest >> testSplitScoreForWithModel [
	| splitter actual expected|
	splitter := AIDTMultiwaySplitter forFeature: #humidity.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.15183550136234147.
	self assert: actual closeTo: expected
]
