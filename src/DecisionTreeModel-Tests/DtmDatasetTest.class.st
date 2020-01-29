Class {
	#name : #DtmDatasetTest,
	#superclass : #DtmDecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmDatasetTest >> testEntropyOf [
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
DtmDatasetTest >> testFeaturesAtWhenInitializedFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 5 . Point x: 5 y: 0} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(degrees min max).
	self assert: (newDataset featureAt: #min) asArray equals: #(5 0)
]

{ #category : #running }
DtmDatasetTest >> testFeaturesWhenInitializedFromArray [
	| arrayOfPoints newDataset featureArray |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	featureArray := #(degrees min max).
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: featureArray.
	self assert: newDataset features asArray equals: featureArray
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

{ #category : #running }
DtmDatasetTest >> testInitializeFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(degrees min max).
	self assert: newDataset dataframe class equals: DataFrame 
]

{ #category : #running }
DtmDatasetTest >> testIsEmpty [
	| arrayOfPoints newDataset|
	arrayOfPoints := #().
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(degrees min max).
	self assert: newDataset isEmpty 
]

{ #category : #running }
DtmDatasetTest >> testSizeWhenInitializedFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(degrees min max).
	self assert: newDataset size equals: 2 
]
