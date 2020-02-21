Class {
	#name : #DtmRegressionDecisionTreeModelTest,
	#superclass : #DtmDecisionTreeModelTest,
	#instVars : [
		'treeModel',
		'sampleDataset',
		'smallDatasetThatShouldNotSplit'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmRegressionDecisionTreeModelTest >> setUp [
	| arrayOfPoints |
	super setUp.
	arrayOfPoints := #(#(0 0)
			#(2 0)
			#(4 0)
			#(8 0)
			#(10 5)
			#(12 20)
			#(14 100)
			#(17 100)
			#(21 100)
			#(23 100)
			#(25 60)
			#(26 55)
			#(27 52)
			#(28 50)
			#(29 45)
			#(31 10)
			#(33 0)
			#(36 0)
			#(38 0)).
	sampleDataset := DtmDataset fromArray: arrayOfPoints
		withFeatures: #(first) withTarget: #second.
	
	treeModel := DtmRegressionDecisionTreeModel new.
	
	treeModel minSizeForSplit: 7.
	smallDatasetThatShouldNotSplit := DtmDataset fromArray: (arrayOfPoints first: 6)
		withFeatures: #(first) withTarget: #second.
]

{ #category : #tests }
DtmRegressionDecisionTreeModelTest >> testDecisionFor [
	| actual expected newExample |
	treeModel fit: sampleDataset.
	newExample := DtmDataset fromArray: #(#(5) #(20) #(27) #(35)) withColumns: #(first).
	actual := ((treeModel decisionsForAll: newExample) collect: [ :each | each label ]) asArray.
	expected := { 25 / 6 . 100 . 262 / 5 . 5 / 2} asArray.
	self assert: actual equals: expected
]

{ #category : #tests }
DtmRegressionDecisionTreeModelTest >> testFit [
	treeModel fit: sampleDataset.
	self assert: (treeModel root class inheritsFrom: DtmAbstractDecisionTreeNode) 
]

{ #category : #tests }
DtmRegressionDecisionTreeModelTest >> testMinSizeForSplit [
	treeModel fit: smallDatasetThatShouldNotSplit.
	self assert: treeModel root class equals: DtmDecision
]
