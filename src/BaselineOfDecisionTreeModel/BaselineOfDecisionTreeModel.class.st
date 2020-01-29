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
			baseline: 'Datasets'
			with: [ spec repository: 'github://PharoAI/Datasets' ].
							
		"Packages"
		spec
			package: 'DecisionTree'; 
			package: 'DecisionTree-Tests' with: [ spec requires: #('DecisionTree') ];
			package: 'DecisionTreeModel' with: [ spec requires: #('DecisionTree') ];
			package: 'DecisionTreeModel' with: [ spec requires: #('DataFrame') ];
			package: 'DecisionTreeModel' with: [ spec requires: #('Datasets') ];
			package: 'DecisionTreeModel-Tests' with: [ spec requires: #('DecisionTreeModel') ]].
]
