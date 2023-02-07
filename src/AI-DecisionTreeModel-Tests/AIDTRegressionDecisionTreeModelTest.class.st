Class {
	#name : #AIDTRegressionDecisionTreeModelTest,
	#superclass : #AIDTDecisionTreeModelTest,
	#instVars : [
		'treeModel',
		'sampleDataset',
		'smallDatasetThatShouldNotSplit'
	],
	#category : #'AI-DecisionTreeModel-Tests'
}

{ #category : #running }
AIDTRegressionDecisionTreeModelTest >> setUp [
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
	sampleDataset := AIDTDataset fromArray: arrayOfPoints
		withFeatures: #(first) withTarget: #second.
	
	treeModel := AIDTRegressionDecisionTreeModel new.
	
	treeModel minSizeForSplit: 7.
	smallDatasetThatShouldNotSplit := AIDTDataset fromArray: (arrayOfPoints first: 6)
		withFeatures: #(first) withTarget: #second.
]

{ #category : #tests }
AIDTRegressionDecisionTreeModelTest >> testDecisionFor [
	| actual expected newExample |
	treeModel fit: sampleDataset.
	newExample := AIDTDataset fromArray: #(#(5) #(20) #(27) #(35)) withColumns: #(first).
	actual := ((treeModel decisionsForAll: newExample) collect: [ :each | each label ]) asArray.
	expected := { 25 / 6 . 100 . 262 / 5 . 5 / 2} asArray.
	self assert: actual equals: expected
]

{ #category : #tests }
AIDTRegressionDecisionTreeModelTest >> testFit [
	treeModel fit: sampleDataset.
	self assert: (treeModel root class inheritsFrom: AIDTAbstractDecisionTreeNode) 
]

{ #category : #tests }
AIDTRegressionDecisionTreeModelTest >> testMinSizeForSplit [
	treeModel fit: smallDatasetThatShouldNotSplit.
	self assert: treeModel root class equals: AIDTDecision
]
