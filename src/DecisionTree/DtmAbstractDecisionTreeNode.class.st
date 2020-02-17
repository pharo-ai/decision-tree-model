Class {
	#name : #DtmAbstractDecisionTreeNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #DecisionTree
}

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> decisionFor: anObject [ 
	self subclassResponsibility 
	
]

{ #category : #testing }
DtmAbstractDecisionTreeNode >> hasParent [
	^ self parent isNotNil
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> height [
	self subclassResponsibility
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> parent [
	^ parent
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> parent: aDecisionTreeComposite [
	parent := aDecisionTreeComposite
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> why [
	"Returns collections of instructions to get to get to the decision"
	| whyStack | 
	whyStack := OrderedCollection new.
	self hasParent ifFalse: [ ^ whyStack ].
	whyStack addAll: self parent why.
	whyStack add: (self parent explainWhy: self).
	^ whyStack
]
