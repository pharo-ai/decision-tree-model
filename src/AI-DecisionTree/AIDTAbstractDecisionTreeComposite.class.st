"
I represent an abstract decision tree composite node.

My subclasses are not final decisions. My subclasses have children and have a condition that specifies which children to follow when making a decision. 
"
Class {
	#name : #AIDTAbstractDecisionTreeComposite,
	#superclass : #AIDTAbstractDecisionTreeNode,
	#instVars : [
		'condition'
	],
	#category : #'AI-DecisionTree'
}

{ #category : #'as yet unclassified' }
AIDTAbstractDecisionTreeComposite class >> withCondition: aBlock [
	^ self new condition: aBlock; yourself
]

{ #category : #accessing }
AIDTAbstractDecisionTreeComposite >> condition [
	<ignoreForCoverage>
	^ condition
]

{ #category : #accessing }
AIDTAbstractDecisionTreeComposite >> condition: anObject [
	<ignoreForCoverage>
	condition := anObject
]

{ #category : #'as yet unclassified' }
AIDTAbstractDecisionTreeComposite >> explainWhy: aNode [
	"Give an explanation of why aNode is chosen"
	self subclassResponsibility
]
