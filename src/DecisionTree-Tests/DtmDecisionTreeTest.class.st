Class {
	#name : #DtmDecisionTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'waterDecisionTree',
		'tennisDecisionTree'
	],
	#category : #'DecisionTree-Tests'
}

{ #category : #tests }
DtmDecisionTreeTest >> setUp [
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
DtmDecisionTreeTest >> testDecisionForReturnsDecision [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) class equals: DtmDecision 
]

{ #category : #tests }
DtmDecisionTreeTest >> testParentOfIceLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree trueChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
DtmDecisionTreeTest >> testParentOfLiquidLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree falseChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
DtmDecisionTreeTest >> testWaterIsIceIfTemperatureBelowZero [

	| temperature |	
	temperature := -10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'ice'
]

{ #category : #tests }
DtmDecisionTreeTest >> testWaterIsLiquidIfTemperatureAboveZero [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'liquid'
]

{ #category : #tests }
DtmDecisionTreeTest >> testWhyPlayTenis [

	| weather decision expected |	
	weather := { #rain -> false . #temperature -> 20} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := { tennisDecisionTree condition -> false .
					  tennisDecisionTree falseChild condition -> true } asOrderedCollection.
	self assert: decision why equals: expected.
]

{ #category : #tests }
DtmDecisionTreeTest >> testWhyWaterIsIce [

	| temperature decision expected |	
	temperature := -10.
	decision := waterDecisionTree decisionFor: temperature.
	expected := { waterDecisionTree condition -> true} asOrderedCollection.
	self assert: decision why equals: expected.
]
