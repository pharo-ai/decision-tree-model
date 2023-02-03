"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDecisionTreeModel,
	#superclass : #PackageManifest,
	#category : #'DecisionTreeModel-Manifest'
}

{ #category : #'code-critics' }
ManifestDecisionTreeModel class >> ruleReNotOptimizedIfRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#DtmDataset #featureAt:ifAbsent: #false)) #'2023-02-03T15:24:44.672+01:00') )
]