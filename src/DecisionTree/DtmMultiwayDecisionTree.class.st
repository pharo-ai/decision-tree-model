"
I represent a binary decision tree composite node.

I am not a final decision. I have a condition that can two or more outputs and a child for each of this evaluations. I am responsible of delegating an object to the corresponding child depending on the evaluation of my condition.
"
Class {
	#name : #DtmMultiwayDecisionTree,
	#superclass : #DtmAbstractDecisionTreeComposite,
	#instVars : [
		'children'
	],
	#category : #DecisionTree
}

{ #category : #accessing }
DtmMultiwayDecisionTree >> at: aName addChild: aDecisionTreeNode [
	aDecisionTreeNode parent: self.
	children at: aName  put: aDecisionTreeNode
]

{ #category : #accessing }
DtmMultiwayDecisionTree >> childAt: aName [
	^ children at: aName
]

{ #category : #accessing }
DtmMultiwayDecisionTree >> decisionFor: anObject [
	"Check condition for anObject, pass down decision making to corresponding child" 
	| childThatDecides |
	childThatDecides := children at: (condition value: anObject).
	^ childThatDecides decisionFor: anObject 
]

{ #category : #'as yet unclassified' }
DtmMultiwayDecisionTree >> explainWhy: aNode [
	"Give an explanation of why aNode is chosen"
	^ self condition -> (children keyAtIdentityValue: aNode).
]

{ #category : #accessing }
DtmMultiwayDecisionTree >> height [
	^ 1 + (children collect: [:each | each height]) max
]

{ #category : #initialization }
DtmMultiwayDecisionTree >> initialize [
	super initialize.
	children := Dictionary new.
]

{ #category : #accessing }
DtmMultiwayDecisionTree >> numberOfLeaves [
	^ (children collect: [:each | each numberOfLeaves]) sum
]

{ #category : #printing }
DtmMultiwayDecisionTree >> printOn: aStream [
	<ignoreForCoverage>
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: condition asString;
		nextPutAll: ' -> ';
		nextPutAll: children keys asString;
		nextPutAll: ')'
]
