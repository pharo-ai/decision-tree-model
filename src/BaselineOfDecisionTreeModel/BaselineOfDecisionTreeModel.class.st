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
				
		"Packages"
		spec 
			package: 'DecisionTreeModel' with: [ spec requires: #('DataFrame') ];
			package: 'DecisionTreeModel-Tests' with: [ spec requires: #('DecisionTreeModel') ]].
]
