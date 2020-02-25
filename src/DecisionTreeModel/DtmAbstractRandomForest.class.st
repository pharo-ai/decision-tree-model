Class {
	#name : #DtmAbstractRandomForest,
	#superclass : #Object,
	#instVars : [
		'trees',
		'minSizeForSplit',
		'maxDepth',
		'numberOfTrees'
	],
	#category : #DecisionTreeModel
}

{ #category : #bagging }
DtmAbstractRandomForest >> bootstrap: aDataset [
	"Select random examples from dataset WITH replacement (allows repeated examples)"
	| randomIndices| 
	randomIndices := (1 to: (self bootstrapSize: aDataset)) collect: [ :each |  
		(1 to: aDataset size) atRandom. 
	].
	^ aDataset rowsAt: randomIndices
]

{ #category : #bagging }
DtmAbstractRandomForest >> bootstrapSize: aDataset [
	"By using the size of the whole dataset it is expected that 
	each bootstrap will have 63.2% unique examples, the rest being duplicates."
	^ aDataset size
]

{ #category : #bagging }
DtmAbstractRandomForest >> featureSubsetSize: aDataset [
	"Specify a number of features that is considerably less than the original size
	It is usual practice to use the square root of the original amount of features"
	^ aDataset features size sqrtFloor 
]

{ #category : #api }
DtmAbstractRandomForest >> fit: aDataset [
	| tree randomSubset |
	trees := (1 to: numberOfTrees) collect: [ :each |
		tree := self treeClass new. 
		randomSubset := self bootstrap: aDataset.
		randomSubset features: (self randomFeaturesOf: aDataset).
		tree 
			fit: randomSubset; 
			yourself.
	]
]

{ #category : #initialization }
DtmAbstractRandomForest >> initialize [
	super initialize.
	numberOfTrees := 100.
	minSizeForSplit := 0.
	maxDepth := Float infinity.
]

{ #category : #accessing }
DtmAbstractRandomForest >> maxDepth [
	^ maxDepth
]

{ #category : #accessing }
DtmAbstractRandomForest >> maxDepth: anObject [
	maxDepth := anObject
]

{ #category : #accessing }
DtmAbstractRandomForest >> minSizeForSplit [
	^ minSizeForSplit
]

{ #category : #accessing }
DtmAbstractRandomForest >> minSizeForSplit: anObject [
	minSizeForSplit := anObject
]

{ #category : #accessing }
DtmAbstractRandomForest >> numberOfTrees [
	^ numberOfTrees
]

{ #category : #accessing }
DtmAbstractRandomForest >> numberOfTrees: anObject [
	numberOfTrees := anObject
]

{ #category : #bagging }
DtmAbstractRandomForest >> randomFeaturesOf: aDataset [
	"Return random subset of the features"
	^ aDataset features shuffled first: (self featureSubsetSize: aDataset)
]

{ #category : #accessing }
DtmAbstractRandomForest >> treeClass [
	self subclassResponsibility 
]
