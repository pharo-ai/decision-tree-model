Class {
	#name : #DtmDataset,
	#superclass : #Object,
	#instVars : [
		'dataframe'
	],
	#category : #DecisionTreeModel
}

{ #category : #'instance creation' }
DtmDataset class >> fromDataFrame: aDataFrame [
	^ self new dataframe: aDataFrame; yourself 
]

{ #category : #accessing }
DtmDataset >> dataframe [
	^ dataframe
]

{ #category : #accessing }
DtmDataset >> dataframe: aDataFrame [
	dataframe := aDataFrame
]

{ #category : #enumerating }
DtmDataset >> do: aBlock [
	^ self dataframe do: aBlock 
]

{ #category : #metrics }
DtmDataset >> entropyOf: aColumnName [
	| targetColumn probabilities |
	targetColumn := self dataframe column: aColumnName.
	probabilities := targetColumn valueCounts / targetColumn size.
	^ (probabilities * (probabilities log: 2)) sum negated
]

{ #category : #accessing }
DtmDataset >> featureAt: aName [
	^ self dataframe column: aName
	
]

{ #category : #metrics }
DtmDataset >> informationGainOf: aTargetName given: anAttributeName [
	| informationGain selectedRowsGivenAttribute entropyOfSelected |
	informationGain := self entropyOf: aTargetName.
	(self  featureAt: anAttributeName) uniqueValues do: [ :each | 
		selectedRowsGivenAttribute := self select: [ :rows | (rows at: anAttributeName) = each ].
		entropyOfSelected := selectedRowsGivenAttribute entropyOf: aTargetName.
		informationGain := informationGain - ((selectedRowsGivenAttribute size / self size) * entropyOfSelected).
	].
	^ informationGain
]

{ #category : #enumerating }
DtmDataset >> reject: aBlock [
	| selectedRows |
	selectedRows := self dataframe reject: aBlock.
	^ self class fromDataFrame: selectedRows
]

{ #category : #enumerating }
DtmDataset >> select: aBlock [
	| selectedRows |
	selectedRows := self dataframe select: aBlock.
	^ self class fromDataFrame: selectedRows
]

{ #category : #accessing }
DtmDataset >> size [
	^ dataframe size
]
