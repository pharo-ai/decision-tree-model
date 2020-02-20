Class {
	#name : #DtmDecisionTreeModelTest,
	#superclass : #TestCase,
	#instVars : [
		'tennisDataset',
		'mixedTennisDataset'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmDecisionTreeModelTest >> setUp [
	| tennisDataFrame mixedTennisDataFrame| 
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
	
	mixedTennisDataFrame := DataFrame withRows: #(
		(sunny 85 85 weak false)
  		(sunny 80 90 strong false)
		(cloudy 83 78 weak true)
		(rainy 70 96 weak true)
		(rainy 68 80 weak true)
		(rainy 65 70 strong false)
		(cloudy 64 65 strong true)
		(sunny 72 95 weak false)
		(sunny 69 70 weak true)
		(rainy 75 80 weak true)
		(sunny 75 70 strong true)
		(cloudy 72 90 strong true)
		(cloudy 81 75 weak true)
		(rainy 71 80 strong false)).
	mixedTennisDataFrame columnNames: #(outlook temperature humidity wind playTennis).
	mixedTennisDataset := DtmDataset fromDataFrame: mixedTennisDataFrame.
	
]

{ #category : #running }
DtmDecisionTreeModelTest >> testDecisionForReturnsCorrectLabel [
	| decisionTree |
	decisionTree := DtmAbstractDecisionTreeModel new.
	decisionTree root: (DtmDecision withLabel: #someLabel).
	self assert: (decisionTree decisionFor: #something) label equals: #someLabel
]

{ #category : #running }
DtmDecisionTreeModelTest >> testDecisionForReturnsDtmDecision [
	| decisionTree |
	decisionTree := DtmAbstractDecisionTreeModel new.
	decisionTree root: (DtmDecision withLabel: #someLabel).
	self assert: (decisionTree decisionFor: #something) class equals: DtmDecision
]
