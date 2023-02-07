Class {
	#name : #AIDTDatasetSplitTest,
	#superclass : #AIDTDecisionTreeModelTest,
	#category : #'AI-DecisionTreeModel-Tests'
}

{ #category : #tests }
AIDTDatasetSplitTest >> testEmptySplitHasFeatures [
	| datasetSplit |
	datasetSplit := tennisDataset split: [ :row | (row at: #outlook) = #nonexisting ].
	self assert: datasetSplit features equals: tennisDataset features
]

{ #category : #tests }
AIDTDatasetSplitTest >> testEmptySplitHasTarget [
	| datasetSplit |
	tennisDataset target: #playTennis.
	datasetSplit := tennisDataset split: [ :row | (row at: #outlook) = #nonexisting ].
	self assert: datasetSplit target equals: tennisDataset target
]

{ #category : #tests }
AIDTDatasetSplitTest >> testEmptySplitIsEmpty [
	| datasetSplit |
	datasetSplit := tennisDataset split: [ :row | (row at: #outlook) = #nonexisting ].
	self assert: datasetSplit isEmpty 
]

{ #category : #tests }
AIDTDatasetSplitTest >> testSplitHasSameTargetAsParent [
	| datasetSplit |
	datasetSplit := tennisDataset select: [ :row | (row at: #outlook) = #sunny].
	self assert: datasetSplit target equals: tennisDataset target
]
