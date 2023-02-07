Class {
	#name : #AIDTDiscretizerTest,
	#superclass : #TestCase,
	#instVars : [
		'testDataset'
	],
	#category : #'AI-DecisionTreeModel-Preprocessing-Tests'
}

{ #category : #running }
AIDTDiscretizerTest >> setUp [
	| arrayOfPoints |
	super setUp.
	arrayOfPoints := (0 to: 10) collect: [ :each | Point x: each y: (each + 10)].
	testDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max isZero)
]

{ #category : #running }
AIDTDiscretizerTest >> testDiscretizableColumnsOf [
	| discretizer |
	discretizer := AIDTDiscretizer new.
	self assert: (discretizer discretizableColumnsOf: testDataset) size equals: 3
]

{ #category : #running }
AIDTDiscretizerTest >> testDiscretizableColumnsOfDoesIncludeValidFeature [
	| discretizer |
	discretizer := AIDTDiscretizer new.
	self assert: ((discretizer discretizableColumnsOf: testDataset) includes: #min)
]

{ #category : #running }
AIDTDiscretizerTest >> testDiscretizableColumnsOfDoesNotIncludeInvalidFeature [
	| discretizer |
	discretizer := AIDTDiscretizer new.
	self deny:( (discretizer discretizableColumnsOf: testDataset) includes: #isZero)
]

{ #category : #running }
AIDTDiscretizerTest >> testDiscretizerAtFit [
	| discretizer |
	discretizer := AIDTDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	self deny: discretizer isEmpty
]

{ #category : #running }
AIDTDiscretizerTest >> testDiscretizerAtTransformReturnsArrayOfIntervals [
	| discretizer newColumn |
	discretizer := AIDTDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	newColumn := discretizer discretizerAt: #min transform: #(1).
	self assert: newColumn anyOne class equals: AIDTInterval
]

{ #category : #running }
AIDTDiscretizerTest >> testDiscretizerAtTransformReturnsIntervalWithCorrectMax [
	| discretizer newColumn |
	discretizer := AIDTDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	newColumn := discretizer discretizerAt: #min transform: #(3).
	self assert: newColumn anyOne max equals: 4
]

{ #category : #running }
AIDTDiscretizerTest >> testDiscretizerAtTransformReturnsIntervalWithCorrectMin [
	| discretizer newColumn |
	discretizer := AIDTDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	newColumn := discretizer discretizerAt: #min transform: #(3).
	self assert: newColumn anyOne min equals: 2
]

{ #category : #running }
AIDTDiscretizerTest >> testFit [
	| discretizer |
	discretizer := AIDTDiscretizer new.
	discretizer fit: testDataset.
	self assert: discretizer columnDiscretizers size  equals: 3
]

{ #category : #running }
AIDTDiscretizerTest >> testFitTransform [
	| discretizer |
	discretizer := AIDTDiscretizer new.
	discretizer fitTransform: testDataset.
	self assert: ((discretizer discretizableColumnsOf: testDataset) allSatisfy: [
		:each | (testDataset columnAt: each) asSet size <= 5])
]

{ #category : #running }
AIDTDiscretizerTest >> testTransform [
	| discretizer |
	discretizer := AIDTDiscretizer new.
	discretizer fit: testDataset.
	discretizer transform: testDataset.
	self assert: ((discretizer discretizableColumnsOf: testDataset) allSatisfy: [
		:each | (testDataset columnAt: each) asSet size <= 5])
]
