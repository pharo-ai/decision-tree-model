Class {
	#name : #DtmCARTDecisionTreeModelTest,
	#superclass : #DtmDecisionTreeModelTest,
	#instVars : [
		'treeModel'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmCARTDecisionTreeModelTest >> setUp [
	super setUp.
	treeModel := DtmCARTDecisionTreeModel new.
	tennisDataset target: 'playTennis'.
	mixedTennisDataset target: 'playTennis'.
]

{ #category : #running }
DtmCARTDecisionTreeModelTest >> testFindBestSplitIn [
	| split |
	split := treeModel findBestSplitIn: mixedTennisDataset.
	self assert: split feature equals: #outlook
]

{ #category : #running }
DtmCARTDecisionTreeModelTest >> testFit [
	treeModel fit: mixedTennisDataset.
	self assert: (treeModel root class inheritsFrom: DtmAbstractDecisionTreeNode)
]

{ #category : #running }
DtmCARTDecisionTreeModelTest >> testMaxDepth [
	treeModel maxDepth: 3.
	treeModel fit: mixedTennisDataset.
	self assert: treeModel root height equals: 3 
]
