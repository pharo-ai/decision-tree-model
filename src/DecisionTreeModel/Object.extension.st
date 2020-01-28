Extension { #name : #Object }

{ #category : #'*DecisionTreeModel' }
Object >> allUnarySelectors [
	^ self class allMethods 
		select: [ :each | each argumentNames isEmpty] 
		thenCollect: [ :each | each selector] 
]
