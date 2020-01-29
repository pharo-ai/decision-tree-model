Class {
	#name : #DtmColumnDiscretizerTest,
	#superclass : #TestCase,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmColumnDiscretizerTest >> testIsFitted [
	| aDataSeries aDiscretizer|
	aDataSeries := DataSeries withValues: #(1 2 3 4 5 6 7).
	aDiscretizer := DtmColumnDiscretizer new.
	aDiscretizer fit: aDataSeries.
	self assert: aDiscretizer isFitted
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testStep [
	| discretizer |
	discretizer := DtmColumnDiscretizer new.
	discretizer fit: #(0 10).
	self assert: (discretizer step) equals: 2
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testTransformReturnsADataSeries [
	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := DataSeries withValues: #(1 2 3 4 5 6 7).
	aDiscretizer := DtmColumnDiscretizer new.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: newDataSeries class equals: DataSeries 
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testTransformReturnsADataSeriesWithLessUniqueValuesThanBins [
	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := DataSeries withValues: #(1 2 3 4 5 6 7).
	aDiscretizer := DtmColumnDiscretizer withNumberOfBins: 5.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: (newDataSeries uniqueValues size <= 5)
]

{ #category : #tests }
DtmColumnDiscretizerTest >> testTransformReturnsArrayOfIntervals [
	| aDataSeries aDiscretizer discretizedDataSeries |
	aDataSeries := DataSeries withValues: #(0 1 2 3 4 5 6 7 8 9 10).
	aDiscretizer := DtmColumnDiscretizer new.
	discretizedDataSeries := aDiscretizer fitTransform: aDataSeries.
	self assert: discretizedDataSeries anyOne class equals: DtmInterval
]
