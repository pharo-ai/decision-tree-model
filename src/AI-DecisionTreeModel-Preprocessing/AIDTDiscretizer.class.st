"
I am a discretizer of a dataset

I am responsible of handling how to discretize one or more columns of a dataset. I have a ColumnDiscretizer for each discretizable column of a dataset. My responsability is to call each ColumnDiscretizer to fit or transform the data.


"
Class {
	#name : #AIDTDiscretizer,
	#superclass : #Object,
	#instVars : [
		'columnDiscretizers'
	],
	#category : #'AI-DecisionTreeModel-Preprocessing'
}

{ #category : #accessing }
AIDTDiscretizer >> columnDiscretizers [
	^ columnDiscretizers
]

{ #category : #accessing }
AIDTDiscretizer >> discretizableColumnsOf: aDataset [

	^ aDataset features select: [ :each | (aDataset featureAt: each) allSatisfy: #isNumber ]
]

{ #category : #'computing - fit' }
AIDTDiscretizer >> discretizerAt: aKey fit: aCollection [
	(columnDiscretizers at: aKey ifAbsentPut: [self newColumnDiscretizer]) fit: aCollection 
]

{ #category : #'computing - transform' }
AIDTDiscretizer >> discretizerAt: aKey transform: aCollection [
	^ (columnDiscretizers at: aKey) transform: aCollection 
]

{ #category : #api }
AIDTDiscretizer >> fit: aDataset [
	self fitColumnsOf: aDataset
]

{ #category : #api }
AIDTDiscretizer >> fit: aDataset atFeatures: aCollection [
	self fitColumnsOf: aDataset at: aCollection
]

{ #category : #'computing - fit' }
AIDTDiscretizer >> fitColumnsOf: aDataset [
	self fitColumnsOf: aDataset at: (self discretizableColumnsOf: aDataset)
]

{ #category : #'computing - fit' }
AIDTDiscretizer >> fitColumnsOf: aDataset at: aCollection [
	aCollection do: [ :each | self discretizerAt: each fit: (aDataset featureAt: each )]
]

{ #category : #api }
AIDTDiscretizer >> fitTransform: aDataset [
	self fit: aDataset; transform: aDataset
	
]

{ #category : #initialization }
AIDTDiscretizer >> initialize [
	super initialize.
	columnDiscretizers := Dictionary new.
]

{ #category : #testing }
AIDTDiscretizer >> isEmpty [ 
	^ columnDiscretizers isEmpty 
]

{ #category : #accessing }
AIDTDiscretizer >> newColumnDiscretizer [
	^ AIDTColumnDiscretizer new
]

{ #category : #api }
AIDTDiscretizer >> transform: aDataset [
	self transformColumnsOf: aDataset
]

{ #category : #api }
AIDTDiscretizer >> transform: aDataset atFeatures: aCollection [
	self transformColumnsOf: aDataset atFeatures: aCollection
]

{ #category : #'computing - transform' }
AIDTDiscretizer >> transformColumnsOf: aDataset [
	self transformColumnsOf: aDataset atFeatures: (self transformableColumnsOf: aDataset)
]

{ #category : #'computing - transform' }
AIDTDiscretizer >> transformColumnsOf: aDataset atFeatures: aCollection [
	| newColumn |
	aCollection do: [ :each | 
		newColumn := self discretizerAt: each transform: (aDataset featureAt: each ).
		aDataset featureAt: each put: newColumn ]
]

{ #category : #accessing }
AIDTDiscretizer >> transformableColumnsOf: aDataset [
	^ columnDiscretizers keys
]
