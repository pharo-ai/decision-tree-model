Class {
	#name : #DtmDiscretizer,
	#superclass : #Object,
	#instVars : [
		'columnDiscretizers'
	],
	#category : #DecisionTreeModel
}

{ #category : #accessing }
DtmDiscretizer >> discretizableColumnsOf: aDataset [
	^ aDataset features select: [ :each | (aDataset featureAt: each) isNumerical ]
]

{ #category : #'computing - fit' }
DtmDiscretizer >> discretizerAt: aKey fit: aCollection [
	(columnDiscretizers at: aKey ifAbsentPut: [self newColumnDiscretizer]) fit: aCollection 
]

{ #category : #'computing - transform' }
DtmDiscretizer >> discretizerAt: aKey transform: aCollection [
	^ (columnDiscretizers at: aKey) transform: aCollection 
]

{ #category : #'computing - fit' }
DtmDiscretizer >> fit: aDataset [
	self fitColumnsOf: aDataset
]

{ #category : #'computing - fit' }
DtmDiscretizer >> fit: aDataset at: aCollection [
	self fitColumnsOf: aDataset at: aCollection
]

{ #category : #'computing - fit' }
DtmDiscretizer >> fitColumnsOf: aDataset [
	self fitColumnsOf: aDataset at: (self discretizableColumnsOf: aDataset)
]

{ #category : #'computing - fit' }
DtmDiscretizer >> fitColumnsOf: aDataset at: aCollection [
	aCollection do: [ :each | self discretizerAt: each fit: (aDataset featureAt: each )]
]

{ #category : #initialization }
DtmDiscretizer >> initialize [
	super initialize.
	columnDiscretizers := Dictionary new.
]

{ #category : #testing }
DtmDiscretizer >> isEmpty [ 
	^ columnDiscretizers isEmpty 
]

{ #category : #accessing }
DtmDiscretizer >> newColumnDiscretizer [
	^ DtmColumnDiscretizer new
]

{ #category : #'computing - transform' }
DtmDiscretizer >> transform: aDataset [
	self transformColumnsOf: aDataset
]

{ #category : #'computing - transform' }
DtmDiscretizer >> transform: aDataset atFeatures: aCollection [
	self transformColumnsOf: aDataset atFeatures: aCollection
]

{ #category : #'computing - transform' }
DtmDiscretizer >> transformColumnsOf: aDataset [
	self transformColumnsOf: aDataset atFeatures: (self transformableColumnsOf: aDataset)
]

{ #category : #'computing - transform' }
DtmDiscretizer >> transformColumnsOf: aDataset atFeatures: aCollection [
	| newColumn |
	aCollection do: [ :each | 
		newColumn := self discretizerAt: each transform: (aDataset featureAt: each ).
		aDataset featureAt: each put: newColumn ]
]

{ #category : #accessing }
DtmDiscretizer >> transformableColumnsOf: aDataset [
	^ columnDiscretizers keys
]
