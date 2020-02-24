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

{ #category : #api }
DtmAbstractRandomForest >> fit: aDataset [
	| tree randomSubset |
	trees := (1 to: numberOfTrees) collect: [
		tree := self treeClass new.
		randomSubset := self randomSubsetOf: aDataset.
		randomSubset features: (self randomFeturesOf: aDataset).
		tree fit: randomSubset.
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
