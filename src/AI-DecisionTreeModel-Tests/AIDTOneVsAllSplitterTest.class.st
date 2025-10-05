Class {
	#name : 'AIDTOneVsAllSplitterTest',
	#superclass : 'AIDTCARTDecisionTreeModelTest',
	#category : 'AI-DecisionTreeModel-Tests',
	#package : 'AI-DecisionTreeModel-Tests'
}

{ #category : 'running' }
AIDTOneVsAllSplitterTest >> setUp [
	super setUp.
	treeModel := AIDTCARTDecisionTreeModel new.
	fruitDataset target: 'fruit'
]

{ #category : 'tests' }
AIDTOneVsAllSplitterTest >> testSetBestLevelForWithModel [
	| splitter |
	splitter := AIDTOneVsAllSplitter forFeature: #color.
	splitter setBestLevelFor: fruitDataset withModel: treeModel.
	self assert: splitter level equals: #red
]

{ #category : 'tests' }
AIDTOneVsAllSplitterTest >> testSplitScoreForColor [
	| splitter actual expected |
	splitter := AIDTOneVsAllSplitter forFeature: #color.
	actual := splitter splitScoreFor: fruitDataset withModel: treeModel.
	expected := 0.3733333333.
	self assert: actual closeTo: expected
]
