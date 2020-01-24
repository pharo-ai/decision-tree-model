Class {
	#name : #DtmBinaryDecisionTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'waterDecisionTree',
		'tennisDecisionTree'
	],
	#category : #'DecisionTree-Tests'
}

{ #category : #tests }
DtmBinaryDecisionTreeTest >> setUp [
	waterDecisionTree := DtmBinaryDecisionTree withCondition: [ :value | value < 0  ].
	waterDecisionTree trueChild: (DtmDecision withLabel: 'ice').
	waterDecisionTree falseChild: (DtmDecision withLabel: 'liquid').
	
	tennisDecisionTree := DtmBinaryDecisionTree withCondition: [ :weather | weather at: #rain].
	tennisDecisionTree trueChild: (DtmDecision withLabel: 'stay home').
	tennisDecisionTree falseChild: (DtmBinaryDecisionTree withCondition: [ :weather | (weather at: #temperature) > 0 
												and: [(weather at: #temperature) < 30]]).
	tennisDecisionTree falseChild trueChild: (DtmDecision withLabel: 'play tennis').
	tennisDecisionTree falseChild falseChild: (DtmDecision withLabel: 'stay home').
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testDecisionForReturnsDecision [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) class equals: DtmDecision 
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testDecisionForReturnsDecisionWithRightParent [

	| temperature decision |	
	temperature := 10.
	decision := waterDecisionTree decisionFor: temperature.
	self assert: decision parent equals: waterDecisionTree 
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testParentOfIceLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree trueChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testParentOfLiquidLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree falseChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testWaterIsIceIfTemperatureBelowZero [

	| temperature |	
	temperature := -10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'ice'
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testWaterIsLiquidIfTemperatureAboveZero [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'liquid'
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testWhyPlayTenis [

	| weather decision expected |	
	weather := { #rain -> false . #temperature -> 20} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := { tennisDecisionTree condition -> false .
					  tennisDecisionTree falseChild condition -> true } asOrderedCollection.
	self assert: decision why equals: expected.
]

{ #category : #tests }
DtmBinaryDecisionTreeTest >> testWhyWaterIsIce [

	| temperature decision expected |	
	temperature := -10.
	decision := waterDecisionTree decisionFor: temperature.
	expected := { waterDecisionTree condition -> true} asOrderedCollection.
	self assert: decision why equals: expected.
]
