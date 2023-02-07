"
I represent an interval created by the discretizer
"
Class {
	#name : #AIDTInterval,
	#superclass : #Object,
	#instVars : [
		'min',
		'max'
	],
	#category : #'AI-DecisionTreeModel-Preprocessing'
}

{ #category : #accessing }
AIDTInterval class >> min: lowerLimit max: upperLimit [
	^ self new min: lowerLimit; max: upperLimit; yourself
]

{ #category : #accessing }
AIDTInterval >> includes: aNumber [
	"By default intervals are closed on lower bound and open on upper bound"
	^ (aNumber >= min and: [aNumber < max]) 
]

{ #category : #accessing }
AIDTInterval >> lowerBoundSymbol [
		^ '['
]

{ #category : #accessing }
AIDTInterval >> max [
	^ max
]

{ #category : #accessing }
AIDTInterval >> max: anObject [
	max := anObject
]

{ #category : #accessing }
AIDTInterval >> min [
	^ min
]

{ #category : #accessing }
AIDTInterval >> min: anObject [
	min := anObject
]

{ #category : #accessing }
AIDTInterval >> printOn: aStream [
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
AIDTInterval >> upperBoundSymbol [
		^ ')'
]
