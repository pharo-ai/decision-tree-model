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
	self subclassResponsibility
]

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionFor: anObject [
	^ root decisionFor: anObject 
	
]

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionsForAll: aDataset [
	^ aDataset asArrayOfRows collect: [ :row | self decisionFor: row ].

]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> defaultDecisionFor: aDataset [
	self subclassResponsibility 
]

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> findBestSplitIn: aDataset [ 
	"Find best attribute to make the split in aDataset"
	
	| splitterScores splitter|
	splitterScores := aDataset features collect: [ :feature | 
		splitter := self splitterFor: aDataset atFeature: feature.
		splitter -> (splitter splitScoreFor: aDataset withModel: self)].
	splitterScores := splitterScores asDictionary.
	^ splitterScores keyAtIdentityValue: (splitterScores max)
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
	self subclassResponsibility
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root [
	^ root
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root: aDecisionTreeNode [ 
	^ root := aDecisionTreeNode
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
