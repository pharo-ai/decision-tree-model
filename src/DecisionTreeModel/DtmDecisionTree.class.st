Class {
	#name : #DtmDecisionTree,
	#superclass : #DtmAbstractDecisionTreeNode,
	#instVars : [
		'trueBranch',
		'falseBranch',
		'condition'
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
		ifTrue: [ trueBranch classify: anObject ] 
		ifFalse: [ falseBranch classify: anObject ]
	
]

{ #category : #accessing }
DtmDecisionTree >> condition [
	^ condition
]

{ #category : #accessing }
DtmDecisionTree >> condition: anObject [
	condition := anObject
]

{ #category : #accessing }
DtmDecisionTree >> falseBranch [
	^ falseBranch
]

{ #category : #accessing }
DtmDecisionTree >> falseBranch: anObject [
	falseBranch := anObject
]

{ #category : #accessing }
DtmDecisionTree >> trueBranch [
	^ trueBranch
]

{ #category : #accessing }
DtmDecisionTree >> trueBranch: anObject [
	trueBranch := anObject
]
