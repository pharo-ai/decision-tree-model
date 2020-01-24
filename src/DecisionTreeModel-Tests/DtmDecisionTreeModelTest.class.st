Class {
	#name : #DtmDecisionTreeModelTest,
	#superclass : #TestCase,
	#instVars : [
		'tennisTable'
	],
	#category : #'DecisionTreeModel-Tests'
}

{ #category : #running }
DtmDecisionTreeModelTest >> setUp [
	super setUp.
	tennisTable := DataFrame withRows: #(
		(sunny high high weak false)
  		(sunny high high strong false)
		(cloudy high high weak true)
		(rainy medium high weak true)
		(rainy low normal weak true)
		(rainy low normal strong false)
		(cloudy low normal strong true)
		(sunny medium high weak false)
		(sunny low normal weak true)
		(rainy medium normal weak true)
		(sunny medium normal strong true)
		(cloudy medium high strong true)
		(cloudy high normal weak true)
		(rainy medium high strong false)).
		
	tennisTable columnNames: #(overlook temperature humidity wind playTennis)
]
