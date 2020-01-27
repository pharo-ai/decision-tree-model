Class {
	#name : #DtmDataset,
	#superclass : #DataFrame,
	#category : #DecisionTreeModel
}

{ #category : #metrics }
DtmDataset >> entropyOf: aColumnName [
	| targetColumn probabilities |
	targetColumn := self column: aColumnName.
	probabilities := targetColumn valueCounts / targetColumn size.
	^ (probabilities * (probabilities log: 2)) sum negated
]

{ #category : #metrics }
DtmDataset >> informationGainOf: aTargetName given: anAttributeName [
	| informationGain selectedRowsGivenAttribute entropyOfSelected |
	informationGain := self entropyOf: aTargetName.
	(self column: anAttributeName) uniqueValues do: [ :each | 
		selectedRowsGivenAttribute := self select: [ :rows | (rows at: anAttributeName) = each ].
		entropyOfSelected := selectedRowsGivenAttribute entropyOf: aTargetName.
		informationGain := informationGain - ((selectedRowsGivenAttribute size / self size) * entropyOfSelected).
	].
	^ informationGain
]
