Class {
	#name : #DtmC45DecisionTreeModel,
	#superclass : #DtmID3DecisionTreeModel,
	#category : #DecisionTreeModel
}

{ #category : #metrics }
DtmC45DecisionTreeModel >> gainMeasureOf: aDataset given: aSplitter [
	"C4.5 implements gain ratio as measure"
	| gainMeasure impurityOfSplit splitInformation |
	
	gainMeasure := self impurityMeasureOf: aDataset.
	splitInformation := 0.
	aSplitter forDataset: aDataset splitsDo: [:datasetSplit | 
		impurityOfSplit := self impurityMeasureOf: datasetSplit.
		gainMeasure := gainMeasure - ((datasetSplit size / aDataset size) * impurityOfSplit).
		splitInformation := splitInformation - ((datasetSplit size / aDataset size) * 
			((datasetSplit size / aDataset size) log: 2))
	].
	^ gainMeasure / splitInformation
]

{ #category : #splitting }
DtmC45DecisionTreeModel >> numericalSplitterClass [	
	^ DtmNumericalSplitter 
]
