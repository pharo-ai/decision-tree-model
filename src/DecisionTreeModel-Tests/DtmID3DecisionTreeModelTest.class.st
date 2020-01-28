Class {
	#name : #DtmID3DecisionTreeModelTest,
	#superclass : #DtmDecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelHasADecisionTreeAtRoot [
	| aTreeModel |
	aTreeModel := DtmID3DecisionTreeModel new.
	aTreeModel fit: tennisTable withTarget: 'playTennis'.
	self assert: (aTreeModel root class inheritsFrom: DtmAbstractDecisionTreeNode )
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfCloudyPlayTennis [
	| aTreeModel aSeries |
	aSeries := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(cloudy medium high strong).
	aTreeModel := DtmID3DecisionTreeModel new.
	aTreeModel fit: tennisTable withTarget: 'playTennis'.
	self assert: (aTreeModel root decisionFor: aSeries) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennis [
	| aTreeModel aSeries |
	aSeries := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(sunny medium normal strong).
	aTreeModel := DtmID3DecisionTreeModel new.
	aTreeModel fit: tennisTable withTarget: 'playTennis'.
	self assert: (aTreeModel root decisionFor: aSeries) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennisWithDecisionFor [
	| aTreeModel aSeries |
	aSeries := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(sunny medium normal strong).
	aTreeModel := DtmID3DecisionTreeModel new.
	aTreeModel fit: tennisTable withTarget: 'playTennis'.
	self assert: (aTreeModel decisionFor: aSeries) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testFindBestSplit [
	| aTreeModel anAttributeCollection actual expected |
	aTreeModel := DtmID3DecisionTreeModel new.
	anAttributeCollection := #(outlook humidity wind).
	actual := aTreeModel findBestSplitIn: tennisTable forFeatures: anAttributeCollection withTarget: #playTennis.
	expected := #outlook.
	self assert: actual equals: expected
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testTreeModelRootDecisionForOutputsDecisionTreeNode [
	| aTreeModel aSeries |
	aSeries := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(cloudy medium high strong).
	aTreeModel := DtmID3DecisionTreeModel new.
	aTreeModel fit: tennisTable withTarget: 'playTennis'.
	self assert: ((aTreeModel root decisionFor: aSeries) class inheritsFrom: DtmAbstractDecisionTreeNode)
]
