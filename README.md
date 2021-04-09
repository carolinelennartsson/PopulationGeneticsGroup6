# PopulationGeneticsGroup6
Group project for the course Population Genetics in University of Copenhagen, year 2021.
Group name: Group 6 - "Using simulations to test the signal of population size change in genetic data"
Group members: Mariadaria Kathrine Ianni-Ravn, Roosa Katariina Varjus, Ioannis Louloudis, Qing Liu and Caroline Linnea Elin-Lennartsson

#The **Script files** directory contains:
  - the main pipeline script under the name *Paprika.py*. This python script works as a wrapper script and calls:
    - the *fastsimcoal2* tool, which will simulate the population history and events.
    - an R script called *plot_sfs.R* that generates a Site Frequency Spectra plot from the observation files produced by fastsimcoal2 tool in the previous step.
    - for the creation of the stairway plots, an analysis needs to take place first. This task is accomplished using *staiway.sh*
    - the pipeline will collect the summary files created by *stairway.sh* and create the final stairway plot with *plot_stairway_ggplot.R*
 

As an extra step, once Paprika.py is done running, if the user wishes to they can call an additional script called RMSE.R to estimate the RMSE values from the simulation and create the corresponding plot.
