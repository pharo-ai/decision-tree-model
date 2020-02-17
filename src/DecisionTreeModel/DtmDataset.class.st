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
DtmDataset >> checkAllAreValidFeatures: aCollection [ 
	^ aCollection allSatisfy: [ :each | self checkIsFeature: each ]
]

{ #category : #testing }
DtmDataset >> checkIsFeature: aName [
	^ self features includes: aName
]

{ #category : #testing }
DtmDataset >> checkIsValidFeature: aName [
	^ (dataframe columnNames includes: aName) and: [ target ~= aName ]
]

{ #category : #testing }
DtmDataset >> checkIsValidTarget: aName [
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
	^ self dataframe do: aBlock 
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
	aCollection ifNil: [ ^ self setDefaultFeatures ].
	aCollection detect: [ :each | (self checkIsValidFeature: each) not ] 
		ifFound: [ :name | self invalidFeatureError: name ]
		ifNone: [ features := aCollection  ]
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
		features: (self features);
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

{ #category : #'as yet unclassified' }
DtmDataset >> setDefaultFeatures [
	features := nil
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
