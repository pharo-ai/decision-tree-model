"
Example of use

iris := DtmDataset fromDataFrame: Datasets loadIris.
discretizer := DtmDiscretizer new.
discretizer fit: iris.
discretizer transform: iris.

aTreeModel := DtmID3DecisionTreeModel new.
aTreeModel fit: iris withTarget: 'class'.
"
Class {
	#name : #DtmID3DecisionTreeModel,
	#superclass : #DtmAbstractDecisionTreeModel,
	#instVars : [
		'originalUniqueValues'
	],
	#category : #DecisionTreeModel
}

{ #category : #classification }
DtmID3DecisionTreeModel >> defaultDecisionFor: aDataset [
	^ DtmDecision withLabel: aDataset targetColumn mode
	
]

{ #category : #api }
DtmID3DecisionTreeModel >> fit: aDataset [

	datasetUniqueValues := aDataset featuresUniqueValues. 
	^ root := self split: aDataset 
	
]

{ #category : #api }
DtmID3DecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset entropyOfTarget
	
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> split: aDatasetSubset [
	" Implements ID3 algorithm recursively to build a decision tree"

	| targetValues bestSplit decisionTreeForSplit nextNode nextRows |
	targetValues := aDatasetSubset targetColumn uniqueValues.
	
	"Stopping criteria"
	targetValues size = 1
		ifTrue: [ ^ DtmDecision withLabel: targetValues anyOne ].
	aDatasetSubset features isEmpty
		ifTrue: [ ^ self defaultDecisionFor: aDatasetSubset ].

	"Recursion to build tree"
	bestSplit := self findBestSplitIn: aDatasetSubset.
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: bestSplit ].
		
	(datasetUniqueValues at: bestSplit)
		do: [ :each | 
			nextRows := aDatasetSubset
				selectRows: [ :row | (row at: bestSplit) = each ]
				selectFeatures: [ :feat | feat ~= bestSplit ].
			nextNode := nextRows
				ifEmpty: [ self defaultDecisionFor: aDatasetSubset ]
				ifNotEmpty: [ self split: nextRows ].
			decisionTreeForSplit at: each addChild: nextNode ].
		
	^ decisionTreeForSplit
]

{ #category : #metrics }
DtmID3DecisionTreeModel >> splitMetricOf: aDataset given: aFeatureName [
	"ID3 should treat all features as categorical"
	
	^ self splitMetricOf: aDataset givenCategorical: aFeatureName
]

{ #category : #accessing }
DtmID3DecisionTreeModel >> uniqueValuesOfFeatureAt: aFeatureName [
	^ originalUniqueValues at: aFeatureName
]
