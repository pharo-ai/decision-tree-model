Class {
	#name : #DtmDecisionTreeModelTest,
	#superclass : #TestCase,
	#instVars : [
		'waterDecisionTree',
		'tennisDecisionTree'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmDecisionTreeModelTest >> setUp [
	waterDecisionTree := DtmDecisionTree withCondition: [ :value | value < 0  ].
	waterDecisionTree trueChild: (DtmDecision withLabel: 'ice').
	waterDecisionTree falseChild: (DtmDecision withLabel: 'liquid').
	
	tennisDecisionTree := DtmDecisionTree withCondition: [ :weather | weather at: #rain].
	tennisDecisionTree trueChild: (DtmDecision withLabel: 'stay home').
	tennisDecisionTree falseChild: (DtmDecisionTree withCondition: [ :weather | (weather at: #temperature) > 0 
												and: [(weather at: #temperature) < 30]]).
	tennisDecisionTree falseChild trueChild: (DtmDecision withLabel: 'play tennis').
	tennisDecisionTree falseChild falseChild: (DtmDecision withLabel: 'stay home').
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

{ #category : #tests }
DtmDecisionTreeModelTest >> testWhyPlayTenis [

	| weather decision expected |	
	weather := { #rain -> false . #temperature -> 20} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := { tennisDecisionTree condition -> false .
					  tennisDecisionTree falseChild condition -> true } asOrderedCollection.
	self assert: decision why equals: expected.
]

{ #category : #tests }
DtmDecisionTreeModelTest >> testWhyWaterIsIce [

	| temperature decision expected |	
	temperature := -10.
	decision := waterDecisionTree decisionFor: temperature.
	expected := { waterDecisionTree condition -> true} asOrderedCollection.
	self assert: decision why equals: expected.
]
