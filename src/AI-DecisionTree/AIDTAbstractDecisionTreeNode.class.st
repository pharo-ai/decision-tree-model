"
I represent an abstract decision tree node.
"
Class {
	#name : #AIDTAbstractDecisionTreeNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'AI-DecisionTree'
}

{ #category : #accessing }
AIDTAbstractDecisionTreeNode >> decisionFor: anObject [ 
	"Explain how to make decision over anObject"
	self subclassResponsibility 
	
]

{ #category : #testing }
AIDTAbstractDecisionTreeNode >> hasParent [
	^ self parent isNotNil
]

{ #category : #accessing }
AIDTAbstractDecisionTreeNode >> height [
	self subclassResponsibility
]

{ #category : #accessing }
AIDTAbstractDecisionTreeNode >> numberOfLeaves [
	self subclassResponsibility
]

{ #category : #accessing }
AIDTAbstractDecisionTreeNode >> parent [
	^ parent
]

{ #category : #accessing }
AIDTAbstractDecisionTreeNode >> parent: aDecisionTreeComposite [
	parent := aDecisionTreeComposite
]

{ #category : #accessing }
AIDTAbstractDecisionTreeNode >> why [
	"Returns collections of instructions to get to get to the decision"
	| whyStack | 
	whyStack := OrderedCollection new.
	self hasParent ifFalse: [ ^ whyStack ].
	whyStack addAll: self parent why.
	whyStack add: (self parent explainWhy: self).
	^ whyStack
]
