"
I represent an abstract binary splitter for a dataset.

My subclasses know a strategy to make a binary split on the dataset (with a true/false condition). They also know the instruction to build a binary decision tree node with the corresponding split in the data. All my subclasses know a feature on which they split the dataset.
"
Class {
	#name : #AIDTBinarySplitter,
	#superclass : #AIDTAbstractSplitter,
	#category : #'AI-DecisionTreeModel'
}

{ #category : #splitting }
AIDTBinarySplitter >> buildNodeFor: aDataset inModel: aDecisionTreeModel [
	"Specify how a DecisionTreeNode should be built for the type of split.
	Binary splits should build a BinaryDecisionTree"

	|  decisionTreeForSplit |
	decisionTreeForSplit := (AIDTBinaryDecisionTree withCondition: self)
		trueChild: (aDecisionTreeModel buildNodeFor: (self trueSplit: aDataset));
		falseChild: (aDecisionTreeModel buildNodeFor: (self falseSplit: aDataset));
		yourself.
	^ decisionTreeForSplit
]

{ #category : #printing }
AIDTBinarySplitter >> comparingSymbol [
	self subclassResponsibility
]

{ #category : #splitting }
AIDTBinarySplitter >> falseSplit: aDTDataset [
	"Return split that does not satisfy condition"
	^ aDTDataset split: [ :row | (self condition value: row) not]
]

{ #category : #splitting }
AIDTBinarySplitter >> splitsFor: aDataset [
	| splits |
	splits := {
		true -> (self trueSplit: aDataset).
		false -> (self falseSplit: aDataset).
	}.
	^ splits asDictionary
]

{ #category : #splitting }
AIDTBinarySplitter >> trueSplit: aDataset [
	"Return split of aDataset that satisfies condition"
	^ aDataset split: self condition
]
