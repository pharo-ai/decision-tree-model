Class {
	#name : #DtmOneVsAllSplitterTest,
	#superclass : #DtmCARTDecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmOneVsAllSplitterTest >> setUp [
	super setUp.
	treeModel := DtmCARTDecisionTreeModel new.
	fruitDataset target: 'fruit'.
]

{ #category : #tests }
DtmOneVsAllSplitterTest >> testSetBestLevelForWithModel [
	| splitter |
	splitter := DtmOneVsAllSplitter forFeature: #color.
	splitter setBestLevelFor: fruitDataset withModel: treeModel.
	self assert: splitter level equals: #red.
]

{ #category : #tests }
DtmOneVsAllSplitterTest >> testSplitScoreForColor [
	| splitter actual expected |
	splitter := DtmOneVsAllSplitter forFeature: #color.
	actual := splitter splitScoreFor: fruitDataset withModel: treeModel.
	expected := 0.3733333333.
	self assert: actual closeTo: expected
]
