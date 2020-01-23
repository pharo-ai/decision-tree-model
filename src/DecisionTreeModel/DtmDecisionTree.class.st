Class {
	#name : #DtmDecisionTree,
	#superclass : #DtmAbstractDecisionTreeNode,
	#instVars : [
		'condition',
		'trueChild',
		'falseChild'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmDecisionTree class >> withCondition: aBlock [
	^ self new condition: aBlock; yourself
]

{ #category : #accessing }
DtmDecisionTree >> classify: anObject [ 
	^ (condition value: anObject) 
		ifTrue: [ trueChild classify: anObject ] 
		ifFalse: [ falseChild classify: anObject ]
	
]

{ #category : #accessing }
DtmDecisionTree >> condition [
	<ignoreForCoverage>
	^ condition
]

{ #category : #accessing }
DtmDecisionTree >> condition: anObject [
	<ignoreForCoverage>
	condition := anObject
]

{ #category : #accessing }
DtmDecisionTree >> falseChild [
	<ignoreForCoverage>
	^ falseChild
]

{ #category : #accessing }
DtmDecisionTree >> falseChild: aDecisionTreeNode [
	<ignoreForCoverage>
	aDecisionTreeNode parent: self.
	falseChild := aDecisionTreeNode
]

{ #category : #printing }
DtmDecisionTree >> printOn: aStream [
	<ignoreForCoverage>
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self condition asString;
		nextPutAll: ')'
]

{ #category : #accessing }
DtmDecisionTree >> trueChild [
	<ignoreForCoverage>
	^ trueChild
]

{ #category : #accessing }
DtmDecisionTree >> trueChild: aDecisionTreeNode [
	<ignoreForCoverage>
	aDecisionTreeNode parent: self.
	trueChild := aDecisionTreeNode
]
