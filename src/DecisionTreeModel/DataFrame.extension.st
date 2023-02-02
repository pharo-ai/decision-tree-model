Extension { #name : #DataFrame }

{ #category : #'*DecisionTreeModel' }
DataFrame >> asSerieOfRows [
	"Converts DataFrame to the array of rows"

	^ (1 to: self numberOfRows) collect: [ :i | self at: i ]
]
