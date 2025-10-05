"
I represent an abstract decision tree learning model.

My subclasses have a DecisionTree at the root. Each subclass is responsible to implement the methods to build the corresponding DecisionTree from a Dataset. My subclasses are responsible of how to handle categorical/numerical variables, what impurity measure to use to make the splits and which is the default Decision to return.

My main collaboration is with DecisionTree: My subclasses build a tree from a dataset and this is stored in root. To classify future examples they pass the example to the tree. 
"
Class {
	#name : 'AIDTAbstractDecisionTreeModel',
	#superclass : 'Object',
	#instVars : [
		'root',
		'minSizeForSplit',
		'maxDepth'
	],
	#category : 'AI-DecisionTreeModel',
	#package : 'AI-DecisionTreeModel'
}

{ #category : 'splitting' }
AIDTAbstractDecisionTreeModel >> buildNodeFor: aDatasetSplit [
	^ aDatasetSplit
		ifEmpty: [ self defaultDecisionFor: aDatasetSplit parent ]
		ifNotEmpty: [ self buildTreeFor: aDatasetSplit ]
]

{ #category : 'splitting' }
AIDTAbstractDecisionTreeModel >> buildNodeFor: aDataset splitingAt: aSplitter [
	"Handle the creation of a node at catgorical/numerical feature"
	^ aSplitter buildNodeFor: aDataset inModel: self
]

{ #category : 'splitting' }
AIDTAbstractDecisionTreeModel >> buildTreeFor: aDataset [
	"Recursively to build a decision tree"
	| bestSplit |
	(self isAtEnd: aDataset) ifTrue: [ ^ self defaultDecisionFor: aDataset ].
	bestSplit := self findBestSplitIn: aDataset.
	^ self buildNodeFor: aDataset splitingAt: bestSplit
]

{ #category : 'splitting' }
AIDTAbstractDecisionTreeModel >> categoricalSplitterClass [
	"Specify the class to handles the splitting of a categorical variable"
	self subclassResponsibility
]

{ #category : 'classification' }
AIDTAbstractDecisionTreeModel >> decisionFor: anObject [
	"Passes anObject to decision tree to assign corresponding label"
	^ root decisionFor: anObject
]

{ #category : 'classification' }
AIDTAbstractDecisionTreeModel >> decisionsForAll: aDataset [
	^ aDataset asArrayOfRows collect: [ :row | self decisionFor: row ]
]

{ #category : 'classification' }
AIDTAbstractDecisionTreeModel >> defaultDecisionFor: aDataset [

	^ AIDTDecision withLabel: aDataset targetColumn asBag sortedCounts first value
]

{ #category : 'splitting' }
AIDTAbstractDecisionTreeModel >> findBestSplitIn: aDataset [
	"Find best attribute to make the split in aDataset"

	| splitterScores splitter|
	splitterScores := aDataset features collect: [ :feature |
		splitter := self splitterFor: aDataset atFeature: feature.
		splitter -> (splitter splitScoreFor: aDataset withModel: self)].
	splitterScores := splitterScores asDictionary.
	^ splitterScores keyAtIdentityValue: splitterScores max
]

{ #category : 'api' }
AIDTAbstractDecisionTreeModel >> fit: aDataset [
	root := self buildTreeFor: aDataset
]

{ #category : 'metrics' }
AIDTAbstractDecisionTreeModel >> gainMeasureOf: aDataset given: aSplitter [
	"By default, all decision trees use Information Gain as a gain measure"
	| gainMeasure impurityOfSplit |

	gainMeasure := self impurityMeasureOf: aDataset.
	aSplitter forDataset: aDataset splitsDo: [:datasetSplit |
		impurityOfSplit := self impurityMeasureOf: datasetSplit.
		gainMeasure := gainMeasure - ((datasetSplit size / aDataset size) * impurityOfSplit).
	].
	^ gainMeasure
]

{ #category : 'metrics' }
AIDTAbstractDecisionTreeModel >> impurityMeasureOf: aDataset [
	self subclassResponsibility
]

{ #category : 'initialization' }
AIDTAbstractDecisionTreeModel >> initialize [
	super initialize.
	minSizeForSplit := 0.
	maxDepth := Float infinity
]

{ #category : 'splitting' }
AIDTAbstractDecisionTreeModel >> isAtEnd: aDataset [
	"Conditions to stop splitting a dataset"
	^ aDataset doesNotHaveFeatures
		or: [ aDataset targetHasOneLabel
			or: [ aDataset allFeaturesAreEqual
				or: [ aDataset numberOfSplits >= maxDepth
					or: [ aDataset size < minSizeForSplit ] ] ] ]
]

{ #category : 'accessing' }
AIDTAbstractDecisionTreeModel >> maxDepth [
	^ maxDepth
]

{ #category : 'accessing' }
AIDTAbstractDecisionTreeModel >> maxDepth: aNumber [
	maxDepth := aNumber
]

{ #category : 'accessing' }
AIDTAbstractDecisionTreeModel >> minSizeForSplit [
	^ minSizeForSplit
]

{ #category : 'accessing' }
AIDTAbstractDecisionTreeModel >> minSizeForSplit: aNumber [
	minSizeForSplit := aNumber
]

{ #category : 'splitting' }
AIDTAbstractDecisionTreeModel >> numericalSplitterClass [
	"Specify the class to handles the splitting of a numerical variable"
	self subclassResponsibility
]

{ #category : 'accessing' }
AIDTAbstractDecisionTreeModel >> root [
	^ root
]

{ #category : 'accessing' }
AIDTAbstractDecisionTreeModel >> root: aDecisionTreeNode [
	root := aDecisionTreeNode
]

{ #category : 'metrics' }
AIDTAbstractDecisionTreeModel >> splitterFor: aDataset atFeature: aFeatureName [
	"Return the corresponding splitter strategy for numerical/categorical feature"

	| splitterClass |
	splitterClass := ((aDataset featureAt: aFeatureName) allSatisfy: #isNumber)
		                 ifTrue: [ self numericalSplitterClass ]
		                 ifFalse: [ self categoricalSplitterClass ].
	^ splitterClass forFeature: aFeatureName
]
