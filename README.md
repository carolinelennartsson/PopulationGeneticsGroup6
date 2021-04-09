# PopulationGeneticsGroup6
Group project for the course Population Genetics in University of Copenhagen, year 2021.
Group name: Group 6 - "Using simulations to test the signal of population size change in genetic data"
Group members: Mariadaria Kathrine Ianni-Ravn, Roosa Katariina Varjus, Ioannis Louloudis, Qing Liu and Caroline Linnea Elin-Lennartsson

## The **Script files** directory contains:
  - the main pipeline script under the name *Paprika.py*. This python script works as a wrapper script and calls:
    - the *fastsimcoal2* tool, which will simulate the population history and events.
    - an R script called *plot_sfs.R* that generates a Site Frequency Spectra plot from the observation files produced by fastsimcoal2 tool in the previous step.
    - for the creation of the stairway plots, an analysis needs to take place first. This task is accomplished using *staiway.sh*
    - the pipeline will collect the summary files created by *stairway.sh* and create the final stairway plot with *plot_stairway_ggplot.R*
 

As an extra step, once Paprika.py is done running, if the user wishes to they can call an additional script called RMSE.R to estimate the RMSE values from the simulation and create the corresponding plot.

## For the simulations computed for the class assignment, eight different parameter files were created, one for each simulation.
The parameter files can be found inside the **Parameter files** directory. They correspond to the parameter file needed by fastsimcoal2 to conduct a simulation. Here is brief description of the naming scheme and use case for each *.par* file:
  - Files the simulate continuous transfer of individuals from one population to the other:
    - 0_cont_intr_extr_low.par  => Null file with no continuous introgression.
    - 1_cont_intr_real_low.par  => The parameters for the introgression are realistic but on the lower end of the spectrum
    - 2_cont_intr_real_high.par => The parameters for the introgression are realistic but on the higher end of the spectrum 
    - 3_cont_intr_extr_high.par => The parameters describe an unrealistically intense continuous introgression event (borderline panmictic)
  - Files the simulate a single instantaneous (in a single generation) transfer of individuals from one population to the other:
    - 0_intr_extr_low.par   => Null file with no instantaneous introgression.
    - 1_intr_real_low.par   => A small but realistic number of individuals moved from one population to the other.
    - 2_intr_real_high.par  => A large but realistic number of individuals moved from one population to the other.
    - 3_intr_extr_high.par  => An unrealistically large amount of individuals moved from one population to the other.


## Pipeline tutorial.

A description of the input parameters for Paprika.py can be seen using the help option
```
./Paprika --help
```
or 
```
./Paprika -h
```

A simple introduction to running the pipeline is giving the path to a parameter file, corresponding to the event we want to simulate and an integer that will represent the number of iterations we want fastsimcoal2 to run.
```
./Paprika.py -par {parameter_filename}.par -i {integer}
```

## How does the pipeline work (in greater detail)?
![alt text](https://github.com/GiannosLouloudis/PopulationGeneticsGroup6/blob/main/Pipeline%20scheme.png)
Figure 1. Schematic representation of the file creation process of the pipeline.

