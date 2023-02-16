"
Description
--------------------

One line summary. For example, ""I represent a paragraph of text"".

Three sentences about my main responsibilities - what I do, what I know.

State my main collaborators and one line about how I interact with them. 

Public API and Key Messages
--------------------

- #
- #
- #

Examples
--------------------

	
 
Internal Representation and Key Implementation Points.
--------------------

"
Class {
	#name : #BaselineOfAIDecisionTreeModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIDecisionTreeModel
}

{ #category : #baselines }
BaselineOfAIDecisionTreeModel >> baseline: spec [

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
