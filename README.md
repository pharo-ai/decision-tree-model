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

A simple example of how to create a DecisionTree (not a decision tree model)

```Smalltalk
| waterDecisionTree |
waterDecisionTree := DtmDecisionTree withCondition: [ :value | value < 0  ].
waterDecisionTree trueBranch: (DtmDecisionTreeLeaf withLabel: 'ice').
waterDecisionTree falseBranch: (DtmDecisionTreeLeaf withLabel: 'liquid').		
```



An example of how to create a DecisionTreeModel (with the ID3 algorithm)
```
iris := DtmDataset fromDataFrame: Datasets loadIris.
discretizer := DtmDiscretizer new.
discretizer fit: iris.
discretizer transform: iris.

aTreeModel := DtmID3DecisionTreeModel new.
aTreeModel fit: iris withTarget: 'class'.
```
