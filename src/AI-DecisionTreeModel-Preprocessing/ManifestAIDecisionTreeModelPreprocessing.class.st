"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAIDecisionTreeModelPreprocessing,
	#superclass : #PackageManifest,
	#category : #'AI-DecisionTreeModel-Preprocessing-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestAIDecisionTreeModelPreprocessing class >> manuallyResolvedDependencies [

	<ignoreForCoverage>
	^ #( #'Collections-Streams' #'Collections-Abstract' #DecisionTreeModel )
]
