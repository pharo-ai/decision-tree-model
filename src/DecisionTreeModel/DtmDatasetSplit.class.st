"
I am a Dataset that has been splitted. I have a reference to the dataset I was splitted from. 
"
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
	features := aCollection
]

{ #category : #accessing }
DtmDatasetSplit >> numberOfSplits [
	"How many times the dataset has been splitted"
	^ parent numberOfSplits + 1
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
DtmDatasetSplit >> possibleValuesForFeatureAt: aFeatureName [ 
	^ parent possibleValuesForFeatureAt: aFeatureName 
]

{ #category : #accessing }
DtmDatasetSplit >> target: aName [
	"Will set the target variable to aName and will remove it from features"
	features := self features copyWithout: aName.
	target := aName
]
