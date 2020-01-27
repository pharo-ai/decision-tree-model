Class {
	#name : #DtmDatasetTest,
	#superclass : #DtmDecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmDatasetTest >> testEntropy [
	| actual expected |
	actual := tennisTable entropyOf: 'playTennis'.
	expected := 0.940285958670631.
	self assert: actual equals: expected.
]

{ #category : #running }
DtmDatasetTest >> testEntropyWhenSelectingRows [
	| selectedRows actual expected |	
	selectedRows := tennisTable select: [ :row|(row at: #outlook) = #sunny ].
	actual := selectedRows entropyOf: 'playTennis'.
	expected := 0.9709505944546687.
	self assert: actual equals: expected.
]

{ #category : #running }
DtmDatasetTest >> testInformationGainOfGivenHumidity [
	| actual expected |
	actual := tennisTable informationGainOf: #playTennis given: #humidity.
	expected := 0.15183550136234147.
	self assert: actual equals: expected.
]

{ #category : #running }
DtmDatasetTest >> testInformationGainOfGivenOutlook [
	| actual expected |
	actual := tennisTable informationGainOf: #playTennis given: #outlook.
	expected := 0.24674981977443905.
	self assert: actual equals: expected.
]

{ #category : #running }
DtmDatasetTest >> testInformationGainOfGivenWind [
	| actual expected |
	actual := tennisTable informationGainOf: #playTennis given: #wind.
	expected := 0.0481270304082696.
	self assert: actual equals: expected.
]
