"
I represent a container for dataset that is going to be used for classification

I know the data that wants to be used for trainning or classifying a dataset. I know which variables are going to be used as features and which is going to be the target variable for classification. I am responsible for handling operations over the data, like making splits on the data or calculating metrics over the features/target variable.

Since the data for classification follows a tabular structure, this is stored inside a DataFrame object. I can be created directly from a DataFrame or from Array of objects.

Public API and Key Messages

	Creation of instances (class side):
		- fromDataFrame: aDataFrame (creates a dataset with data from aDataFrame)
		- fromArray: anArray withColumns: anArrayOfSelectors (creates a Dataset where each row is an object in anArray and each column the evaluation of a selector)
		- fromArray: anArray withFeatures: anArrayOfSelectors withTarget: aTargetSelector (creates a Dataset from objects in Array with features and target already set)
 
Internal Representation and Key Implementation Points.

    Instance Variables
	dataframe:	<DataFrame>
	features:		<Collection>
	target:		<Object>


    Implementation Points
	DataFrame is used to store the tabular data.
"
Class {
	#name : #DtmDataset,
	#superclass : #Object,
	#instVars : [
		'dataframe',
		'target',
		'features'
	],
	#category : #DecisionTreeModel
}

{ #category : #'instance creation' }
DtmDataset class >> defaultDataFrameClass [
	^ DataFrame 
]

{ #category : #'instance creation' }
DtmDataset class >> defaultFeaturesFor: anObject [
	^ anObject allUnarySelectors
]

{ #category : #'instance creation' }
DtmDataset class >> fromArray: anArray [ 
	^ self fromArray: anArray withColumns: (self defaultFeaturesFor: anArray anyOne)
]

{ #category : #'instance creation' }
DtmDataset class >> fromArray: anArray withColumns: anArrayOfSelectors [
	"Creates a DtmDataset each row is an element from anArray and each features is
	a selector from anArrayOfSelectors evaluated on the object"
	| valuesForDataFrame newDataFrame|
	valuesForDataFrame := anArray collect: [:each | anArrayOfSelectors collect: [ :selector | each perform: selector ] ].
	newDataFrame := self defaultDataFrameClass withRows: valuesForDataFrame columnNames: anArrayOfSelectors.
	^ self new dataframe: newDataFrame; yourself
]

{ #category : #'instance creation' }
DtmDataset class >> fromArray: anArray withFeatures: anArrayOfSelectors withTarget: aTargetSelector [
	"Creates a DtmDataset each row is an element from anArray and each features is
	a selector from anArrayOfSelectors evaluated on the object"
	| columnNames |
	columnNames := anArrayOfSelectors , { aTargetSelector }.
	^ (self fromArray: anArray withColumns: columnNames) 
		target: aTargetSelector; 
		features: anArrayOfSelectors;
		yourself
]

{ #category : #'instance creation' }
DtmDataset class >> fromDataFrame: aDataFrame [
	^ self new dataframe: aDataFrame; yourself 
]

{ #category : #'instance creation' }
DtmDataset class >> withColumns: anArrayOfArrays withFeatures: anArrayOfFeatureNames [
	| newDataFrame |
	newDataFrame := self defaultDataFrameClass withColumns: anArrayOfArrays columnNames: anArrayOfFeatureNames.
	^ self new dataframe: newDataFrame; yourself
]

{ #category : #'instance creation' }
DtmDataset class >> withRows: anArrayOfArrays withFeatures: anArrayOfFeatureNames [
	| newDataFrame |
	newDataFrame := self defaultDataFrameClass withRows: anArrayOfArrays columnNames: anArrayOfFeatureNames.
	^ self new dataframe: newDataFrame; yourself
]

{ #category : #accessing }
DtmDataset >> asArrayOfRows [ 
	^ dataframe asArrayOfRows
]

{ #category : #testing }
DtmDataset >> checkIsFeature: aName [
	"Check if aName is currently a feature"
	^ self features includes: aName
]

{ #category : #testing }
DtmDataset >> checkIsValidFeature: aName [
	"Check if aName is a valid name to set as a feature"
	^ (dataframe columnNames includes: aName) and: [ target ~= aName ]
]

{ #category : #testing }
DtmDataset >> checkIsValidTarget: aName [
	"Check if aName is a valid name to set as a target"
	^ (dataframe columnNames includes: aName) or: [ aName isNil ]
]

{ #category : #accessing }
DtmDataset >> columnAt: aName [
	^ dataframe column: aName
	
]

{ #category : #accessing }
DtmDataset >> dataframe [
	^ dataframe
]

{ #category : #accessing }
DtmDataset >> dataframe: aDataFrame [
	dataframe := aDataFrame
]

{ #category : #accessing }
DtmDataset >> defaultFeatures [
	^ dataframe columnNames reject: [ :each | each = target  ]
]

{ #category : #enumerating }
DtmDataset >> do: aBlock [
	self dataframe do: aBlock 
]

{ #category : #testing }
DtmDataset >> doesNotHaveFeatures [
	^ self features isEmpty
]

{ #category : #metrics }
DtmDataset >> entropyOf: aColumnName [
	| targetColumn probabilities |
	self isEmpty ifTrue: [ ^ 0 ].
	targetColumn := self dataframe column: aColumnName.
	probabilities := targetColumn valueCounts / targetColumn size.
	^ (probabilities * (probabilities log: 2)) sum negated
]

{ #category : #metrics }
DtmDataset >> entropyOfTarget [
	^ self entropyOf: target
]

{ #category : #accessing }
DtmDataset >> featureAt: aName [
	^ self featureAt: aName ifAbsent: [ self featureNotFoundError: aName ]
	
]

{ #category : #accessing }
DtmDataset >> featureAt: aName ifAbsent: aBlock [
	(self checkIsFeature: aName) ifFalse: aBlock.
	^ self dataframe column: aName
	
]

{ #category : #accessing }
DtmDataset >> featureAt: aName put: anAray [
	^ self dataframe column: aName put: anAray 
	
]

{ #category : #testing }
DtmDataset >> featureHasOneValue: featureName [
	^ (self featureAt: featureName) uniqueValues size = 1 
]

{ #category : #exceptions }
DtmDataset >> featureNotFoundError: aName [
	NotFound signalFor: aName
	
]

{ #category : #accessing }
DtmDataset >> features [
	^ features ifNil: [self defaultFeatures]
]

{ #category : #accessing }
DtmDataset >> features: aCollection [
	aCollection detect: [ :each | (self checkIsValidFeature: each) not ] 
		ifFound: [ :name | self invalidFeatureError: name ]
		ifNone: [ features := aCollection  ]
]

{ #category : #metrics }
DtmDataset >> giniIndexOf: aColumnName [
	| targetColumn probabilities |
	self isEmpty ifTrue: [ ^ 0 ].
	targetColumn := self dataframe column: aColumnName.
	probabilities := targetColumn valueCounts / targetColumn size.
	^ 1 - (probabilities squared sum)
]

{ #category : #metrics }
DtmDataset >> giniIndexOfTarget [
	^ self giniIndexOf: target
]

{ #category : #testing }
DtmDataset >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [
	^ dataframe ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock
]

{ #category : #exceptions }
DtmDataset >> invalidFeatureError: aName [
	Error signal: aName, ' is not a valid feature name.'
	
]

{ #category : #exceptions }
DtmDataset >> invalidTargetError: aName [
	Error signal: (aName, ' is not a valid target name.')
	
]

{ #category : #testing }
DtmDataset >> isEmpty [
	^ dataframe isEmpty 
]

{ #category : #accessing }
DtmDataset >> numberOfSplits [
	"How many times the dataset has been splitted"
	^ 0
]

{ #category : #accessing }
DtmDataset >> possibleValuesForFeatureAt: aFeatureName [ 
	^ (self featureAt: aFeatureName) uniqueValues 
]

{ #category : #enumerating }
DtmDataset >> reject: aBlock [
	| selectedRows |
	selectedRows := self dataframe reject: aBlock.
	^ (self splitClass fromDataFrame: selectedRows)
		target: target; 
		features: features;
		parent: self;
		yourself
]

{ #category : #enumerating }
DtmDataset >> select: aBlock [
	| selectedRows |
	selectedRows := self dataframe select: aBlock.
	^ (self splitClass fromDataFrame: selectedRows)
		target: target; 
		features: self features;
		parent: self;
		yourself
]

{ #category : #enumerating }
DtmDataset >> selectRows: aRowBlock selectFeatures: aFeaturesBlock [
	| selectedRows |
	selectedRows := self dataframe select: aRowBlock.
	^ (self splitClass fromDataFrame: selectedRows)
		target: target; 
		features: (features select: aFeaturesBlock);
		parent: self;
		yourself
]

{ #category : #accessing }
DtmDataset >> size [
	^ dataframe size
]

{ #category : #accessing }
DtmDataset >> splitClass [
	^ DtmDatasetSplit
]

{ #category : #accessing }
DtmDataset >> target [
	^ target
]

{ #category : #accessing }
DtmDataset >> target: aName [
	"Will set the target variable to aName and will remove it from features"
	(self checkIsValidTarget: aName) ifFalse: [ self invalidTargetError: aName ].
	features := self features copyWithout: aName.
	target := aName
]

{ #category : #accessing }
DtmDataset >> targetColumn [
	^ self columnAt: target
]

{ #category : #testing }
DtmDataset >> targetHasOneLabel [
	^ self targetColumn uniqueValues size = 1 
]
