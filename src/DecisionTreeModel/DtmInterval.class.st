"
I represent an interval created by the discretizer
"
Class {
	#name : #DtmInterval,
	#superclass : #Object,
	#instVars : [
		'min',
		'max'
	],
	#category : #DecisionTreeModel
}

{ #category : #accessing }
DtmInterval class >> min: lowerLimit max: upperLimit [
	^ self new min: lowerLimit; max: upperLimit; yourself
]

{ #category : #accessing }
DtmInterval >> includes: aNumber [
	"By default intervals are closed on lower bound and open on upper bound"
	^ (aNumber >= min and: [aNumber < max]) 
]

{ #category : #accessing }
DtmInterval >> lowerBoundSymbol [
		^ '['
]

{ #category : #accessing }
DtmInterval >> max [
	^ max
]

{ #category : #accessing }
DtmInterval >> max: anObject [
	max := anObject
]

{ #category : #accessing }
DtmInterval >> min [
	^ min
]

{ #category : #accessing }
DtmInterval >> min: anObject [
	min := anObject
]

{ #category : #accessing }
DtmInterval >> printOn: aStream [
	<ignoreForCoverage>
	aStream 
		nextPutAll: self class name;
		nextPutAll: '( ';
		nextPutAll: self lowerBoundSymbol;
		nextPutAll: min asString;
		nextPutAll: ', ' asString;
		nextPutAll: max asString;
		nextPutAll: self upperBoundSymbol;
		nextPutAll: ' )'
]

{ #category : #accessing }
DtmInterval >> upperBoundSymbol [
		^ ')'
]
