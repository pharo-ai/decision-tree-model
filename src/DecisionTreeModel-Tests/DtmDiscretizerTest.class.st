Class {
	#name : #DtmDiscretizerTest,
	#superclass : #TestCase,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #tests }
DtmDiscretizerTest >> testIsFitted [
	| aDataSeries aDiscretizer|
	aDataSeries := DataSeries withValues: #(1 2 3 4 5 6 7).
	aDiscretizer := DtmDiscretizer new.
	aDiscretizer fit: aDataSeries.
	self assert: aDiscretizer isFitted
]

{ #category : #tests }
DtmDiscretizerTest >> testTransformReturnsADataSeries [
	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := DataSeries withValues: #(1 2 3 4 5 6 7).
	aDiscretizer := DtmDiscretizer new.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: newDataSeries class equals: DataSeries 
]

{ #category : #tests }
DtmDiscretizerTest >> testTransformReturnsADataSeriesWithLessUniqueValuesThanBins [
	| aDataSeries aDiscretizer newDataSeries |
	aDataSeries := DataSeries withValues: #(1 2 3 4 5 6 7).
	aDiscretizer := DtmDiscretizer withNumberOfBins: 5.
	aDiscretizer fit: aDataSeries.
	newDataSeries := aDiscretizer transform: aDataSeries.
	self assert: (newDataSeries uniqueValues size <= 5)
]
