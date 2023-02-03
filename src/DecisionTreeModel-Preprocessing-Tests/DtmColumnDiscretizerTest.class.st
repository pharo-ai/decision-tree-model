Class {
	#name : #DtmColumnDiscretizerTest,
	#superclass : #TestCase,
	#category : #'DecisionTreeModel-Preprocessing-Tests'
}

{ #category : #tests }
DtmColumnDiscretizerTest >> testIsFitted [

	| aDataSeries aDiscretizer |
	aDataSeries := #( 1 2 3 4 5 6 7 ).
	aDiscretizer := DtmColumnDiscretizer new.
	aDiscretizer fit: aDataSeries.
	self assert: aDiscretizer isFitted
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testStep [
	| discretizer |
	discretizer := DtmColumnDiscretizer new.
	discretizer fit: #(0 10).
	self assert: discretizer step equals: 2
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testTransformReturnsADataSeries [

	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := #( 1 2 3 4 5 6 7 ).
	aDiscretizer := DtmColumnDiscretizer new.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: (newDataSeries allSatisfy: [ :each | each class = DtmInterval ])
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testTransformReturnsADataSeriesWithLessUniqueValuesThanBins [

	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := #( 1 2 3 4 5 6 7 ).
	aDiscretizer := DtmColumnDiscretizer withNumberOfBins: 5.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: newDataSeries asSet size <= 5
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testTransformReturnsArrayOfIntervals [

	| aDataSeries aDiscretizer discretizedDataSeries |
	aDataSeries := #( 0 1 2 3 4 5 6 7 8 9 10 ).
	aDiscretizer := DtmColumnDiscretizer new.
	discretizedDataSeries := aDiscretizer fitTransform: aDataSeries.
	self assert: discretizedDataSeries anyOne class equals: DtmInterval
]
