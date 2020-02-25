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
	"Specify how a DecisionTreeNode should be built for the type of split.
	Binary splits should build a BinaryDecisionTree"
	
	|  decisionTreeForSplit |
	decisionTreeForSplit := (DtmBinaryDecisionTree withCondition: self)
		trueChild: (aDecisionTreeModel buildNodeFor: (self trueSplit: aDataset));
		falseChild: (aDecisionTreeModel buildNodeFor: (self falseSplit: aDataset));
		yourself.
	^ decisionTreeForSplit
]

{ #category : #printing }
DtmBinarySplitter >> comparingSymbol [
	self subclassResponsibility 
]

{ #category : #splitting }
DtmBinarySplitter >> falseSplit: aDtmDataset [ 
	"Return split that does not satisfy condition"
	^ aDtmDataset split: [ :row | (self condition value: row) not]
]

{ #category : #splitting }
DtmBinarySplitter >> splitsFor: aDataset [
	| splits |
	splits := {  
		true -> (self trueSplit: aDataset).
		false -> (self falseSplit: aDataset).
	}.
	^ splits asDictionary 
]

{ #category : #splitting }
DtmBinarySplitter >> trueSplit: aDataset [ 
	"Return split of aDataset that satisfies condition"
	^ aDataset split: self condition
]
