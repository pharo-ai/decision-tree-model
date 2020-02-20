"
I represent an abstract binary splitter for a dataset.

My subclasses know a strategy to make a binary split on the dataset (with a true/false condition). They also know the instruction to build a binary decision tree node with the corresponding split in the data. All my subclasses know a feature on which they split the dataset.
"
Class {
	#name : #DtmBinarySplitter,
	#superclass : #DtmAbstractSplitter,
	#category : #DecisionTreeModel
}

{ #category : #splitting }
DtmBinarySplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [
	"Specify how a DecisionTreeNode should be built for the type of split
	Binary splits should build a BinaryDecisionTree"
	
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
