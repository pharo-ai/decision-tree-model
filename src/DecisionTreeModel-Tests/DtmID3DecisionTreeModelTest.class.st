Class {
	#name : #DtmID3DecisionTreeModelTest,
	#superclass : #DtmDecisionTreeModelTest,
	#instVars : [
		'treeModel'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmID3DecisionTreeModelTest >> setUp [
	super setUp.
	treeModel := DtmID3DecisionTreeModel new.
	tennisDataset target: 'playTennis'.
	treeModel fit: tennisDataset.
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelHasADecisionTreeAtRoot [
	self assert: (treeModel root class inheritsFrom: DtmAbstractDecisionTreeNode )
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfCloudyPlayTennis [
	| treeModel example |
	tennisDataset target: #playTennis.
	treeModel := DtmID3DecisionTreeModel new.
	treeModel fit: tennisDataset.
	example := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(cloudy medium high strong).
	self assert: (treeModel root decisionFor: example) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennis [
	| example |
	example := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(sunny medium normal strong).
	self assert: (treeModel root decisionFor: example) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennisWithDecisionFor [
	| example |
	example := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(sunny medium normal strong).
	self assert: (treeModel decisionFor: example) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testDecisionsForAll [
	| testDataset expected actual |
	testDataset := DtmDataset 
		withRows: #(#(sunny medium normal strong) 
			#(cloudy medium high strong)
			#(sunny medium high strong))
		withFeatures: #(outlook temperature humidity wind).
	expected := #(true true false).
	actual := ((treeModel decisionsForAll: testDataset) collect: [ :each | each label ]) asArray.
	self assert: actual equals: expected
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testFindBestSplit [
	| actual expected |
	tennisDataset features: #(outlook humidity).
	actual := treeModel findBestSplitIn: tennisDataset.
	expected := #outlook.
	self assert: actual equals: expected
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testTreeModelRootDecisionForOutputsDecisionTreeNode [
	|  example |
	example := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(cloudy medium high strong).
	self assert: ((treeModel root decisionFor: example) class inheritsFrom: DtmAbstractDecisionTreeNode)
]
