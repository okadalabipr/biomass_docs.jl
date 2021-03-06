# BioMASS overview

In this section, we will familiarize ourselves with the structure and functionality of BioMASS.
To do so, we will use a model available in the BioMASS repository.

Let's navigate to the models directory in the BioMASS repository.
Go to:

`biomass -> biomass -> models `

Three models are available in the models directory, each stored in its own directory.
Each of these model directories contains all files necessary to define a model in BioMASS.

We will use the model of a MAPK cascade in this overview. The model of the MAPK cascade is based on a publication by Kholodenko, BN, _Eur. J. Biochem._, (2000). It describes the MAPK activation cascade with positive feedback. Details can be found in the original reference (DOI: 10.1046/j.1432-1327.2000.01197.x).

Open the mapk_cascade directory:
`models -> mapk_cascade`
<br>
In the following, we will briefly introduce the relevant model files and their functions. In particular, we will focus on the following three files:

- `set_model.py` for defining the model itself
- `observable.py` for defining observables and adding experimental data
- `set_search_param.py` for defining the parameters to optimize

## _set_model.py_: Defining the model

The file 'set_model.py' contains the model equations implemented as ODEs, as well as the definitions for all parameters and initial values. Please open the file 'set_model.py'. We will explain the three main functions in this file.

- _diffeq_

  Have a look at the _diffeq_ function starting in line 10. Here, the rate laws and the ODEs are defined. As you can see, this model contains in total eight ODEs defined from lines 25 to 32.

- _param_values_

  Next, look at the _param_values_ function starting from line 37. Here, all parameters that are used in the ODEs are defined.

- _initial_values_

  Each ODE requires some initial value. These are defined in the function _initial_values_ starting from line 66.

Note that you can choose which of the parameters and initial values will be optimized by editing the file 'set_search_param.py'.

## _observable.py_: Defining observables, adding experimental data, defining conditions, setting _in silico_ simulation time

Open the file `observable.py`. In this file, you can define which of the species contained in the model you would like to observe, that is, retrieving the dynamics of the simulated model. You can also add experimental data and define the _in silico_ simulation time. Optionally, you can define experimental conditions which you would like to explore _in silico_.

### Observables

As you can see, in this model, two observables are defined in the data structure _observables_ starting from line 8: the double phosphorylated MAPK (_biphosphorylated_MAPK_), and the unphosphorylated MAPK (_unphosphorylated_MAPK_). In this data structure, you can add as many observables as needed, choosing a reasonable name and avoiding spaces.

Starting from line 60, you need to specify which species in your model correspond to the observables. In this model, the two observables are defined by only one model species, each. However, you can add as many model species to your observable as required. For example, if you would like to observe the total amount of a molecule of interest, you can add the corresponding model species.

Note that for each observable defined from line 8, you need to specify the corresponding model species starting from line 58. While the name of the observable in the observables structure can be chosen by the user, the name of the corresponding model species must be used as in the `set_model.py` file. For example, here, the verbalized observable _biphosphorylated_MAPK_ corresponds to the model species _V.MAPK_PP_.

### Experimental data

The function _set_data_ starting from line 172 contains the experimental data which is used by BioMASS for parameter optimization. In this model, we have experimental data points for the two observables which were defined earlier.

### Conditions

It is common that experiments are conducted in different conditions, such as the addition of a stimulant or inhibitor. You can recapulate such conditions with BioMASS. In this model, only a control condition is defined.

### _in silico_ simulation time

Lastly, in the function _get_timepoint_ you can define the _in silico_ time points for your simulation output. In this model, we observe from 0 to 150 with increments of 5 (line 202).
<br>
Note that you can define the time period you want to study and the time resolution according to your own needs. The _in silico_ time does not have to match your experimental data points. For example, you can simulate longer time periods than your available experimental data.

## _set_search_param.py_: Defining parameters to optimize

In this file, you can specify which parameters you want to optimize, and also define the range in which the values will be searched. We will focus on the parts of the file which may be edited by the user.

- _SearchParam_ <br>
  Starting from line 7 is a class which contains the parameters and initial values which will be optimized. You can see that this file only contains information about parameters. The initial values as defined in the `set_model.py` file will be used directly.

- _get_region_ <br>
  In this function, you can define the upper and lower bounds for the parameter search. The lower and upper bounds for parameters are defined in lines 50 and 51, and rage from 0.1 to 10 times the given value by default. Similarly, the lower and upper bounds for the initial values are defined on lines 55 and 57, respectively, and set to 0.5 to 2.0 times the given value by default. The lower and upper bounds defined so far will be applied to all parameters and initial values.
  <br>
  If you would like to specify specific search boundaries for individual parameters and initial values, you may define these in lines 59 and 60. (These two lines are commented out in the model.)

## Parameters and species

There are two more files which are necessary to define a model in BioMASS. These two files are located in the _name2idx_ directory.
Move to the _name2idx_ directory.
Open the file `parameters.py`.
All parameter names used in the `set_model.py` file need to be listed here.

Open the file `species.py`. All species names used in the `set_model.py` file need to be listed here.

Note that the names for parameters and initial values are case sensitive. If you change any parameter or species names in the `set_model.py` file, you need to update this file, too.

## Closing remark

We have introduced the files necessary to edit in order to define a model in BioMASS. In the next section, we will introduce the files required for visualization of the parameter optimization results, and start a parameter optimization for the _mapk_cascade_ model.
