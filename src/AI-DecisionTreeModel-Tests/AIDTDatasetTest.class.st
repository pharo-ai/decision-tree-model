Class {
	#name : 'AIDTDatasetTest',
	#superclass : 'AIDTDecisionTreeModelTest',
	#category : 'AI-DecisionTreeModel-Tests',
	#package : 'AI-DecisionTreeModel-Tests'
}

{ #category : 'test' }
AIDTDatasetTest >> testAllFeaturesAreEqual [
	| testDataset |
	testDataset := AIDTDataset
		fromArray: #(#(0 2) #(0 5) #(0 10) #(0 20))
		withFeatures: #(first)
		withTarget: #second.
	self assert: testDataset allFeaturesAreEqual
]

{ #category : 'test' }
AIDTDatasetTest >> testAllFeaturesAreEqualIsFalse [
	| testDataset |
	testDataset := AIDTDataset
		fromArray: #(#(0 2) #(0 5) #(1 10) #(0 20))
		withFeatures: #(first)
		withTarget: #second.
	self deny: testDataset allFeaturesAreEqual
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsFeature [
	self assert: (tennisDataset checkIsFeature: #playTennis)
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsFeatureFalseForTarget [
	tennisDataset target: #playTennis.
	self deny: (tennisDataset checkIsFeature: #playTennis)
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsFeatureIsFalse [
	tennisDataset features: #(outlook temperature).
	self deny: (tennisDataset checkIsFeature: #humidity)
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsFeatureIsTrue [
	tennisDataset features: #(outlook temperature).
	self assert: (tennisDataset checkIsFeature: #outlook)
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsValidFeature [
	self assert: (tennisDataset checkIsValidFeature: #outlook)
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsValidFeatureIsFalseForTarget [
	tennisDataset target: #playTennis.
	self deny: (tennisDataset checkIsValidFeature: #playTennis)
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsValidTarget [
	self assert: (tennisDataset checkIsValidFeature: #playTennis)
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testCheckIsValidTargetIsFalse [
	self deny: (tennisDataset checkIsValidFeature: #somethingInvalid)
]

{ #category : 'test' }
AIDTDatasetTest >> testDefaultFeaturesStartsWithAllColumns [

	self assert: tennisDataset defaultFeatures size equals: tennisDataset datas anyOne size
]

{ #category : 'test - enumerating' }
AIDTDatasetTest >> testDo [
	| arrayOfPoints newDataset  addedMaxs|
	arrayOfPoints := arrayOfPoints := {Point x: 10 y: 5 . Point x: 5 y: 0} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	addedMaxs := 0.
	newDataset do: [ :each | addedMaxs := addedMaxs + (each at: #max) ].
	self assert: addedMaxs equals: 15
]

{ #category : 'test - metrics' }
AIDTDatasetTest >> testEntropyOf [

	| actual |
	actual := tennisDataset entropyOf: 'playTennis'.
	self 
		assert: actual 
		closeTo:  0.940285958670631.
]

{ #category : 'test - metrics' }
AIDTDatasetTest >> testEntropyOfTarget [

	| actual |
	tennisDataset target: #playTennis.
	actual := tennisDataset entropyOfTarget.   	
	self 
		assert: actual 
		closeTo: 0.940285958670631.
]

{ #category : 'test - metrics' }
AIDTDatasetTest >> testEntropyWhenSelectingRows [

	| selectedRows actual |
	selectedRows := tennisDataset select: [ :row|(row at: #outlook) = #sunny ].
	actual := selectedRows entropyOf: 'playTennis'.
	self 
		assert: actual 
		closeTo: 0.9709505944546687.
]

{ #category : 'test - metrics' }
AIDTDatasetTest >> testEntropyWhenSelectingRowsWithZero [

	| selectedRows actual |
	selectedRows := tennisDataset select: [ :row| (row at: #outlook) = #overcast ].
	actual := selectedRows entropyOf: 'playTennis'.

	self assert: actual equals: 0
]

{ #category : 'test' }
AIDTDatasetTest >> testFeatureAtRaisesError [
	self should: [ tennisDataset featureAt: #somethingInvalid ] raise: NotFound
]

{ #category : 'test' }
AIDTDatasetTest >> testFeatureNotFoundError [
	self should: [ tennisDataset featureNotFoundError: #something ] raise: NotFound
]

{ #category : 'test' }
AIDTDatasetTest >> testFeaturesAtWhenInitializedFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 5 . Point x: 5 y: 0} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	self assert: (newDataset featureAt: #min) asArray equals: #(5 0)
]

{ #category : 'test' }
AIDTDatasetTest >> testFeaturesDoesNotIncludeTarget [
	tennisDataset target: #playTennis.
	self deny: (tennisDataset features includes:  #playTennis)
]

{ #category : 'test' }
AIDTDatasetTest >> testFeaturesWhenInitializedFromArray [
	| arrayOfPoints newDataset featureArray |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	featureArray := #(degrees min max).
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: featureArray.
	self assert: newDataset features asArray equals: featureArray
]

{ #category : 'test - initialize' }
AIDTDatasetTest >> testFromArrayWithFeaturesWithTarget [

	| arrayOfPoints newDataset |
	arrayOfPoints := {
		                 (Point x: 10 y: 10).
		                 (Point x: 5 y: 5) } asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withFeatures: #( min max ) withTarget: #degrees.
	self assert: newDataset datas equals: #( #( 10 10 45.0 ) #( 5 5 45.0 ) )
]

{ #category : 'test - initialize' }
AIDTDatasetTest >> testFromArrayWithFeaturesWithTargetSetsFeatures [
	| arrayOfPoints newDataset |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withFeatures: #(min max) withTarget: #degrees.
	self assert: newDataset features size equals: 2
]

{ #category : 'test - initialize' }
AIDTDatasetTest >> testFromArrayWithFeaturesWithTargetSetsTarget [
	| arrayOfPoints newDataset |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withFeatures: #(min max) withTarget: #degrees.
	self assert: newDataset target equals: #degrees
]

{ #category : 'test - metrics' }
AIDTDatasetTest >> testGiniIndexOfTarget [
	
	| actual |
	fruitDataset target: #fruit.
	actual := fruitDataset giniIndexOfTarget.
	
	self 
		assert: actual 
		closeTo: 0.64
]

{ #category : 'test - metrics' }
AIDTDatasetTest >> testGiniIndexWhenSelectingRows [

	| selectedRows actual |
	selectedRows := tennisDataset select: [ :row|(row at: #outlook) = #sunny ].
	actual := selectedRows giniIndexOf: 'playTennis'.
	self 
		assert: actual 
		closeTo: 0.48.
]

{ #category : 'test - initialize' }
AIDTDatasetTest >> testInitializeFromArray [

	| arrayOfPoints newDataset |
	arrayOfPoints := {
		                 (Point x: 10 y: 10).
		                 (Point x: 5 y: 5) } asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #( min max degrees ).
	self assert: newDataset datas equals: #( #( 10 10 45.0 ) #( 5 5 45.0 ) )
]

{ #category : 'test' }
AIDTDatasetTest >> testInvalidFeatureError [
	self should: [ tennisDataset invalidFeatureError: #something ] raise: Exception
]

{ #category : 'test' }
AIDTDatasetTest >> testInvalidTargetError [
	self should: [ tennisDataset invalidTargetError: #something ] raise: Exception
]

{ #category : 'test' }
AIDTDatasetTest >> testIsEmpty [
	| arrayOfPoints newDataset|
	arrayOfPoints := #().
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	self assert: newDataset isEmpty
]

{ #category : 'test - enumerating' }
AIDTDatasetTest >> testReject [
	| arrayOfPoints newDataset selectedDataset |
	arrayOfPoints := arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	selectedDataset := newDataset reject: [ :each | (each at: #max) = 10].
	self assert: selectedDataset size equals: 1
]

{ #category : 'test - enumerating' }
AIDTDatasetTest >> testSelect [
	| arrayOfPoints newDataset selectedDataset |
	arrayOfPoints := arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	selectedDataset := newDataset select: [ :each | (each at: #max) = 10].
	self assert: selectedDataset size equals: 1
]

{ #category : 'test - initialize' }
AIDTDatasetTest >> testSizeWhenInitializedFromArray [
	| arrayOfPoints newDataset|
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	self assert: newDataset size equals: 2
]

{ #category : 'test - enumerating' }
AIDTDatasetTest >> testSplit [
	| arrayOfPoints newDataset selectedDataset |
	arrayOfPoints := arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
	selectedDataset := newDataset split: [ :each | (each at: #max) = 10].
	self assert: selectedDataset class equals: AIDTDatasetSplit
]

{ #category : 'test' }
AIDTDatasetTest >> testTargetColumn [
	| arrayOfPoints newDataset |
	arrayOfPoints := {Point x: 10 y: 10 . Point x: 5 y: 5} asArray.
	newDataset := AIDTDataset fromArray: arrayOfPoints withFeatures: #(min degrees) withTarget: #max.
	self assert: newDataset targetColumn asArray equals: #(10 5)
]

{ #category : 'test - initialize' }
AIDTDatasetTest >> testWithColumnsWithFeatures [

	| newDataset |
	newDataset := AIDTDataset withColumns: #( #( 1 2 3 ) #( 4 5 6 ) ) withFeatures: #( feat1 feat2 ).
	self assert: newDataset size equals: 3.
	self assert: newDataset datas anyOne size equals: 2
]

{ #category : 'test - checking' }
AIDTDatasetTest >> testWithRowsWithFeatures [

	| newDataset |
	newDataset := AIDTDataset withRows: #( #( 1 2 3 ) #( 4 5 6 ) ) withFeatures: #( feat1 feat2 feat3 ).

	self assert: newDataset size equals: 2.
	self assert: newDataset datas anyOne size equals: 3
]
