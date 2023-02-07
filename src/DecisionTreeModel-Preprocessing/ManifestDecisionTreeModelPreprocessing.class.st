"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestDecisionTreeModelPreprocessing,
	#superclass : #PackageManifest,
	#category : #'DecisionTreeModel-Preprocessing-Manifest'
}

{ #category : #'meta-data - dependency analyser' }
ManifestDecisionTreeModelPreprocessing class >> manuallyResolvedDependencies [
	^ #(#'Collections-Streams' #'Collections-Abstract' #DecisionTreeModel)
]
