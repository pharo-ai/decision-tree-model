Class {
	#name : #DtmDecisionTreeModelTest,
	#superclass : #TestCase,
	#instVars : [
		'waterDecisionTree'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmDecisionTreeModelTest >> setUp [
	waterDecisionTree := DtmDecisionTree withCondition: [ :value | value < 0  ].
	waterDecisionTree trueChild: (DtmDecision withLabel: 'ice').
	waterDecisionTree falseChild: (DtmDecision withLabel: 'liquid').
]

{ #category : #tests }
DtmDecisionTreeModelTest >> testDecisionForReturnsDecision [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) class equals: DtmDecision 
]

{ #category : #tests }
DtmDecisionTreeModelTest >> testParentOfIceLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree trueChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
DtmDecisionTreeModelTest >> testParentOfLiquidLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree falseChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
DtmDecisionTreeModelTest >> testWaterIsIceIfTemperatureBelowZero [

	| temperature |	
	temperature := -10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'ice'
]

{ #category : #tests }
DtmDecisionTreeModelTest >> testWaterIsLiquidIfTemperatureAboveZero [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'liquid'
]
