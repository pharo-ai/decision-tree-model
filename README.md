# DecisionTreeModel
[![Build Status](https://travis-ci.org/PharoAI/DecisionTreeModel.svg?branch=master)](https://travis-ci.org/PharoAI/DecisionTreeModel)
[![Build status](https://ci.appveyor.com/api/projects/status/lei4kwl665hmki65?svg=true)](https://ci.appveyor.com/project/evd995/decisiontreemodel)
[![Coverage Status](https://coveralls.io/repos/github/PharoAI/DecisionTreeModel/badge.svg?branch=master)](https://coveralls.io/github/PharoAI/DecisionTreeModel?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PharoAI/DecisionTreeModel/master/LICENSE)
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

### DecisionTRee

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
newDataset := DtmDataset fromArray: arrayOfPoints withFeatures: #(degrees min max).
``` 


### DecisionTreeModel

An example of how to create a DecisionTreeModel (with the ID3 algorithm)
```Smalltalk
iris := DtmDataset fromDataFrame: Datasets loadIris.

"Training - Preprocessing"
discretizer := DtmDiscretizer new.
discretizer fitTransform: iris.

"Training - Model"
targetFeature := #class.
aTreeModel := DtmID3DecisionTreeModel new.
aTreeModel fit: iris withTarget: targetFeature. 

"Predicting"
testDataset := DtmDataset 
						withRows: #(#(5.0 3.8 1.2 0.4) 
										#(4.5 3.2 1.0 0.6)) 
						withFeatures: (iris features reject: [:each|each = targetFeature]) .
discretizer transform: testDataset.
aTreeModel decisionsForAll: testDataset  "#('setosa' 'versicolor')"
```
