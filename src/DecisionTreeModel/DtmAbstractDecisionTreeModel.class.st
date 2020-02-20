"
I represent an abstract decision tree learning model.

My subclasses have a DecisionTree at the root. Each subclass is responsible to implement the methods to build the corresponding DecisionTree from a Dataset. My subclasses are responsible of how to handle categorical/numerical variables, what impurity measure to use to make the splits and which is the default Decision to return.

My main collaboration is with DecisionTree: My subclasses build a tree from a dataset and this is stored in root. To classify future examples they pass the example to the tree. 
"
Class {
	#name : #DtmAbstractDecisionTreeModel,
	#superclass : #Object,
	#instVars : [
		'root',
		'minSizeForSplit',
		'maxDepth'
	],
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> buildNodeFor: aDatasetSplit [
	^ aDatasetSplit
		ifEmpty: [ self defaultDecisionFor: aDatasetSplit parent ]
		ifNotEmpty: [ self split: aDatasetSplit ].
			
]

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> buildNodeFor: aDataset splitingAt: aSplitter [
	"Handle the creation of a node at catgorical/numerical feature"
	^ aSplitter buildNodeFor: aDataset inModel: self.
]

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> categoricalSplitterClass [
	"Specify the class to handles the splitting of a categorical variable"
	self subclassResponsibility
]

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionFor: anObject [
	"Passes anObject to decision tree to assign corresponding label"
	^ root decisionFor: anObject 
	
]

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionsForAll: aDataset [
	^ aDataset asArrayOfRows collect: [ :row | self decisionFor: row ].

]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> defaultDecisionFor: aDataset [
	^ DtmDecision withLabel: aDataset targetColumn mode
]

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> findBestSplitIn: aDataset [ 
	"Find best attribute to make the split in aDataset"
	
	| splitterScores splitter|
	splitterScores := aDataset features collect: [ :feature | 
		splitter := self splitterFor: aDataset atFeature: feature.
		splitter -> (splitter splitScoreFor: aDataset withModel: self)].
	splitterScores := splitterScores asDictionary.
	^ splitterScores keyAtIdentityValue: splitterScores max
]

{ #category : #api }
DtmAbstractDecisionTreeModel >> fit: aDataset [
	root := self split: aDataset 
	
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> gainMeasureOf: aDataset given: aSplitter [
	"By default, all decision trees use Information Gain as a gain measure"
	| gainMeasure impurityOfSplit |
	
	gainMeasure := self impurityMeasureOf: aDataset.
	aSplitter forDataset: aDataset splitsDo: [:datasetSplit | 
		impurityOfSplit := self impurityMeasureOf: datasetSplit.
		gainMeasure := gainMeasure - ((datasetSplit size / aDataset size) * impurityOfSplit).
	].
	^ gainMeasure
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> impurityMeasureOf: aDataset [
	self subclassResponsibility 
]

{ #category : #initialization }
DtmAbstractDecisionTreeModel >> initialize [
	super initialize.
	minSizeForSplit := 0.
	maxDepth := Float infinity.
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> isAtEnd: aDataset [
	"Conditions to stop splitting a dataset"
	^ aDataset targetHasOneLabel
		or: [ aDataset doesNotHaveFeatures
			or: [ aDataset numberOfSplits >= maxDepth 
				or: [ aDataset size < minSizeForSplit ] ] ]
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> maxDepth [
	^ maxDepth
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> maxDepth: aNumber [
	maxDepth := aNumber
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> minSizeForSplit [
	^ minSizeForSplit
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> minSizeForSplit: aNumber [
	minSizeForSplit := aNumber
]

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> numericalSplitterClass [	
	"Specify the class to handles the splitting of a numerical variable"
	self subclassResponsibility
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root [
	^ root
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root: aDecisionTreeNode [ 
	root := aDecisionTreeNode
]

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> split: aDataset [
	"Recursively to build a decision tree"
	| bestSplit |
	(self isAtEnd: aDataset) ifTrue: [ ^ self defaultDecisionFor: aDataset ].
	bestSplit := self findBestSplitIn: aDataset.
	^ self buildNodeFor: aDataset splitingAt: bestSplit
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> splitterFor: aDataset atFeature: aFeatureName [
	"Return the corresponding splitter strategy for numerical/categorical feature"
	| splitterClass |
	splitterClass := (aDataset featureAt: aFeatureName) isNumerical 
		ifTrue: [ self numericalSplitterClass ]
		ifFalse: [ self categoricalSplitterClass ]. 
	^ splitterClass forFeature: aFeatureName
]
