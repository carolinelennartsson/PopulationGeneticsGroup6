# Probably load library.
.libPaths("~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/version02/software/Rlib/")
require(optparse)

# Input arguements
option_list <- list(
  make_option("--inputpath", type="character",default="",
              help="path to the directory holding input summary files"),
  make_option("--outputfilename", type="character",default="",
              help="what do you want the output plot to be called?"),
  make_option("--title", type="character",default="",
	      help="a title for the plot")
  )

# Parse the arguements (You don't need to change this)
parser <- OptionParser(usage="%prog [options]", option_list=option_list)

# Read everything (You don't need to change this)
args <- parse_args(parser, positional_arguments = 0)
opt <- args$options

# This is an expample of how you call the arguement within the script
inputpath <- opt$inputpath # without '--'
outputfilename <- opt$outputfilename 
title <- opt$title

require(tidyverse)
require(ggplot2)

summaries <- list.files(path = inputpath, pattern = ".summary$")
i<-0
for (summarypath in summaries){
  summarypathcomplete<-paste0(inputpath,summarypath)
  print(summarypathcomplete)
  # read in file
  tmp <- read.csv(summarypathcomplete, sep='\t', header =TRUE)
  if (i==0){
    medians <- data.frame(time=tmp[,6],median=tmp[,7],label=i)
  }
  else {
    newmedian <- data.frame(time=tmp[,6],median=tmp[,7],label=i)
    medians <- bind_rows(medians,newmedian)
  }
 i<-i+1
}

ggplot()+geom_step(data=medians,aes(x=time,y=median,col='red',alpha=.5,group=as.factor(label)))+
        scale_x_continuous(trans = 'log10') +
        scale_y_continuous(trans = 'log10') +
        theme_bw() +
        theme(text = element_text(size=16))+
        theme(legend.position = "none")+
        xlab("Years BP") + ylab("Ne") + labs(title=title)+
	annotation_logticks()  

# save plot
output <- paste(outputfilename,".stairway.pdf",sep = '')
ggsave(output, width = 10, height = 4)

