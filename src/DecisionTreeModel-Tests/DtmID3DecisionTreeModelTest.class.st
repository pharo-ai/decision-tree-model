Class {
	#name : #DtmID3DecisionTreeModelTest,
	#superclass : #DtmDecisionTreeModelTest,
	#instVars : [
		'treeModel'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
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

	| example |
	example := {
		           (#outlook -> #cloudy).
		           (#temperature -> #medium).
		           (#humidity -> #high).
		           (#wind -> #strong) } asDictionary.
	self assert: (treeModel root decisionFor: example) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennis [

	| example |
	example := {
		           (#outlook -> #sunny).
		           (#temperature -> #medium).
		           (#humidity -> #normal).
		           (#wind -> #strong) } asDictionary.
	self assert: (treeModel root decisionFor: example) label
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennisWithDecisionFor [

	| example |
	example := {
		           (#outlook -> #sunny).
		           (#temperature -> #medium).
		           (#humidity -> #normal).
		           (#wind -> #strong) } asDictionary.
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
	actual := (treeModel findBestSplitIn: tennisDataset) feature.
	expected := #outlook.
	self assert: actual equals: expected
]

{ #category : #tests }
DtmID3DecisionTreeModelTest >> testTreeModelRootDecisionForOutputsDecisionTreeNode [

	| example |
	example := {
		           (#outlook -> #cloudy).
		           (#temperature -> #medium).
		           (#humidity -> #normal).
		           (#wind -> #strong) } asDictionary.
	self assert: ((treeModel root decisionFor: example) class inheritsFrom: DtmAbstractDecisionTreeNode)
]
