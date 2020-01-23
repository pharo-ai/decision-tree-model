Class {
	#name : #DtmAbstractDecisionTreeNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #DecisionTreeModel
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
DtmAbstractDecisionTreeNode >> isTrueChildOfParent [
	^ self parent trueChild == self
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> parent [
	^ parent
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> why [
	"Returns collections of instructions to get to get to the decision"
	| whyStack | 
	whyStack := OrderedCollection new.
	self hasParent ifFalse: [ ^ whyStack ].
	whyStack addAll: self parent why.
	whyStack add: self parent condition -> self isTrueChildOfParent.
	^ whyStack
]
