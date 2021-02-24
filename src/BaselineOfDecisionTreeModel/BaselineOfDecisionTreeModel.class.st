Class {
	#name : #BaselineOfDecisionTreeModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfDecisionTreeModel
}

{ #category : #baselines }
BaselineOfDecisionTreeModel >> baseline: spec [ 
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'DataFrame'
			with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
			
		spec
			baseline: 'AIDatasets'
			with: [ spec repository: 'github://pharo-ai/Datasets' ].
							
		"Packages"
		spec
			package: 'DecisionTree'; 
			package: 'DecisionTree-Tests' with: [ spec requires: #('DecisionTree') ];
			package: 'DecisionTreeModel' with: [ spec requires: #('DecisionTree') ];
			package: 'DecisionTreeModel' with: [ spec requires: #('DataFrame') ];
			package: 'DecisionTreeModel' with: [ spec requires: #('AIDatasets') ];
			package: 'DecisionTreeModel-Preprocessing' with: [ spec requires: #('DecisionTreeModel') ];
			package: 'DecisionTreeModel-Preprocessing-Tests' with: [ spec requires: #('DecisionTreeModel-Preprocessing') ];
			package: 'DecisionTreeModel-Tests' with: [ spec requires: #('DecisionTreeModel') ]].
]
