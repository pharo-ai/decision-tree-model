Class {
	#name : #DtmColumnDiscretizer,
	#superclass : #Object,
	#instVars : [
		'min',
		'max',
		'step',
		'numberOfBins',
		'bins'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmColumnDiscretizer class >> withNumberOfBins: anInteger [
	^ self new numberOfBins: anInteger; yourself 
]

{ #category : #accessing }
DtmColumnDiscretizer >> defaultFirstBin [
	^ DtmInterval min: Float negativeInfinity max: min + self step
]

{ #category : #accessing }
DtmColumnDiscretizer >> defaultLastBin [
	^ DtmInterval min: max - self step max: Float infinity 
]

{ #category : #api }
DtmColumnDiscretizer >> fit: aCollection [
	min := aCollection min.
	max := aCollection max.
	self setBins.
	
]

{ #category : #api }
DtmColumnDiscretizer >> fitTransform: aCollection [
	self fit: aCollection.
	^ self transform: aCollection
]

{ #category : #initialization }
DtmColumnDiscretizer >> initialize [ 
	super initialize.
	numberOfBins := 5
]

{ #category : #accessing }
DtmColumnDiscretizer >> isFitted [ 
	^ max isNotNil and: [ min isNotNil ]
]

{ #category : #accessing }
DtmColumnDiscretizer >> newBinAt: aNumber [
	aNumber = 1 ifTrue: [ ^ self defaultFirstBin ].
	aNumber = numberOfBins ifTrue: [ ^ self defaultLastBin ].
	^ DtmInterval 
		min: (min + (step * (aNumber - 1))) 
		max: (min + (step * aNumber))
]

{ #category : #accessing }
DtmColumnDiscretizer >> numberOfBins: anInteger [
	numberOfBins := anInteger
]

{ #category : #accessing }
DtmColumnDiscretizer >> setBins [
	bins := OrderedCollection new.
	1 to: numberOfBins do: [ :each |
		 bins add: (self newBinAt: each)
	]
]

{ #category : #accessing }
DtmColumnDiscretizer >> step [
	^ step ifNil: [step := (max - min) / numberOfBins]
]

{ #category : #api }
DtmColumnDiscretizer >> transform: aCollection [
	self isFitted ifFalse: [ Exception signal: 'Discretizer must be fitted before transforming data.'].
	^ aCollection collect: [ :each | bins detect: [:bin | bin includes: each]]
]
