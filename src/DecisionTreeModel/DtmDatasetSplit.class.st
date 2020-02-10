Class {
	#name : #DtmDatasetSplit,
	#superclass : #DtmDataset,
	#instVars : [
		'parent'
	],
	#category : #DecisionTreeModel
}

{ #category : #accessing }
DtmDatasetSplit >> features: aCollection [
	aCollection ifNil: [ ^ self setDefaultFeatures ].
	features := aCollection
]

{ #category : #accessing }
DtmDatasetSplit >> parent [
	^ parent
]

{ #category : #accessing }
DtmDatasetSplit >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
DtmDatasetSplit >> target: aName [
	"Will set the target variable to aName and will remove it from features"
	features := self features copyWithout: aName.
	target := aName
]
