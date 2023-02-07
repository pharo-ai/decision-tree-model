"
I am a discretizer of a single column.

I am responsible of handling how to discretize a single column of a dataset. I know how many bins to use for the discretization. 

Each bin used for discretization is represented by an Interval object, that knows its upper and lower limit.
"
Class {
	#name : #AIDTColumnDiscretizer,
	#superclass : #Object,
	#instVars : [
		'min',
		'max',
		'step',
		'numberOfBins',
		'bins'
	],
	#category : #'AI-DecisionTreeModel-Preprocessing'
}

{ #category : #'as yet unclassified' }
AIDTColumnDiscretizer class >> withNumberOfBins: anInteger [
	^ self new numberOfBins: anInteger; yourself
]

{ #category : #accessing }
AIDTColumnDiscretizer >> defaultFirstBin [
	^ AIDTInterval min: Float negativeInfinity max: min + self step
]

{ #category : #accessing }
AIDTColumnDiscretizer >> defaultLastBin [
	^ AIDTInterval min: max - self step max: Float infinity
]

{ #category : #api }
AIDTColumnDiscretizer >> fit: aCollection [
	min := aCollection min.
	max := aCollection max.
	self setBins
]

{ #category : #api }
AIDTColumnDiscretizer >> fitTransform: aCollection [
	self fit: aCollection.
	^ self transform: aCollection
]

{ #category : #initialization }
AIDTColumnDiscretizer >> initialize [
	super initialize.
	numberOfBins := 5
]

{ #category : #accessing }
AIDTColumnDiscretizer >> isFitted [
	^ max isNotNil and: [ min isNotNil ]
]

{ #category : #accessing }
AIDTColumnDiscretizer >> newBinAt: aNumber [
	aNumber = 1 ifTrue: [ ^ self defaultFirstBin ].
	aNumber = numberOfBins ifTrue: [ ^ self defaultLastBin ].
	^ AIDTInterval
		min: (min + (step * (aNumber - 1)))
		max: (min + (step * aNumber))
]

{ #category : #accessing }
AIDTColumnDiscretizer >> numberOfBins: anInteger [
	numberOfBins := anInteger
]

{ #category : #accessing }
AIDTColumnDiscretizer >> setBins [
	bins := OrderedCollection new.
	1 to: numberOfBins do: [ :each |
		 bins add: (self newBinAt: each)
	]
]

{ #category : #accessing }
AIDTColumnDiscretizer >> step [
	^ step ifNil: [step := (max - min) / numberOfBins]
]

{ #category : #api }
AIDTColumnDiscretizer >> transform: aCollection [
	self isFitted ifFalse: [ Exception signal: 'Discretizer must be fitted before transforming data.'].
	^ aCollection collect: [ :each | bins detect: [:bin | bin includes: each]]
]
