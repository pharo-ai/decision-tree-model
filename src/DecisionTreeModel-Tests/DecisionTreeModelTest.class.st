Class {
	#name : #DecisionTreeModelTest,
	#superclass : #TestCase,
	#instVars : [
		'waterDecisionTree'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DecisionTreeModelTest >> setUp [
	waterDecisionTree := DtmDecisionTree withCondition: [ :value | value < 0  ].
	waterDecisionTree trueBranch: (DtmDecisionTreeLeaf withLabel: 'ice').
	waterDecisionTree falseBranch: (DtmDecisionTreeLeaf withLabel: 'liquid').		
]

{ #category : #tests }
DecisionTreeModelTest >> testWaterIsIceIfTemperatureBelowZero [

	| temperature |	
	temperature := -10.
	self assert: (waterDecisionTree classify: temperature) equals: 'ice'
]

{ #category : #tests }
DecisionTreeModelTest >> testWaterIsLiquidIfTemperatureAboveZero [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree classify: temperature) equals: 'liquid'
]
