Class {
	#name : #DtmDiscretizer,
	#superclass : #Object,
	#instVars : [
		'min',
		'max',
		'bins',
		'step'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmDiscretizer class >> withNumberOfBins: anInteger [
	^ self new bins: anInteger; yourself 
]

{ #category : #accessing }
DtmDiscretizer >> bins: anInteger [
	bins := anInteger
]

{ #category : #'as yet unclassified' }
DtmDiscretizer >> fit: aDataSeries [
	min := aDataSeries min.
	max := aDataSeries max.
]

{ #category : #initialization }
DtmDiscretizer >> initialize [ 
	super initialize.
	bins := 5
]

{ #category : #accessing }
DtmDiscretizer >> isFitted [ 
	^ max isNotNil and: [ min isNotNil ]
]

{ #category : #accessing }
DtmDiscretizer >> step [
	^ step ifNil: [step := (max - min) / bins]
]

{ #category : #'as yet unclassified' }
DtmDiscretizer >> transform: aDataSeries [
	self isFitted ifFalse: [ Exception signal: 'Discretizer must be fitted before transforming data.'].
	^ aDataSeries collect: [ :each | 
		(each >= min and: [each < max]) 
			ifTrue: [ ((each - min) / self step) floor + 1  ] 
			ifFalse: [ each < min ifTrue: [ 1 ] ifFalse: [ bins ]]]
]
