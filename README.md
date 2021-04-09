# PopulationGeneticsGroup6
Group project for the course Population Genetics in University of Copenhagen, year 2021.
Group name: Group 6 - "Using simulations to test the signal of population size change in genetic data"
Group members: Mariadaria Kathrine Ianni-Ravn, Roosa Katariina Varjus, Ioannis Louloudis, Qing Liu and Caroline Linnea Elin-Lennartsson

#The **Script files** directory contains:
  - the main pipeline script under the name Paprika.py. This python script works as a wrapper script and calls:
    - the fastsimcoal2 tool, which will simulate the population history and events.
    - an R script called plot_sfs.R that generates a Site Frequency Spectra plot from the observation files produced by fastsimcoal2 tool in the previous step.
    - for the 
    - the Root Mean Square Error (RMSE) is calculated and visualize in a corresponding plot by RMSE.R
    - finally, the pipeline will collect the summary files created by *stairway.sh* and create the final stairway plot with plot_stairway_ggplot.R
