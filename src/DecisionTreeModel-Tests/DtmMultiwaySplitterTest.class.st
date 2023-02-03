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
	expected := 0.15183550136234142.
	self assert: actual equals: expected.
]

{ #category : #tests }
DtmMultiwaySplitterTest >> testSplitScoreForOutlook [
	| splitter actual expected|
	splitter := DtmMultiwaySplitter forFeature: #outlook.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.246749819774439.
	self assert: actual equals: expected.
]

{ #category : #tests }
DtmMultiwaySplitterTest >> testSplitScoreForWind [
	| splitter actual expected|
	splitter := DtmMultiwaySplitter forFeature: #wind.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.04812703040826938.
	self assert: actual equals: expected.
]

{ #category : #tests }
DtmMultiwaySplitterTest >> testSplitScoreForWithModel [
	| splitter actual expected|
	splitter := DtmMultiwaySplitter forFeature: #humidity.
	actual := splitter splitScoreFor: tennisDataset withModel: treeModel.
	expected := 0.15183550136234142.
	self assert: actual equals: expected.
]
