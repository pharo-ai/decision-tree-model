Class {
	#name : #AIDTCARTDecisionTreeModelTest,
	#superclass : #AIDTDecisionTreeModelTest,
	#instVars : [
		'treeModel'
	],
	#category : #'AI-DecisionTreeModel-Tests'
}

{ #category : #running }
AIDTCARTDecisionTreeModelTest >> setUp [
	super setUp.
	treeModel := AIDTCARTDecisionTreeModel new.
	tennisDataset target: 'playTennis'.
	mixedTennisDataset target: 'playTennis'.
]

{ #category : #running }
AIDTCARTDecisionTreeModelTest >> testFindBestSplitIn [
	| split |
	split := treeModel findBestSplitIn: mixedTennisDataset.
	self assert: split feature equals: #outlook
]

{ #category : #running }
AIDTCARTDecisionTreeModelTest >> testFit [
	treeModel fit: mixedTennisDataset.
	self assert: (treeModel root class inheritsFrom: AIDTAbstractDecisionTreeNode)
]

{ #category : #running }
AIDTCARTDecisionTreeModelTest >> testMaxDepth [
	treeModel maxDepth: 3.
	treeModel fit: mixedTennisDataset.
	self assert: treeModel root height equals: 3 
]
