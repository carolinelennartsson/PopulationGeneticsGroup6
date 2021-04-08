#!/usr/bin/env python

# Import libraries.
import os
import argparse


# Get input arguments.
parser = argparse.ArgumentParser()

# Create input arguements.
parser.add_argument("-par", "--param_file", help="Input parameter file for fastsimcoal2" )
parser.add_argument("-i", "--iter_num", help="Number of iterations to use for fastsimcoal2")


# Collect arguments.
args = parser.parse_args()

# Run fastsimcoal2.
os.system("fsc26 -i {parameters} -n {iterations} -I -s 0 -d -T".format(parameters=args.param_file, iterations=args.iter_num))
# Delete the seed file.
os.system("rm seed.txt")


# Create SFS plots
obs_file = args.param_file.split('.')[-2].split('/')[-1]
os.system("Rscript plot_sfs.R --path ./{obs}/{obs}_DAFpop0.obs --id {obs}".format(obs=obs_file))
os.system("mv sfs_{obs}.png ../Results/".format(obs=obs_file))

# Create stairway summary.
os.system("bash ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/version02/script/stairway.sh ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/Scripts/{obs}/{obs}_DAFpop0.obs ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/Results 10000000 {obs} {iterations} ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/Parameters/parameter.txt".format(obs=obs_file, iterations=args.iter_num))


# Collect the final summaries over all the runs.
try:
	os.system("mkdir ../Results/{}_summaries".format(obs_file))
except:
	pass

#
for i in range(1, int(args.iter_num)+1):
	os.system("cp ../Results/{o}.{it}/{o}.{it}.final.summary ../Results/{o}_summaries/".format(o=obs_file, it=i))

os.system("Rscript ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/Scripts/plot_stairway_ggplot.R --inputpath ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/Results/{obs_file}_summaries/ --outputfilename ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/Results/{obs_file}_summaries/{obs_file} --title {obs_file}".format(obs_file=obs_file))


