Class {
	#name : #AIDTColumnDiscretizerTest,
	#superclass : #TestCase,
	#category : #'AI-DecisionTreeModel-Preprocessing-Tests'
}

{ #category : #tests }
AIDTColumnDiscretizerTest >> testIsFitted [

	| aDataSeries aDiscretizer |
	aDataSeries := #( 1 2 3 4 5 6 7 ).
	aDiscretizer := AIDTColumnDiscretizer new.
	aDiscretizer fit: aDataSeries.
	self assert: aDiscretizer isFitted
]

{ #category : #tests }
AIDTColumnDiscretizerTest >> testStep [
	| discretizer |
	discretizer := AIDTColumnDiscretizer new.
	discretizer fit: #(0 10).
	self assert: discretizer step equals: 2
]

{ #category : #tests }
AIDTColumnDiscretizerTest >> testTransformReturnsADataSeries [

	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := #( 1 2 3 4 5 6 7 ).
	aDiscretizer := DtmColumnDiscretizer new.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: (newDataSeries allSatisfy: [ :each | each class = AIDTInterval ])
]

{ #category : #tests }
AIDTColumnDiscretizerTest >> testTransformReturnsADataSeriesWithLessUniqueValuesThanBins [

	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := #( 1 2 3 4 5 6 7 ).
	aDiscretizer := AIDTColumnDiscretizer withNumberOfBins: 5.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: newDataSeries asSet size <= 5
]

{ #category : #tests }
AIDTColumnDiscretizerTest >> testTransformReturnsArrayOfIntervals [

	| aDataSeries aDiscretizer discretizedDataSeries |
	aDataSeries := #( 0 1 2 3 4 5 6 7 8 9 10 ).
	aDiscretizer := DtmColumnDiscretizer new.
	discretizedDataSeries := aDiscretizer fitTransform: aDataSeries.
	self assert: discretizedDataSeries anyOne class equals: AIDTInterval
]
