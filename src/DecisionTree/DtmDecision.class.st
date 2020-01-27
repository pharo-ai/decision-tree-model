Class {
	#name : #DtmDecision,
	#superclass : #DtmAbstractDecisionTreeNode,
	#instVars : [
		'label'
	],
	#category : #DecisionTree
}

{ #category : #'as yet unclassified' }
DtmDecision class >> withLabel: anObject [ 
	^ self new label: anObject; yourself 
]

{ #category : #accessing }
DtmDecision >> decisionFor: anObject [ 
	^ self
	
]

{ #category : #accessing }
DtmDecision >> label [
	<ignoreForCoverage>
	^ label
]

{ #category : #accessing }
DtmDecision >> label: anObject [
	<ignoreForCoverage>
	label := anObject
]

{ #category : #printing }
DtmDecision >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self label asString;
		nextPutAll: ')'
]
