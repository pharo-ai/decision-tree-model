"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAIDecisionTreeTests,
	#superclass : #PackageManifest,
	#category : #'AI-DecisionTree-Tests-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestAIDecisionTreeTests class >> manuallyResolvedDependencies [

	<ignoreForCoverage>
	^ #( #Kernel #'Collections-Abstract' )
]
