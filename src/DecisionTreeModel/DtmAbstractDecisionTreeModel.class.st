Class {
	#name : #DtmAbstractDecisionTreeModel,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #DecisionTreeModel
}

{ #category : #'as yet unclassified' }
DtmAbstractDecisionTreeModel >> decisionFor: anObject [
	^ root decisionFor: anObject 
	
]

{ #category : #'as yet unclassified' }
DtmAbstractDecisionTreeModel >> fit: aDataset withTarget: aName [
	self subclassResponsibility 
	
]
