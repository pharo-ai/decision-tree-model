Class {
	#name : #DtmC45DecisionTreeModelTest,
	#superclass : #DtmDecisionTreeModelTest,
	#instVars : [
		'treeModel'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmC45DecisionTreeModelTest >> setUp [
	super setUp.
	treeModel := DtmC45DecisionTreeModel new.
	tennisDataset target: 'playTennis'.
	mixedTennisDataset target: 'playTennis'.
]

{ #category : #running }
DtmC45DecisionTreeModelTest >> testFindBestSplitIn [
	| split |
	split := treeModel findBestSplitIn: mixedTennisDataset.
	self assert: split feature equals: #temperature
]

{ #category : #running }
DtmC45DecisionTreeModelTest >> testFit [
	treeModel fit: mixedTennisDataset.
	self assert: (treeModel root class inheritsFrom: DtmAbstractDecisionTreeNode)
]

{ #category : #running }
DtmC45DecisionTreeModelTest >> testMaxDepth [
	treeModel maxDepth: 3.
	treeModel fit: mixedTennisDataset.
	self assert: treeModel root height equals: 3 
]
