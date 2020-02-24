Class {
	#name : #DtmDatasetSplitTest,
	#superclass : #DtmDecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmDatasetSplitTest >> testEmptySplitHasFeatures [
	| datasetSplit |
	datasetSplit := tennisDataset split: [ :row | (row at: #outlook) = #nonexisting ].
	self assert: datasetSplit features equals: tennisDataset features
]

{ #category : #tests }
DtmDatasetSplitTest >> testEmptySplitHasTarget [
	| datasetSplit |
	tennisDataset target: #playTennis.
	datasetSplit := tennisDataset split: [ :row | (row at: #outlook) = #nonexisting ].
	self assert: datasetSplit target equals: tennisDataset target
]

{ #category : #tests }
DtmDatasetSplitTest >> testEmptySplitIsEmpty [
	| datasetSplit |
	datasetSplit := tennisDataset split: [ :row | (row at: #outlook) = #nonexisting ].
	self assert: datasetSplit isEmpty 
]

{ #category : #tests }
DtmDatasetSplitTest >> testSplitHasSameTargetAsParent [
	| datasetSplit |
	datasetSplit := tennisDataset select: [ :row | (row at: #outlook) = #sunny].
	self assert: datasetSplit target equals: tennisDataset target
]
