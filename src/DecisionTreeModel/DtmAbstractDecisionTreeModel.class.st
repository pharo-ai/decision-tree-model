Class {
	#name : #DtmAbstractDecisionTreeModel,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> buildNodeFor: aDataset splitingAt: aFeatureName [
	"Should specify how to act when splitting at features that are categorical/numerical"
	self subclassResponsibility
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

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> findBestSplitIn: aDataset [ 
	"Find best attribute to make the split in aDataset"
	
	| splitterScores splitter|
	splitterScores := aDataset features collect: [ :feature | 
		splitter := self splitterFor: aDataset atFeature: feature.
		splitter -> (splitter bestSplitScoreFor: aDataset withModel: self)].
	splitterScores := splitterScores asDictionary.
	^ splitterScores keyAtIdentityValue: (splitterScores max)
]

{ #category : #api }
DtmAbstractDecisionTreeModel >> fit: aDataset [
	self subclassResponsibility 
	
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

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> splitterFor: aDataset atFeature: aFeatureName [
	"Return the corresponding splitter strategy for numerical//categorical feature"
	| splitterClass |
	splitterClass := (aDataset featureAt: aFeatureName) isNumerical 
		ifTrue: [ self numericalSplitterClass ]
		ifFalse: [ self categoricalSplitterClass ]. 
	^ splitterClass forFeature: aFeatureName
]
