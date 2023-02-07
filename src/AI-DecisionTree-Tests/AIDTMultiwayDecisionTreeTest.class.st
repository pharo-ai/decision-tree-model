Class {
	#name : #AIDTMultiwayDecisionTreeTest,
	#superclass : #TestCase,
	#instVars : [
		'tennisDecisionTree'
	],
	#category : #'AI-DecisionTree-Tests'
}

{ #category : #running }
AIDTMultiwayDecisionTreeTest >> setUp [
	| overcastNode |
	super setUp.
	tennisDecisionTree := AIDTMultiwayDecisionTree withCondition: [ :weather | weather at: #outlook].
	
	tennisDecisionTree at: #rain addChild: (AIDTDecision withLabel: 'stay home').
	tennisDecisionTree at: #sunny addChild: (AIDTDecision withLabel: 'play tennis').
	tennisDecisionTree at: #overcast addChild: (AIDTMultiwayDecisionTree withCondition: [ :weather | weather at: #wind]).
	overcastNode := tennisDecisionTree childAt: #overcast.
	overcastNode at: #strong addChild: (AIDTDecision withLabel: 'stay home').
	overcastNode at: #weak addChild: (AIDTDecision withLabel: 'play tennis').
]

{ #category : #tests }
AIDTMultiwayDecisionTreeTest >> testHeight [
	self assert: tennisDecisionTree height equals: 2
]

{ #category : #tests }
AIDTMultiwayDecisionTreeTest >> testPlayTennisWhenOvercastAndWeakWind [

	| weather decision expected |	
	weather := { #outlook -> #overcast . #wind -> #weak} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := 'play tennis'.
	self assert: decision label equals: expected.
]

{ #category : #tests }
AIDTMultiwayDecisionTreeTest >> testPlayTennisWhenSunny [

	| weather decision expected |	
	weather := { #outlook -> #sunny . #wind -> #strong} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := 'play tennis'.
	self assert: decision label equals: expected.
]

{ #category : #tests }
AIDTMultiwayDecisionTreeTest >> testStayHomeWhenRainy [

	| weather decision expected |	
	weather := { #outlook -> #rain . #wind -> #weak} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := 'stay home'.
	self assert: decision label equals: expected.
]

{ #category : #tests }
AIDTMultiwayDecisionTreeTest >> testWhyPlayTennisWhenOvercastAndWeakWind [

	| weather decision expected |	
	weather := { #outlook -> #overcast . #wind -> #weak} asDictionary.
	decision := tennisDecisionTree decisionFor: weather.
	expected := { tennisDecisionTree condition -> #overcast .
					  (tennisDecisionTree childAt: #overcast) condition -> #weak } asOrderedCollection.
	self assert: decision why equals: expected.
]
