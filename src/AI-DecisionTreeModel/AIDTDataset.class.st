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
	#name : #AIDTDataset,
	#superclass : #Object,
	#instVars : [
		'datas',
		'columnNames',
		'target',
		'features'
	],
	#category : #'AI-DecisionTreeModel'
}

{ #category : #'instance creation' }
AIDTDataset class >> defaultFeaturesFor: anObject [
	^ anObject allUnarySelectors
]

{ #category : #'instance creation' }
AIDTDataset class >> fromArray: anArray [ 
	^ self fromArray: anArray withColumns: (self defaultFeaturesFor: anArray anyOne)
]

{ #category : #'instance creation' }
AIDTDataset class >> fromArray: anArray withColumns: anArrayOfSelectors [
	"Creates a DtmDataset each row is an element from anArray and each features is
	a selector from anArrayOfSelectors evaluated on the object"

	^ self withRows: (anArray collect: [ :each | anArrayOfSelectors collect: [ :selector | each perform: selector ] ]) withFeatures: anArrayOfSelectors
]

{ #category : #'instance creation' }
AIDTDataset class >> fromArray: anArray withFeatures: anArrayOfSelectors withTarget: aTargetSelector [
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
AIDTDataset class >> fromDataFrame: aDataFrame [

	^ self new withRows: aDataFrame asArray withFeatures: aDataFrame columnNames
]

{ #category : #'instance creation' }
AIDTDataset class >> withColumns: anArrayOfArrays withFeatures: anArrayOfFeatureNames [

	| rows |
	rows := Array new: anArrayOfArrays anyOne size.
	1 to: rows size do: [ :index | rows at: index put: (Array new: anArrayOfArrays size) ].
	anArrayOfArrays doWithIndex: [ :array :colIndex | array doWithIndex: [ :elem :rowIndex | (rows at: rowIndex) at: colIndex put: elem ] ].
	^ self withRows: rows withFeatures: anArrayOfFeatureNames
]

{ #category : #'instance creation' }
AIDTDataset class >> withRows: anArrayOfArrays withFeatures: anArrayOfFeatureNames [

	^ self new
		  datas: anArrayOfArrays;
		  columnNames: anArrayOfFeatureNames;
		  yourself
]

{ #category : #testing }
AIDTDataset >> allFeaturesAreEqual [
	"Return true if all examples have the same feature values"

	self size = 1 ifTrue: [ ^ true ].

	^ self features allSatisfy: [ :feature |
		  | value featureColumn |
		  featureColumn := self columnAt: feature.
		  value := featureColumn anyOne.
		  featureColumn allSatisfy: [ :each | each = value ] ]
]

{ #category : #accessing }
AIDTDataset >> asArrayOfRows [

	^ self datas collect: [ :data | Dictionary newFromKeys: self columnNames andValues: data ]
]

{ #category : #testing }
AIDTDataset >> checkIsFeature: aName [
	"Check if aName is currently a feature"

	^ self features includes: aName
]

{ #category : #testing }
AIDTDataset >> checkIsValidFeature: aName [
	"Check if aName is a valid name to set as a feature"

	^ (self columnNames includes: aName) and: [ target ~= aName ]
]

{ #category : #testing }
AIDTDataset >> checkIsValidTarget: aName [
	"Check if aName is a valid name to set as a target"

	^ (self columnNames includes: aName) or: [ aName isNil ]
]

{ #category : #accessing }
AIDTDataset >> columnAt: aName [

	| index |
	index := self columnNames indexOf: aName.
	^ datas collect: [ :data | data at: index ]
]

{ #category : #accessing }
AIDTDataset >> columnNames [
	^ columnNames
]

{ #category : #accessing }
AIDTDataset >> columnNames: anObject [
	columnNames := anObject
]

{ #category : #accessing }
AIDTDataset >> datas [
	^ datas
]

{ #category : #accessing }
AIDTDataset >> datas: anObject [

	datas := anObject deepCopy
]

{ #category : #accessing }
AIDTDataset >> defaultFeatures [

	^ self columnNames reject: [ :each | each = target ]
]

{ #category : #enumerating }
AIDTDataset >> do: aBlock [

	self datas do: [ :data | aBlock value: (Dictionary newFromKeys: self columnNames andValues: data) ]
]

{ #category : #testing }
AIDTDataset >> doesNotHaveFeatures [
	^ self features isEmpty
]

{ #category : #metrics }
AIDTDataset >> entropyOf: aColumnName [

	| targetColumn probabilities |
	self isEmpty ifTrue: [ ^ 0 ].
	targetColumn := self columnAt: aColumnName.
	probabilities := targetColumn asBag counts / targetColumn size.
	^ (probabilities * (probabilities collect: [ :proba | proba log: 2 ])) sum negated
]

{ #category : #metrics }
AIDTDataset >> entropyOfTarget [
	^ self entropyOf: target
]

{ #category : #accessing }
AIDTDataset >> featureAt: aName [
	^ self featureAt: aName ifAbsent: [ self featureNotFoundError: aName ]
	
]

{ #category : #accessing }
AIDTDataset >> featureAt: aName ifAbsent: aBlock [

	(self checkIsFeature: aName) ifFalse: aBlock.
	^ self columnAt: aName
]

{ #category : #accessing }
AIDTDataset >> featureAt: aName put: anArray [

	| col |
	col := self columnNames indexOf: aName.
	anArray doWithIndex: [ :replacement :row | (self datas at: row) at: col put: replacement ]
]

{ #category : #testing }
AIDTDataset >> featureHasOneValue: featureName [

	^ (self featureAt: featureName) asSet size = 1
]

{ #category : #exceptions }
AIDTDataset >> featureNotFoundError: aName [
	NotFound signalFor: aName
	
]

{ #category : #accessing }
AIDTDataset >> features [

	^ features ifNil: [ self defaultFeatures ]
]

{ #category : #accessing }
AIDTDataset >> features: aCollection [
	aCollection detect: [ :each | (self checkIsValidFeature: each) not ] 
		ifFound: [ :name | self invalidFeatureError: name ]
		ifNone: [ features := aCollection  ]
]

{ #category : #metrics }
AIDTDataset >> giniIndexOf: aColumnName [

	| targetColumn probabilities |
	self isEmpty ifTrue: [ ^ 0 ].
	targetColumn := self columnAt: aColumnName.
	probabilities := targetColumn asBag counts / targetColumn size.
	^ 1 - probabilities squared sum
]

{ #category : #metrics }
AIDTDataset >> giniIndexOfTarget [
	^ self giniIndexOf: self target
]

{ #category : #testing }
AIDTDataset >> ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock [

	^ self datas ifEmpty: emptyBlock ifNotEmpty: notEmptyBlock
]

{ #category : #exceptions }
AIDTDataset >> invalidFeatureError: aName [

	Error signal: aName , ' is not a valid feature name.'
]

{ #category : #exceptions }
AIDTDataset >> invalidTargetError: aName [

	Error signal: aName , ' is not a valid target name.'
]

{ #category : #testing }
AIDTDataset >> isEmpty [
	^ self datas isEmpty 
]

{ #category : #accessing }
AIDTDataset >> numberOfSplits [
	"How many times the dataset has been splitted"
	^ 0
]

{ #category : #accessing }
AIDTDataset >> possibleValuesForFeatureAt: aFeatureName [

	^ (self featureAt: aFeatureName) asSet
]

{ #category : #enumerating }
AIDTDataset >> reject: aBlock [

	| selectedRows |
	selectedRows := self datas reject: [ :data | aBlock value: (Dictionary newFromKeys: self columnNames andValues: data) ].
	^ (self class withRows: selectedRows withFeatures: self columnNames)
		  target: target;
		  features: self features;
		  yourself
]

{ #category : #testing }
AIDTDataset >> resetFeatures [
	features := nil
]

{ #category : #enumerating }
AIDTDataset >> select: aBlock [

	| selectedRows |
	selectedRows := self datas select: [ :data | aBlock value: (Dictionary newFromKeys: self columnNames andValues: data) ].
	^ (self class withRows: selectedRows withFeatures: self columnNames)
		  target: target;
		  features: self features;
		  yourself
]

{ #category : #accessing }
AIDTDataset >> size [

	^ self datas size
]

{ #category : #enumerating }
AIDTDataset >> split: aBlock [

	| selectedRows |
	selectedRows := self datas select: [ :data | aBlock value: (Dictionary newFromKeys: self columnNames andValues: data) ].
	^ (self splitClass withRows: selectedRows withFeatures: self columnNames)
		  target: target;
		  features: self features;
		  parent: self;
		  yourself
]

{ #category : #accessing }
AIDTDataset >> splitClass [
	^ AIDTDatasetSplit
]

{ #category : #accessing }
AIDTDataset >> target [
	^ target
]

{ #category : #accessing }
AIDTDataset >> target: aName [
	"Will set the target variable to aName and will remove it from features"
	(self checkIsValidTarget: aName) ifFalse: [ self invalidTargetError: aName ].
	features := self features copyWithout: aName.
	target := aName
]

{ #category : #accessing }
AIDTDataset >> targetColumn [
	^ self columnAt: target
]

{ #category : #testing }
AIDTDataset >> targetHasOneLabel [

	^ self targetColumn asSet size = 1
]
