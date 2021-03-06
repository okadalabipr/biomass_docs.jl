## BioMASS Installation

The BioMASS library is available on [pypi](https://pypi.python.org/pypi/biomass/).

```bash
$ pip3 install biomass
```

It will require Python>=3.7 to run.

## Quick start

Follow these steps using command line:
If you quickly want to simulate and visualize a model which has already been implemented, open a terminal and navigate to the BioMASS repository.

We will use the "mapk_cascade" model for a quick parameter optimization and visualization of the results.

Start Python:

```bash
$ python3
```

Load the model and the module required for simulation:

```python
from biomass.models import mapk_cascade

from biomass import run_simulation

# Create an executable model
model = mapk_cascade.create()
```

Next, run the simulation:

```python
run_simulation(model, viz_type='original', show_all=False, stdev=True)
```

The simulation uses the visualization type "original", meaning that it applies the parameters already defined in the model.
The simulation results will be saved in an automatically created directory "original" with the following destination:

`biomass->biomass-> models-> mapk_cascade -> figure -> simulation -> original`

Navigate to the `original` directory. Three files should have been created. Open them and check your simulation results! Solid lines correspond to simulated data, circles and triangles correspond to experimental data.

You can also test a parameter optimization. Please not that the following procedure may take up to one day to complete.
Load the optimization module:

```python
from biomass import optimize
```

Start the optimization for one parameter set:

```python
optimize(model, 1)
```

After finishing, one parameter set has been generated. Please check by navigating to the mapk_cascade directory. A new directory called "out" should have been created, containing a folder called "1". This folder contains the optimization results for the optimized parameter set 1.

Let's visualize the optimized parameters.

Type:

```python
from biomass import run_simulation

from biomass.models import mapk_cascade

model = mapk_cascade.create()

run_simulation(model, viz_type='best', show_all=False, stdev=True)
```

Note: Both for parameter optimization and model simulation, your working directory needs to be the 'biomass' folder. In this example, we have only optimized one parameter set, and hence, have to choose the visualization type 'best'. You can change the visualization type to 'average' if you optimize more than one parameter set.
We will explain the model files and functionality in more detail in the next steps.
