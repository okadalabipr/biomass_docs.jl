## Model Construction

```python
from biomass.models import Nakakuki_Cell_2010

Nakakuki_Cell_2010.show_info()
```

```
Nakakuki_Cell_2010 information
------------------------------
36 species
115 parameters, of which 75 to be estimated
```

```python
model = Nakakuki_Cell_2010.create()
```

## Parameter Estimation of ODE Models (_n_ = 1, 2, 3, · · ·)

Parameters are adjusted to minimize the distance between model simulation and experimental data.

```python
from biomass import optimize

optimize(
    model=model, start=1, options={
        "popsize": 3,
        "max_generation": 1000,
        "allowable_error": 0.5,
        "local_search_method": "DE",
    }
)
```

The temporary result will be saved in `out/n/` after each iteration.

Progress list: `out/n/optimization.log`

```
Generation1: Best Fitness = 1.726069e+00
Generation2: Best Fitness = 1.726069e+00
Generation3: Best Fitness = 1.726069e+00
Generation4: Best Fitness = 1.645414e+00
Generation5: Best Fitness = 1.645414e+00
Generation6: Best Fitness = 1.645414e+00
Generation7: Best Fitness = 1.645414e+00
Generation8: Best Fitness = 1.645414e+00
Generation9: Best Fitness = 1.645414e+00
Generation10: Best Fitness = 1.645414e+00
Generation11: Best Fitness = 1.645414e+00
Generation12: Best Fitness = 1.645414e+00
Generation13: Best Fitness = 1.645414e+00
Generation14: Best Fitness = 1.645414e+00
Generation15: Best Fitness = 1.645414e+00
Generation16: Best Fitness = 1.249036e+00
Generation17: Best Fitness = 1.171606e+00
Generation18: Best Fitness = 1.171606e+00
Generation19: Best Fitness = 1.171606e+00
Generation20: Best Fitness = 1.171606e+00
```

- If you want to continue from where you stopped in the last parameter search,

```python
from biomass import optimize_continue

optimize_continue(
    model=model, start=1, options={
        "popsize": 3,
        "max_generation": 1000,
        "allowable_error": 0.5,
        "local_search_method": "DE",
    }
)
```

- If you want to search multiple parameter sets (e.g., from 1 to 10) simultaneously,

```python
from biomass import optimize

optimize(
    model=model, start=1, end=10, options={
        "popsize": 5,
        "max_generation": 2000,
        "allowable_error": 0.5,
        "local_search_method": "mutation",
        "n_children": 50
    }
)
```

- Exporting optimized parameters in CSV format

```python
from biomass.result import OptimizationResults

res = OptimizationResults(model)
res.to_csv()
```

## Visualization of Simulation Results

```python
from biomass import run_simulation

run_simulation(model, viz_type='average', show_all=False, stdev=True)
```

![simulation_average](../assets/simulation_average.png)

Points (blue diamonds, EGF; red squares, HRG) denote experimental data, solid lines denote simulations

## Sensitivity Analysis

The single parameter sensitivity of each reaction is defined by

```math
C^{M}_{i} = d \ln{M} / d \ln{v_{i}}
```

where `v_{i}` is the `i^{th}` reaction rate, `v` is reaction vector `v` = (`v_{1}`, `v_{2}`, ...) and `M` is the signaling metric, e.g., time-integrated response, duration. Sensitivity coefficients were calculated using finite difference approximations with 1% changes in the reaction rates.

```python
from biomass import run_analysis

run_analysis(model, target='reaction', metric='integral', style='barplot')
```

![sensitivity_PcFos](../assets/sensitivity_PcFos.png)

Control coefficients for integrated pc-Fos are shown by bars (blue, EGF; red, HRG). Numbers above bars indicate the reaction indices, and error bars correspond to simulation standard deviation.
