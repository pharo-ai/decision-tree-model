Class {
	#name : #DtmIntervalTest,
	#superclass : #TestCase,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmIntervalTest >> testIncludes [
	| interval |
	interval := DtmInterval min: 0 max: 5.
	self assert: (interval includes: 4)
]

{ #category : #tests }
DtmIntervalTest >> testNotIncludes [
	| interval |
	interval := DtmInterval min: 0 max: 5.
	self deny: (interval includes: 7)
]

{ #category : #tests }
DtmIntervalTest >> testPrintOn [
	| interval |
	interval := DtmInterval min: 0 max: 5.
	self assert: interval printString equals: 'DtmInterval( [0, 5) )'
]
