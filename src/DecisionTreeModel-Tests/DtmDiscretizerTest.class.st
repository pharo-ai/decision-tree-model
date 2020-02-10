Class {
	#name : #DtmDiscretizerTest,
	#superclass : #TestCase,
	#instVars : [
		'testDataset'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmDiscretizerTest >> setUp [ 
	| arrayOfPoints |
	super setUp.
	arrayOfPoints := (0 to: 10) collect: [ :each | Point x: each y: (each + 10)].
	testDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max isZero).
]

{ #category : #running }
DtmDiscretizerTest >> testDiscretizableColumnsOf [
	| discretizer |
	discretizer := DtmDiscretizer new.
	self assert: (discretizer discretizableColumnsOf: testDataset) size equals: 3
]

{ #category : #running }
DtmDiscretizerTest >> testDiscretizableColumnsOfDoesIncludeValidFeature [
	| discretizer |
	discretizer := DtmDiscretizer new.
	self assert: ((discretizer discretizableColumnsOf: testDataset) includes: #min)
]

{ #category : #running }
DtmDiscretizerTest >> testDiscretizableColumnsOfDoesNotIncludeInvalidFeature [
	| discretizer |
	discretizer := DtmDiscretizer new.
	self deny:( (discretizer discretizableColumnsOf: testDataset) includes: #isZero)
]

{ #category : #running }
DtmDiscretizerTest >> testDiscretizerAtFit [
	| discretizer |
	discretizer := DtmDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	self deny: discretizer isEmpty 
]

{ #category : #running }
DtmDiscretizerTest >> testDiscretizerAtTransformReturnsArrayOfIntervals [
	| discretizer newColumn |
	discretizer := DtmDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	newColumn := discretizer discretizerAt: #min transform: #(1).
	self assert: newColumn anyOne class equals: DtmInterval
]

{ #category : #running }
DtmDiscretizerTest >> testDiscretizerAtTransformReturnsIntervalWithCorrectMax [
	| discretizer newColumn |
	discretizer := DtmDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	newColumn := discretizer discretizerAt: #min transform: #(3).
	self assert: newColumn anyOne max equals: 4
]

{ #category : #running }
DtmDiscretizerTest >> testDiscretizerAtTransformReturnsIntervalWithCorrectMin [
	| discretizer newColumn |
	discretizer := DtmDiscretizer new.
	discretizer discretizerAt: #min fit: (testDataset featureAt: #min).
	newColumn := discretizer discretizerAt: #min transform: #(3).
	self assert: newColumn anyOne min equals: 2
]

{ #category : #running }
DtmDiscretizerTest >> testFit [
	| discretizer |
	discretizer := DtmDiscretizer new.
	discretizer fit: testDataset.
	self assert: discretizer columnDiscretizers size  equals: 3
]

{ #category : #running }
DtmDiscretizerTest >> testFitTransform [
	| discretizer |
	discretizer := DtmDiscretizer new.
	discretizer fitTransform: testDataset.
	self assert: ((discretizer discretizableColumnsOf: testDataset) allSatisfy: [
		:each | (testDataset columnAt: each) asSet size <= 5])
]

{ #category : #running }
DtmDiscretizerTest >> testTransform [
	| discretizer |
	discretizer := DtmDiscretizer new.
	discretizer fit: testDataset.
	discretizer transform: testDataset.
	self assert: ((discretizer discretizableColumnsOf: testDataset) allSatisfy: [
		:each | (testDataset columnAt: each) asSet size <= 5])
]
