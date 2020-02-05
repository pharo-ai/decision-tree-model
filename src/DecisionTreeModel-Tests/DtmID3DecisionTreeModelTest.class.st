Class {
	#name : #DtmID3DecisionTreeModelTest,
	#superclass : #DtmDecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelHasADecisionTreeAtRoot [
	| aTreeModel |
	aTreeModel := DtmID3DecisionTreeModel new.
	tennisDataset target: 'playTennis'.
	aTreeModel fit: tennisDataset.
	self assert: (aTreeModel root class inheritsFrom: DtmAbstractDecisionTreeNode )
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
	| treeModel example |
	tennisDataset target: #playTennis.
	treeModel := DtmID3DecisionTreeModel new.
	treeModel fit: tennisDataset.
	example := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(sunny medium normal strong).
	self assert: (treeModel root decisionFor: example) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennisWithDecisionFor [
	| treeModel example |
	tennisDataset target: #playTennis.
	treeModel := DtmID3DecisionTreeModel new.
	treeModel fit: tennisDataset.
	example := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(sunny medium normal strong).
	self assert: (treeModel decisionFor: example) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testDecisionsForAll [
	| treeModel testDataset expected actual |
	tennisDataset target: #playTennis.
	treeModel := DtmID3DecisionTreeModel new.
	treeModel fit: tennisDataset.
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
	| aTreeModel anAttributeCollection actual expected |
	tennisDataset target: #playTennis.
	aTreeModel := DtmID3DecisionTreeModel new.
	anAttributeCollection := #(outlook humidity wind).
	actual := aTreeModel findBestSplitIn: tennisDataset forFeatures: anAttributeCollection.
	expected := #outlook.
	self assert: actual equals: expected
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testTreeModelRootDecisionForOutputsDecisionTreeNode [
	| aTreeModel aSeries |
	tennisDataset target: #playTennis.
	aTreeModel := DtmID3DecisionTreeModel new.
	aTreeModel fit: tennisDataset.
	aSeries := DataSeries 
		withKeys: #(outlook temperature humidity wind) 
		values: #(cloudy medium high strong).
	self assert: ((aTreeModel root decisionFor: aSeries) class inheritsFrom: DtmAbstractDecisionTreeNode)
]
