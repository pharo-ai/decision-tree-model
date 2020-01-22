Class {
	#name : #DtmDecisionTreeLeaf,
	#superclass : #DtmAbstractDecisionTreeNode,
	#instVars : [
		'label'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmDecisionTreeLeaf class >> withLabel: anObject [ 
	^ self new label: anObject; yourself 
]

{ #category : #accessing }
DtmDecisionTreeLeaf >> classify: anObject [ 
	^ label
	
]

{ #category : #accessing }
DtmDecisionTreeLeaf >> label [
	^ label
]

{ #category : #accessing }
DtmDecisionTreeLeaf >> label: anObject [
	label := anObject
]
