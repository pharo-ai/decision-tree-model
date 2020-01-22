Class {
	#name : #DtmAbstractDecisionTreeNode,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #DecisionTreeModel
}

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> classify: anObject [ 
	self subclassResponsibility 
	
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> parent [
	^ parent
]

{ #category : #accessing }
DtmAbstractDecisionTreeNode >> parent: anObject [
	parent := anObject
]