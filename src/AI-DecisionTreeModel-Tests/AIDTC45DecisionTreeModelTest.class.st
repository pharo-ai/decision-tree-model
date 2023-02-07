Class {
	#name : #AIDTC45DecisionTreeModelTest,
	#superclass : #AIDTDecisionTreeModelTest,
	#instVars : [
		'treeModel'
	],
	#category : #'AI-DecisionTreeModel-Tests'
}

{ #category : #running }
AIDTC45DecisionTreeModelTest >> setUp [
	super setUp.
	treeModel := AIDTC45DecisionTreeModel new.
	tennisDataset target: 'playTennis'.
	mixedTennisDataset target: 'playTennis'
]

{ #category : #running }
AIDTC45DecisionTreeModelTest >> testFindBestSplitIn [
	| split |
	split := treeModel findBestSplitIn: mixedTennisDataset.
	self assert: split feature equals: #temperature
]

{ #category : #running }
AIDTC45DecisionTreeModelTest >> testFit [
	treeModel fit: mixedTennisDataset.
	self assert: (treeModel root class inheritsFrom: AIDTAbstractDecisionTreeNode)
]

{ #category : #running }
AIDTC45DecisionTreeModelTest >> testMaxDepth [
	treeModel maxDepth: 3.
	treeModel fit: mixedTennisDataset.
	self assert: treeModel root height equals: 3
]
