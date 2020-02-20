"
I represent a binary decision tree composite node.

I am not a final decision. I have a condition that can be true or false. I have a trueChild and falseChild. I am responsible of delegating an object to the corresponding child depending on the evaluation of my condition.
"
Class {
	#name : #DtmBinaryDecisionTree,
	#superclass : #DtmAbstractDecisionTreeComposite,
	#instVars : [
		'trueChild',
		'falseChild'
	],
	#category : #DecisionTree
}

{ #category : #accessing }
DtmBinaryDecisionTree >> decisionFor: anObject [ 
	"Check condition for anObject, pass down decision making to corresponding child"
	^ (condition value: anObject) 
		ifTrue: [ trueChild decisionFor: anObject ] 
		ifFalse: [ falseChild decisionFor: anObject ]
	
]

{ #category : #'as yet unclassified' }
DtmBinaryDecisionTree >> explainWhy: aNode [
	"Give an explanation of why aNode is chosen"
	^ self condition -> (self trueChild == aNode).
]

{ #category : #accessing }
DtmBinaryDecisionTree >> falseChild [
	<ignoreForCoverage>
	^ falseChild
]

{ #category : #accessing }
DtmBinaryDecisionTree >> falseChild: aDecisionTreeNode [
	<ignoreForCoverage>
	aDecisionTreeNode parent: self.
	falseChild := aDecisionTreeNode
]

{ #category : #accessing }
DtmBinaryDecisionTree >> height [
	^ 1 + { self trueChild height . self falseChild height } max
]

{ #category : #accessing }
DtmBinaryDecisionTree >> numberOfLeaves [
	^ { self trueChild numberOfLeaves . self falseChild numberOfLeaves } sum
]

{ #category : #printing }
DtmBinaryDecisionTree >> printOn: aStream [
	<ignoreForCoverage>
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self condition asString;
		nextPutAll: ')'
]

{ #category : #accessing }
DtmBinaryDecisionTree >> trueChild [
	<ignoreForCoverage>
	^ trueChild
]

{ #category : #accessing }
DtmBinaryDecisionTree >> trueChild: aDecisionTreeNode [
	<ignoreForCoverage>
	aDecisionTreeNode parent: self.
	trueChild := aDecisionTreeNode
]
