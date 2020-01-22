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
	waterDecisionTree trueChild: (DtmDecisionTreeLeaf withLabel: 'ice').
	waterDecisionTree falseChild: (DtmDecisionTreeLeaf withLabel: 'liquid').
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
	self assert: (waterDecisionTree classify: temperature) equals: 'ice'
]

{ #category : #tests }
DtmDecisionTreeModelTest >> testWaterIsLiquidIfTemperatureAboveZero [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree classify: temperature) equals: 'liquid'
]
