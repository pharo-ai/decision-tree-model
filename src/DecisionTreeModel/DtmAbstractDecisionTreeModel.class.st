Class {
	#name : #DtmAbstractDecisionTreeModel,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #DecisionTreeModel
}

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionFor: anObject [
	^ root decisionFor: anObject 
	
]

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionsForAll: aDataset [
	^ aDataset asArrayOfRows collect: [ :row | self decisionFor: row ].

]

{ #category : #api }
DtmAbstractDecisionTreeModel >> fit: aDataset [
	self subclassResponsibility 
	
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root [
	^ root
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root: aDecisionTreeNode [ 
	^ root := aDecisionTreeNode
]
