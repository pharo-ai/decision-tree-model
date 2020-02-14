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
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmID3DecisionTreeModel >> buildNodeFor: aDatasetSplit [
	^ aDatasetSplit
		ifEmpty: [ self defaultDecisionFor: aDatasetSplit parent ]
		ifNotEmpty: [ self split: aDatasetSplit ].
			
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> buildNodeFor: aDataset splitingAt: aSplitter [
	"Handle the creation of a node at catgorical/numerical feature"
	^ aSplitter buildNodeFor: aDataset inModel: self.
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> buildNodeFor: aDataset splittingAtCategorical: aFeatureName [

	|  decisionTreeForSplit  datasetSplit |
	decisionTreeForSplit := DtmMultiwayDecisionTree
		withCondition: [ :row | row at: aFeatureName ].
		
	(aDataset possibleValuesForFeatureAt: aFeatureName)
		do: [ :value | 
			datasetSplit := aDataset
				selectRows: [ :row | (row at: aFeatureName) = value ]
				selectFeatures: [ :feature | feature ~= aFeatureName ].
			decisionTreeForSplit at: value addChild: (self buildNodeFor: datasetSplit) ].
		
	^ decisionTreeForSplit
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> categoricalSplitterClass [
	^ DtmMultiwaySplitter 
]

{ #category : #classification }
DtmID3DecisionTreeModel >> defaultDecisionFor: aDataset [
	^ DtmDecision withLabel: aDataset targetColumn mode
	
]

{ #category : #api }
DtmID3DecisionTreeModel >> fit: aDataset [
	^ root := self split: aDataset 
	
]

{ #category : #api }
DtmID3DecisionTreeModel >> impurityMeasureOf: aDataset [
	^ aDataset entropyOfTarget
	
]

{ #category : #metrics }
DtmID3DecisionTreeModel >> isAtEnd: aDataset [
	^ aDataset targetColumn uniqueValues size = 1 
		or: [ aDataset features isEmpty ]
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> numericalSplitterClass [	
	^ DtmMultiwaySplitter
]

{ #category : #splitting }
DtmID3DecisionTreeModel >> split: aDataset [
	"Recursively to build a decision tree"
	| bestSplit |
	(self isAtEnd: aDataset) ifTrue: [ ^ self defaultDecisionFor: aDataset ].
	bestSplit := self findBestSplitIn: aDataset.
	^ self buildNodeFor: aDataset splitingAt: bestSplit
]
