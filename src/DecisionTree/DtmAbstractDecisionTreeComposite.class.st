"
I represent an abstract decision tree composite node.

My subclasses are not final decisions. My subclasses have children and have a condition that specifies which children to follow when making a decision. 
"
Class {
	#name : #DtmAbstractDecisionTreeComposite,
	#superclass : #DtmAbstractDecisionTreeNode,
	#instVars : [
		'condition'
	],
	#category : #DecisionTree
}

{ #category : #'as yet unclassified' }
DtmAbstractDecisionTreeComposite class >> withCondition: aBlock [
	^ self new condition: aBlock; yourself
]

{ #category : #accessing }
DtmAbstractDecisionTreeComposite >> condition [
	<ignoreForCoverage>
	^ condition
]

{ #category : #accessing }
DtmAbstractDecisionTreeComposite >> condition: anObject [
	<ignoreForCoverage>
	condition := anObject
]

{ #category : #'as yet unclassified' }
DtmAbstractDecisionTreeComposite >> explainWhy: aNode [
	"Give an explanation of why aNode is chosen"
	self subclassResponsibility 
]
