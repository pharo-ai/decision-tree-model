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
	<ignoreForCoverage>
	^ label
]

{ #category : #accessing }
DtmDecisionTreeLeaf >> label: anObject [
	<ignoreForCoverage>
	label := anObject
]

{ #category : #printing }
DtmDecisionTreeLeaf >> printOn: aStream [
	aStream 
		nextPutAll: self class name;
		nextPutAll: '(';
		nextPutAll: self label;
		nextPutAll: ')'
]
