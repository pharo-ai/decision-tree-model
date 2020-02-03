Class {
	#name : #DtmDecisionTreeModelTest,
	#superclass : #TestCase,
	#instVars : [
		'tennisDataset'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmDecisionTreeModelTest >> setUp [
	| tennisDataFrame |
	super setUp.
	tennisDataFrame := DataFrame withRows: #(
		(sunny high high weak false)
  		(sunny high high strong false)
		(cloudy high high weak true)
		(rainy medium high weak true)
		(rainy low normal weak true)
		(rainy low normal strong false)
		(cloudy low normal strong true)
		(sunny medium high weak false)
		(sunny low normal weak true)
		(rainy medium normal weak true)
		(sunny medium normal strong true)
		(cloudy medium high strong true)
		(cloudy high normal weak true)
		(rainy medium high strong false)).
	tennisDataFrame columnNames: #(outlook temperature humidity wind playTennis).
	tennisDataset := DtmDataset fromDataFrame: tennisDataFrame.
	
]

{ #category : #running }
DtmDecisionTreeModelTest >> testDecisionTreeAnswersDecisionForWithADecision [
	| decisionTree |
	decisionTree := DtmAbstractDecisionTreeModel new.
	decisionTree root: (DtmDecision withLabel: true).
	self assert: ((decisionTree decisionFor: #something) class inheritsFrom: DtmAbstractDecisionTreeNode)
]
