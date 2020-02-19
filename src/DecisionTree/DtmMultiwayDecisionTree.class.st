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
