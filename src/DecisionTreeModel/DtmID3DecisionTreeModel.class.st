"
Example of use

iris := DtmDataset fromDataFrame: Datasets loadIris.
iris target: #species.

discretizer := DtmDiscretizer new.
discretizer fitTransform: iris.

aTreeModel := DtmID3DecisionTreeModel new.
aTreeModel fit: iris.
"
Class {
	#name : #DtmID3DecisionTreeModel,
	#superclass : #DtmAbstractDecisionTreeModel,
	#instVars : [
		'originalUniqueValues'
	],
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmID3DecisionTreeModel >> buildNodeFor: aDatasetSplit [
	^ aDatasetSplit
		ifEmpty: [ self defaultDecisionFor: aDatasetSplit parent ]
		ifNotEmpty: [ self split: aDatasetSplit ].
			
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> buildNodeFor: aDataset splitingAt: aFeatureName [
	"Handle the creation of a node at catgorical/numerical feature"
	^ self buildNodeFor: aDataset splittingAtCategorical: aFeatureName
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> buildNodeFor: aDataset splittingAtCategorical: aFeatureName [

	|  decisionTreeForSplit  datasetSplit |
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: aFeatureName ].
		
	(self uniqueValuesOfFeatureAt: aFeatureName)
		do: [ :value | 
			datasetSplit := aDataset
				selectRows: [ :row | (row at: aFeatureName) = value ]
				selectFeatures: [ :feature | feature ~= aFeatureName ].
			decisionTreeForSplit at: value addChild: (self buildNodeFor: datasetSplit) ].
		
	^ decisionTreeForSplit
]

{ #category : #classification }
DtmID3DecisionTreeModel >> defaultDecisionFor: aDataset [
	^ DtmDecision withLabel: aDataset targetColumn mode
	
]

{ #category : #api }
DtmID3DecisionTreeModel >> fit: aDataset [

	originalUniqueValues := aDataset featuresUniqueValues. 
	^ root := self split: aDataset 
	
]

{ #category : #api }
DtmID3DecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset entropyOfTarget
	
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> split: aDataset [
	" Implements ID3 algorithm recursively to build a decision tree"

	| targetValues bestSplit |
	targetValues := aDataset targetColumn uniqueValues.
	
	"Stopping criteria"
	targetValues size = 1
		ifTrue: [ ^ DtmDecision withLabel: targetValues anyOne ].
	aDataset features isEmpty
		ifTrue: [ ^ self defaultDecisionFor: aDataset ].

	"Find best feature to split"
	bestSplit := self findBestSplitIn: aDataset.
	
	^ self buildNodeFor: aDataset splitingAt: bestSplit
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
