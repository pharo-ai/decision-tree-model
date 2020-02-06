Class {
	#name : #DtmAbstractDecisionTreeModel,
	#superclass : #Object,
	#instVars : [
		'root'
	],
	#category : #DecisionTreeModel
}

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionFor: anObject [
	^ root decisionFor: anObject 
	
]

{ #category : #classification }
DtmAbstractDecisionTreeModel >> decisionsForAll: aDataset [
	^ aDataset asArrayOfRows collect: [ :row | self decisionFor: row ].

]

{ #category : #splitting }
DtmAbstractDecisionTreeModel >> findBestSplitIn: aDataset [ 

	| currentGainMeasure bestSplit bestGainMeasure |
	
	bestGainMeasure := Float negativeInfinity .
	
	aDataset features do: [ :feature | 
		currentGainMeasure := self splitMetricOf: aDataset given: feature.
		
		(currentGainMeasure > bestGainMeasure) ifTrue: [ 
			bestGainMeasure := currentGainMeasure.
			bestSplit := feature. ] ].
	
	^ bestSplit
]

{ #category : #api }
DtmAbstractDecisionTreeModel >> fit: aDataset [
	self subclassResponsibility 
	
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> gainMeasureOf: aDataset given: aFeatureName [
	"By default, all decision trees use Information Gain as a gain measure"
	
	| gainMeasure selectedRowsGivenFeature impurityOfSelected |
	gainMeasure := self impurityMeasureOf: aDataset.
	(aDataset featureAt: aFeatureName) uniqueValues do: [ :each | 
		selectedRowsGivenFeature := aDataset select: [ :rows | (rows at: aFeatureName) = each ].
		impurityOfSelected := self impurityMeasureOf: selectedRowsGivenFeature.
		gainMeasure := gainMeasure - ((selectedRowsGivenFeature size / aDataset size) * impurityOfSelected).
	].
	^ gainMeasure
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> impurityMeasureOf: aDataset [
	self subclassResponsibility 
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root [
	^ root
]

{ #category : #accessing }
DtmAbstractDecisionTreeModel >> root: aDecisionTreeNode [ 
	^ root := aDecisionTreeNode
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> splitMetricOf: aDataset given: aFeatureName [
	"Should specify how to act if recieving a features that is categorical/numerical"
	self subclassResponsibility
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> splitMetricOf: aDataset givenCategorical: aFeatureName [
	"Should specify how to act if recieving a features that is categorical/numerical"
	^ self gainMeasureOf: aDataset given: aFeatureName
]

{ #category : #metrics }
DtmAbstractDecisionTreeModel >> splitMetricOf: aDataset givenNumerical: aFeatureName [
	"If feature is numerical apply thresholds, then treat the new boolean features as categorical variable, finally return metric of best threshold"
	self shouldBeImplemented 
]
