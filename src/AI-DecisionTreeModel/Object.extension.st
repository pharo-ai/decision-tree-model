Extension { #name : 'Object' }

{ #category : '*AI-DecisionTreeModel' }
Object >> allUnarySelectors [

	"
	[ Point allSelectors select: [ :s | s isUnary ] ] bench.
	16,495 iterations in 5 seconds 3 milliseconds. 3297.022 per second
	[ Point allMethods
		select: [ :each | each argumentNames isEmpty]
		thenCollect: [ :each | each selector] ] bench 
103 iterations in 5 seconds 4 milliseconds. 20.584 per second"
	"in addition this is not good to take all the inherited methods!."
	
	^ self class stonName select: [ :s | s isUnary ] 
]
