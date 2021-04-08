inputfile=$1
outdir=$2
numberNucleotideSite=$3
key=$4
numberofsimularion=$5
parameter=$6

generateInput=~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/version02/script/generateInput.pl
stairway=~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/version02/software/stairway_plot_v2.1.1/stairway_plot_es
cd ~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/version02/script

###
perl $generateInput $inputfile $outdir $numberNucleotideSite $key $parameter

###
for((i=1; i<=$numberofsimularion; i++));
do
echo -e $i
java -cp $stairway Stairbuilder $outdir/$key.$i.blueprint
bash $outdir/$key.$i.blueprint.sh
done








