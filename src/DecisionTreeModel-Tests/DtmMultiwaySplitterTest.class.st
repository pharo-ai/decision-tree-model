Class {
	#name : #DtmMultiwaySplitterTest,
	#superclass : #DtmID3DecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmMultiwaySplitterTest >> testSplitScoreForHumidity [
	| splitter actual expected|
	splitter := DtmMultiwaySplitter forFeature: #humidity.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.15183550136234147.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DtmMultiwaySplitterTest >> testSplitScoreForOutlook [
	| splitter actual expected|
	splitter := DtmMultiwaySplitter forFeature: #outlook.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.24674981977443905.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DtmMultiwaySplitterTest >> testSplitScoreForWind [
	| splitter actual expected|
	splitter := DtmMultiwaySplitter forFeature: #wind.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.0481270304082696.
	self assert: actual closeTo: expected
]

{ #category : #tests }
DtmMultiwaySplitterTest >> testSplitScoreForWithModel [
	| splitter actual expected|
	splitter := DtmMultiwaySplitter forFeature: #humidity.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.15183550136234147.
	self assert: actual closeTo: expected
]
