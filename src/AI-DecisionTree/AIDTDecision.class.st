"
I represent a final decision made by a decision tree. 

I know my label, which corresponds to the decision.
"
Class {
	#name : #AIDTDecision,
	#superclass : #AIDTAbstractDecisionTreeNode,
	#instVars : [
		'label'
	],
	#category : #'AI-DecisionTree'
}

{ #category : #'as yet unclassified' }
AIDTDecision class >> withLabel: anObject [
	^ self new label: anObject; yourself
]

{ #category : #accessing }
AIDTDecision >> decisionFor: anObject [
	"Returns itself as the decision for anObject"
	^ self
]

{ #category : #accessing }
AIDTDecision >> height [
	^ 0
]

{ #category : #accessing }
AIDTDecision >> label [
	<ignoreForCoverage>
	^ label
]

{ #category : #accessing }
AIDTDecision >> label: anObject [
	<ignoreForCoverage>
	label := anObject
]

{ #category : #accessing }
AIDTDecision >> numberOfLeaves [
	^ 1
]

{ #category : #printing }
AIDTDecision >> printOn: aStream [
	<ignoreForCoverage>
	aStream
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self label asString;
		nextPutAll: ')'
]
