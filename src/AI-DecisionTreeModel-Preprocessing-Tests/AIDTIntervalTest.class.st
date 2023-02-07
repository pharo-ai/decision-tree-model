Class {
	#name : #AIDTIntervalTest,
	#superclass : #TestCase,
	#category : #'AI-DecisionTreeModel-Preprocessing-Tests'
}

{ #category : #tests }
AIDTIntervalTest >> testIncludes [
	| interval |
	interval := AIDTInterval min: 0 max: 5.
	self assert: (interval includes: 4)
]

{ #category : #tests }
AIDTIntervalTest >> testNotIncludes [
	| interval |
	interval := AIDTInterval min: 0 max: 5.
	self deny: (interval includes: 7)
]

{ #category : #tests }
AIDTIntervalTest >> testPrintOn [
	| interval |
	interval := AIDTInterval min: 0 max: 5.
	self assert: interval printString equals: 'AIDTInterval( [0, 5) )'
]
