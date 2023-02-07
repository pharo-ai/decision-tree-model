"
I am a Dataset that has been splitted. I have a reference to the dataset I was splitted from. 
"
Class {
	#name : #AIDTDatasetSplit,
	#superclass : #AIDTDataset,
	#instVars : [
		'parent'
	],
	#category : #'AI-DecisionTreeModel'
}

{ #category : #accessing }
AIDTDatasetSplit >> features: aCollection [
	features := aCollection
]

{ #category : #accessing }
AIDTDatasetSplit >> numberOfSplits [
	"How many times the dataset has been splitted"
	^ parent numberOfSplits + 1
]

{ #category : #accessing }
AIDTDatasetSplit >> parent [
	^ parent
]

{ #category : #accessing }
AIDTDatasetSplit >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
AIDTDatasetSplit >> possibleValuesForFeatureAt: aFeatureName [ 
	^ parent possibleValuesForFeatureAt: aFeatureName 
]

{ #category : #accessing }
AIDTDatasetSplit >> target: aName [
	"Will set the target variable to aName and will remove it from features"
	features := self features copyWithout: aName.
	target := aName
]
