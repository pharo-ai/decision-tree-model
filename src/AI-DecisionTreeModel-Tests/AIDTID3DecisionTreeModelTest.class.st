Class {
	#name : #AIDTID3DecisionTreeModelTest,
	#superclass : #AIDTDecisionTreeModelTest,
	#instVars : [
		'treeModel'
	],
	#category : #'AI-DecisionTreeModel-Tests'
}

{ #category : #running }
AIDTID3DecisionTreeModelTest >> setUp [
	super setUp.
	treeModel := AIDTID3DecisionTreeModel new.
	tennisDataset target: 'playTennis'.
	treeModel fit: tennisDataset.
]

{ #category : #tests }
AIDTID3DecisionTreeModelTest >> testATreeModelHasADecisionTreeAtRoot [
	self assert: (treeModel root class inheritsFrom: AIDTAbstractDecisionTreeNode )
]

{ #category : #tests }
AIDTID3DecisionTreeModelTest >> testATreeModelIfCloudyPlayTennis [

	| example |
	example := {
		           (#outlook -> #cloudy).
		           (#temperature -> #medium).
		           (#humidity -> #high).
		           (#wind -> #strong) } asDictionary.
	self assert: (treeModel root decisionFor: example) label
]

{ #category : #tests }
AIDTID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennis [

	| example |
	example := {
		           (#outlook -> #sunny).
		           (#temperature -> #medium).
		           (#humidity -> #normal).
		           (#wind -> #strong) } asDictionary.
	self assert: (treeModel root decisionFor: example) label
]

{ #category : #tests }
AIDTID3DecisionTreeModelTest >> testATreeModelIfSunnyAndHumiditNormalPlayTennisWithDecisionFor [

	| example |
	example := {
		           (#outlook -> #sunny).
		           (#temperature -> #medium).
		           (#humidity -> #normal).
		           (#wind -> #strong) } asDictionary.
	self assert: (treeModel decisionFor: example) label
]

{ #category : #tests }
AIDTID3DecisionTreeModelTest >> testDecisionsForAll [
	| testDataset expected actual |
	testDataset := AIDTDataset 
		withRows: #(#(sunny medium normal strong) 
			#(cloudy medium high strong)
			#(sunny medium high strong))
		withFeatures: #(outlook temperature humidity wind).
	expected := #(true true false).
	actual := ((treeModel decisionsForAll: testDataset) collect: [ :each | each label ]) asArray.
	self assert: actual equals: expected
]

{ #category : #tests }
AIDTID3DecisionTreeModelTest >> testFindBestSplit [
	| actual expected |
	tennisDataset features: #(outlook humidity).
	actual := (treeModel findBestSplitIn: tennisDataset) feature.
	expected := #outlook.
	self assert: actual equals: expected
]

{ #category : #tests }
AIDTID3DecisionTreeModelTest >> testTreeModelRootDecisionForOutputsDecisionTreeNode [

	| example |
	example := {
		           (#outlook -> #cloudy).
		           (#temperature -> #medium).
		           (#humidity -> #normal).
		           (#wind -> #strong) } asDictionary.
	self assert: ((treeModel root decisionFor: example) class inheritsFrom: AIDTAbstractDecisionTreeNode)
]
