Class {
	#name : #AIDTBinaryDecisionTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'waterDecisionTree',
		'tennisDecisionTree'
	],
	#category : #'AI-DecisionTree-Tests'
}

{ #category : #running }
AIDTBinaryDecisionTreeTest >> setUp [
	super setUp.
	waterDecisionTree := AIDTBinaryDecisionTree withCondition: [ :value | value < 0  ].
	waterDecisionTree trueChild: (AIDTDecision withLabel: 'ice').
	waterDecisionTree falseChild: (AIDTDecision withLabel: 'liquid').
	
	tennisDecisionTree := AIDTBinaryDecisionTree withCondition: [ :weather | weather at: #rain].
	tennisDecisionTree trueChild: (AIDTDecision withLabel: 'stay home').
	tennisDecisionTree falseChild: (AIDTBinaryDecisionTree withCondition: [ :weather | (weather at: #temperature) > 0 
												and: [(weather at: #temperature) < 30]]).
	tennisDecisionTree falseChild trueChild: (AIDTDecision withLabel: 'play tennis').
	tennisDecisionTree falseChild falseChild: (AIDTDecision withLabel: 'stay home').
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testDecisionForReturnsDecision [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) class equals: AIDTDecision 
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testDecisionForReturnsDecisionWithRightParent [

	| temperature decision |	
	temperature := 10.
	decision := waterDecisionTree decisionFor: temperature.
	self assert: decision parent equals: waterDecisionTree 
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testParentOfIceLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree trueChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testParentOfLiquidLeafIsWaterDecisionTree [

	| expected actual |	
	expected := waterDecisionTree.
	actual := waterDecisionTree falseChild parent.
	self assert: actual equals: expected 
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testWaterIsIceIfTemperatureBelowZero [

	| temperature |	
	temperature := -10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'ice'
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testWaterIsLiquidIfTemperatureAboveZero [

	| temperature |	
	temperature := 10.
	self assert: (waterDecisionTree decisionFor: temperature) label equals: 'liquid'
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testWhyPlayTenis [

	| weather decision expected |	
	weather := { #rain -> false . #temperature -> 20} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := { tennisDecisionTree condition -> false .
					  tennisDecisionTree falseChild condition -> true } asOrderedCollection.
	self assert: decision why equals: expected.
]

{ #category : #tests }
AIDTBinaryDecisionTreeTest >> testWhyWaterIsIce [

	| temperature decision expected |	
	temperature := -10.
	decision := waterDecisionTree decisionFor: temperature.
	expected := { waterDecisionTree condition -> true} asOrderedCollection.
	self assert: decision why equals: expected.
]
