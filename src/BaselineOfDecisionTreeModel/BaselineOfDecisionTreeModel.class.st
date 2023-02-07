Class {
	#name : #BaselineOfDecisionTreeModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfDecisionTreeModel
}

{ #category : #baselines }
BaselineOfDecisionTreeModel >> baseline: spec [

	<baseline>
	spec for: #common do: [ "Packages"
		spec
			package: 'AI-DecisionTree';
			package: 'AI-DecisionTree-Tests' with: [ spec requires: #( 'AI-DecisionTree' ) ];
			package: 'AI-DecisionTreeModel' with: [ spec requires: #( 'AI-DecisionTree' ) ];
			package: 'AI-DecisionTreeModel-Preprocessing' with: [ spec requires: #( 'AI-DecisionTreeModel' ) ];
			package: 'AI-DecisionTreeModel-Preprocessing-Tests' with: [ spec requires: #( 'AI-DecisionTreeModel-Preprocessing' ) ];
			package: 'AI-DecisionTreeModel-Tests' with: [ spec requires: #( 'AI-DecisionTreeModel' ) ] ]
]
