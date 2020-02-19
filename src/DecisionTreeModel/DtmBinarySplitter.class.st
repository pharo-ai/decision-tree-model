Class {
	#name : #DtmBinarySplitter,
	#superclass : #DtmAbstractSplitter,
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmBinarySplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [

	|  decisionTreeForSplit splitsDict |
	splitsDict := self getSplitsFor: aDataset.
	decisionTreeForSplit := (DtmBinaryDecisionTree withCondition: self)
		trueChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: true));
		falseChild: (aDecisionTreeModel buildNodeFor: (splitsDict at: false));
		yourself.
	^ decisionTreeForSplit
]

{ #category : #printing }
DtmBinarySplitter >> comparingSymbol [
	self subclassResponsibility 
]

{ #category : #splitting }
DtmBinarySplitter >> getSplitsFor: aDataset [
	| splits |
	splits := {  
		true -> (aDataset select: self condition).
		false -> (aDataset reject: self condition).
	}.
	^ splits asDictionary 
]
