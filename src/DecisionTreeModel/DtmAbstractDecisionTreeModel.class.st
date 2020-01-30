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

{ #category : #api }
DtmAbstractDecisionTreeModel >> fit: aDataset withTarget: aName [
	self subclassResponsibility 
	
]

{ #category : #classification }
DtmAbstractDecisionTreeModel >> getDecisionsFor: aDataset [
	| decisionCollection |
	decisionCollection := OrderedCollection new.
	aDataset do: [ :row | decisionCollection add: (self decisionFor: row) ].
	^ decisionCollection
]

{ #category : #api }
DtmAbstractDecisionTreeModel >> predict: aDataset [
	^ ((self getDecisionsFor: aDataset) collect: [ :each | each label ]) asArray
	
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root [
	^ root
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root: aDecisionTreeNode [ 
	^ root := aDecisionTreeNode
]
