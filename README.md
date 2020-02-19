# DecisionTreeModel
[![Build Status](https://travis-ci.org/pharo-ai/DecisionTreeModel.svg?branch=master)](https://travis-ci.org/pharo-ai/DecisionTreeModel)
[![Build status](https://ci.appveyor.com/api/projects/status/lei4kwl665hmki65?svg=true)](https://ci.appveyor.com/project/evd995/decisiontreemodel)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/DecisionTreeModel/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/DecisionTreeModel?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/DecisionTreeModel/master/LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-9.0-%23aac9ff.svg)](https://pharo.org/download)

Model for Decision Trees Learning in Pharo





## Installation

To install the DecisionTreeModel, go to the Playground (Ctrl+OW) in your Pharo image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'DecisionTreeModel';
  repository: 'github://PharoAI/DecisionTreeModel/src';
  load.
```


## How to use it

### DecisionTree

A simple example of how to create a DecisionTree (not a decision tree model)

```Smalltalk
| waterDecisionTree |
waterDecisionTree := DtmBinaryDecisionTree withCondition: [ :value | value < 0  ].
waterDecisionTree trueBranch: (DtmDecision withLabel: 'ice').
waterDecisionTree falseBranch: (DtmDecision withLabel: 'liquid').		
```

### DtmDataset

A DtmDataset can be initialized from a DataFrame

```Smalltalk
iris := DtmDataset fromDataFrame: Datasets loadIris.
```

Or from an array of objects

```Smalltalk
arrayOfPoints := {Point x: 10 y: 12 . Point x: 5 y: 7} asArray.
newDataset := DtmDataset fromArray: arrayOfPoints withColumns: #(degrees min max).
``` 

Since DtmDataset is used for supervised learning, one can set the features and target that one wants to use. 


```Smalltalk
iris := DtmDataset fromDataFrame: Datasets loadIris.

"Setting features and target in the dataset"
iris target: #species.
iris features: #('sepal length (cm)' 'petal width (cm)').
```

In the case of the initialization from an array this can be done directly with

```Smalltalk
arrayOfPoints := {Point x: 10 y: 12 . Point x: 5 y: 7} asArray.
newDataset := DtmDataset 
                  fromArray: arrayOfPoints 
                  withFeatures: #(degrees min) 
                  withTarget: #max.
```

If one does not specify the features, by default all columns different from the target will be considered as features.

### DecisionTreeModel - ID3

The ID3 algorithm treats all columns as categorical. At each split the tree creates a branch for each posible value the variable can take. If one wishes to use a numerical column it is suggested that it is discretized beforehand. If not, each numerical value will be treated as a category. 

Example on Iris Dataset
```Smalltalk
iris := DtmDataset fromDataFrame: Datasets loadIris.
iris target: #species.

"Training - Preprocessing"
discretizer := DtmDiscretizer new.
discretizer fitTransform: iris.

"Training - Model"
aTreeModel := DtmID3DecisionTreeModel new.
aTreeModel fit: iris. 

"Predicting"
testDataset := DtmDataset 
                   withRows: #(#(8.0 3.8 1.2 0.6) 
                               #(4.5 2.6 3.0 0.7))
                   withFeatures: (iris features copyWithout: #species) .
discretizer transform: testDataset.
aTreeModel decisionsForAll: testDataset. 
"an Array(DtmDecision(setosa) DtmDecision(versicolor))"
```

A decision tree can also explain why it got to a conclusion
```Smalltalk
(aTreeModel decisionsForAll: testDataset) anyOne why. 
"an OrderedCollection(
  DtmMultiwaySplitter(petal width (cm))->DtmInterval( [0.58, 1.06) ) 
  DtmMultiwaySplitter(sepal width (cm))->DtmInterval( [3.44, 3.92) ))"
```
This means that the first split was made over `petal width (cm)`, on which the example belonged to the interval [0.58, 1.06).

Then, another split was made over `sepal width (cm)`, on which the example belonged to the interval [3.44, 3.92).

### DecisionTreeModel - C4.5

The algorithm C4.5 is an extension of ID3. It makes a few improvements like being able to hande both numerical and categorical variables. For numerical variables a threshold is applied and the data is split over the examples that satisfy the threshold and the ones that do not.

With C4.5 we no longer have the need to discretize numerical values.
```Smalltalk
iris := DtmDataset fromDataFrame: Datasets loadIris.
iris target: #species.

"Training - Model"
aTreeModel := DtmC45DecisionTreeModel new.
aTreeModel fit: iris. 

"Predicting"
testDataset := DtmDataset 
                   withRows: #(#(8.0 3.8 1.2 0.6) 
                               #(4.5 2.6 3.0 0.7))
                   withFeatures: (iris features copyWithout: #species) .
aTreeModel decisionsForAll: testDataset. 
 "an Array(DtmDecision(setosa) DtmDecision(versicolor))"
```

This decision tree can also explain why it got to a conclusion

```Smalltalk
(aTreeModel decisionsForAll: testDataset) anyOne why. 
"an OrderedCollection(DtmThresholdSplitter(petal width (cm) <= 0.6)->true)"
```

This means that the first split was made on `petal width (cm)`, with a threshold of 0.6. This example was over the threshold, which lead to the decision.

We can also handle a dataset that has both numerical and categorical variables

```Smalltalk
"Build dataset"
tennisDataFrame := DataFrame withRows: #(
    (sunny 85 85 weak false)
    (sunny 80 90 strong false)
    (cloudy 83 78 weak true)
    (rainy 70 96 weak true)
    (rainy 68 80 weak true)
    (rainy 65 70 strong false)
    (cloudy 64 65 strong true)
    (sunny 72 95 weak false)
    (sunny 69 70 weak true)
    (rainy 75 80 weak true)
    (sunny 75 70 strong true)
    (cloudy 72 90 strong true)
    (rainy 71 80 strong false)).
    
tennisDataFrame columnNames: #(outlook temperature humidity wind playTennis).
tennisDataset := DtmDataset fromDataFrame: tennisDataFrame.
tennisDataset target: #playTennis.

"Training - Model"
aTreeModel := DtmC45DecisionTreeModel new.
aTreeModel fit: tennisDataset. 

"Predicting"
testDataset := DtmDataset 
                   withRows: #(#(cloudy 71 70 weak)
                               #(rainy  65 94 strong))
                   withFeatures: #(outlook temperature humidity wind) .
aTreeModel decisionsForAll: testDataset. "an Array(DtmDecision(true) DtmDecision(false))"
```

We can again see why a decision was made, where we see that several splits can be done on a numerical variable (by using diferent thresholds).

```Smalltalk
(aTreeModel decisionsForAll: testDataset) anyOne why.
 "an OrderedCollection(
   DtmThresholdSplitter(temperature <= 83)->true 
   DtmThresholdSplitter(temperature <= 80)->true 
   DtmThresholdSplitter(temperature <= 75)->true 
   DtmThresholdSplitter(temperature <= 72)->true 
   DtmThresholdSplitter(temperature <= 64)->false 
   DtmThresholdSplitter(temperature <= 65)->false 
   DtmThresholdSplitter(temperature <= 70)->false 
   DtmMultiwaySplitter(outlook)->#cloudy)"
```

### DecisionTreeModel - CART

Another algorithm for building decision trees is CART. It can also handle numerical and categorical variables but only does binary splits on the data. For numerical variables it does a split over a threshold, and for categorical it performs a test in the form: is `a value` in `a subset of values`?. Since checking all possible subsets of values for a variable would be exponentially hard, we will check for subsets with a single value. This means that we will split over examples that satisfy `aVariable=aValue` and the ones that do not. 

Going back to our tennis example:

```Smalltalk
"Build dataset"
tennisDataFrame := DataFrame withRows: #(
    (sunny 85 85 weak false)
    (sunny 80 90 strong false)
    (cloudy 83 78 weak true)
    (rainy 70 96 weak true)
    (rainy 68 80 weak true)
    (rainy 65 70 strong false)
    (cloudy 64 65 strong true)
    (sunny 72 95 weak false)
    (sunny 69 70 weak true)
    (rainy 75 80 weak true)
    (sunny 75 70 strong true)
    (cloudy 72 90 strong true)
    (rainy 71 80 strong false)).
    
tennisDataFrame columnNames: #(outlook temperature humidity wind playTennis).
tennisDataset := DtmDataset fromDataFrame: tennisDataFrame.
tennisDataset target: #playTennis.

"Training - Model"
aTreeModel := DtmCARTDecisionTreeModel new.
aTreeModel fit: tennisDataset. 

"Predicting"
testDataset := DtmDataset 
                   withRows: #(#(sunny 80 70 strong)
                               #(cloudy  70 94 strong))
                   withFeatures: #(outlook temperature humidity wind) .
aTreeModel decisionsForAll: testDataset. "an Array(DtmDecision(false) DtmDecision(true))"
```

If we see the explanation of a decision we can find both splits over a categorical variable being equal to a value (OneVsAll) or a numerical value being over a threshold. 

```Smalltalk
(aTreeModel decisionsForAll: testDataset) anyOne why.
 "an OrderedCollection(
    DtmOneVsAllSplitter(outlook = cloudy)->false 
    DtmThresholdSplitter(temperature <= 75)->false)"
```
