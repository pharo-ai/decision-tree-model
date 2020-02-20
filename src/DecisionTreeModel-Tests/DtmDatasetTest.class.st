Class {
	#name : #DtmDatasetTest,
	#superclass : #DtmDecisionTreeModelTest,
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsFeature [
	self assert: (tennisDataset checkIsFeature: #playTennis)
]

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsFeatureFalseForTarget [
	tennisDataset target: #playTennis.
	self deny: (tennisDataset checkIsFeature: #playTennis)
]

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsFeatureIsFalse [
	tennisDataset features: #(outlook temperature).
	self deny: (tennisDataset checkIsFeature: #humidity)
]

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsFeatureIsTrue [
	tennisDataset features: #(outlook temperature).
	self assert: (tennisDataset checkIsFeature: #outlook)
]

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsValidFeature [
	self assert: (tennisDataset checkIsValidFeature: #outlook)
]

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsValidFeatureIsFalseForTarget [
	tennisDataset target: #playTennis.
	self deny: (tennisDataset checkIsValidFeature: #playTennis)
]

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsValidTarget [
	self assert: (tennisDataset checkIsValidFeature: #playTennis)
]

{ #category : #'test - checking' }
DtmDatasetTest >> testCheckIsValidTargetIsFalse [
	self deny: (tennisDataset checkIsValidFeature: #somethingInvalid)
]

{ #category : #test }
DtmDatasetTest >> testDefaultFeaturesStartsWithAllColumns [
	self assert: tennisDataset defaultFeatures size equals: tennisDataset dataframe numberOfColumns 
]

{ #category : #test }
DtmDatasetTest >> testDo [
	| arrayOfPoints newDataset  addedMaxs|
	arrayOfPoints := arrayOfPoints := {Point x: 10 y: 5 . Point x: 5 y: 0} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	addedMaxs := 0.
	newDataset do: [ :each | addedMaxs := addedMaxs + (each at: #max) ].
	self assert: addedMaxs equals: 15
]

{ #category : #'test - metrics' }
DtmDatasetTest >> testEntropyOf [
	| actual expected |
	actual := tennisDataset entropyOf: 'playTennis'.
	expected := 0.940285958670631.
	self assert: actual equals: expected.
]

{ #category : #'test - metrics' }
DtmDatasetTest >> testEntropyOfTarget [
	| actual expected |
	tennisDataset target: #playTennis.
	actual := tennisDataset entropyOfTarget.
	expected := 0.940285958670631.
	self assert: actual equals: expected.
]

{ #category : #'test - metrics' }
DtmDatasetTest >> testEntropyWhenSelectingRows [
	| selectedRows actual expected |	
	selectedRows := tennisDataset select: [ :row|(row at: #outlook) = #sunny ].
	actual := selectedRows entropyOf: 'playTennis'.
	expected := 0.9709505944546687.
	self assert: actual equals: expected.
]

{ #category : #test }
DtmDatasetTest >> testFeatureAtRaisesError [
	self should: [ tennisDataset featureAt: #somethingInvalid ] raise: NotFound
]

{ #category : #test }
DtmDatasetTest >> testFeatureNotFoundError [
	self should: [ tennisDataset featureNotFoundError: #something ] raise: NotFound
]

{ #category : #test }
DtmDatasetTest >> testFeaturesAtWhenInitializedFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 5 . Point x: 5 y: 0} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	self assert: (newDataset featureAt: #min) asArray equals: #(5 0)
]

{ #category : #test }
DtmDatasetTest >> testFeaturesDoesNotIncludeTarget [
	tennisDataset target: #playTennis.
	self deny: (tennisDataset features includes:  #playTennis)
]

{ #category : #test }
DtmDatasetTest >> testFeaturesWhenInitializedFromArray [
	| arrayOfPoints newDataset featureArray |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	featureArray := #(degrees min max).
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: featureArray.
	self assert: newDataset features asArray equals: featureArray
]

{ #category : #'test - initialize' }
DtmDatasetTest >> testFromArrayWithFeaturesWithTarget [
	| arrayOfPoints newDataset |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(min max) withTarget: #degrees.
	self assert: newDataset dataframe class equals: DataFrame 
]

{ #category : #'test - initialize' }
DtmDatasetTest >> testFromArrayWithFeaturesWithTargetSetsFeatures [
	| arrayOfPoints newDataset |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(min max) withTarget: #degrees.
	self assert: newDataset features size equals: 2
]

{ #category : #'test - initialize' }
DtmDatasetTest >> testFromArrayWithFeaturesWithTargetSetsTarget [
	| arrayOfPoints newDataset |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(min max) withTarget: #degrees.
	self assert: newDataset target equals: #degrees
]

{ #category : #'test - initialize' }
DtmDatasetTest >> testInitializeFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	self assert: newDataset dataframe class equals: DataFrame 
]

{ #category : #test }
DtmDatasetTest >> testInvalidFeatureError [
	self should: [ tennisDataset invalidFeatureError: #something ] raise: Exception
]

{ #category : #test }
DtmDatasetTest >> testInvalidTargetError [
	self should: [ tennisDataset invalidTargetError: #something ] raise: Exception
]

{ #category : #test }
DtmDatasetTest >> testIsEmpty [
	| arrayOfPoints newDataset|
	arrayOfPoints := #().
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	self assert: newDataset isEmpty 
]

{ #category : #test }
DtmDatasetTest >> testReject [
	| arrayOfPoints newDataset selectedDataset |
	arrayOfPoints := arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	selectedDataset := newDataset reject: [ :each | (each at: #max) = 10].
	self assert: selectedDataset size equals: 1
]

{ #category : #test }
DtmDatasetTest >> testSelect [
	| arrayOfPoints newDataset selectedDataset |
	arrayOfPoints := arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	selectedDataset := newDataset select: [ :each | (each at: #max) = 10].
	self assert: selectedDataset size equals: 1
]

{ #category : #'test - initialize' }
DtmDatasetTest >> testSizeWhenInitializedFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	self assert: newDataset size equals: 2 
]

{ #category : #test }
DtmDatasetTest >> testTargetColumn [
	| arrayOfPoints newDataset |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(min degrees) withTarget: #max.
	self assert: newDataset targetColumn asArray equals: #(10 5)
]

{ #category : #'test - initialize' }
DtmDatasetTest >> testWithColumnsWithFeatures [
	| newDataset|
	newDataset := DtmDataset withColumns: #(#(1 2 3) #(4 5 6)) withFeatures: #(feat1 feat2).
	self assert: newDataset dataframe dimensions equals: 3@2
]

{ #category : #'test - checking' }
DtmDatasetTest >> testWithRowsWithFeatures [
	| newDataset|
	newDataset := DtmDataset withRows: #( #(1 2 3) #(4 5 6)) withFeatures: #(feat1 feat2 feat3).
	self assert: newDataset dataframe dimensions equals: 2@3
]
