.libPaths("~/groupdirs/SCIENCE-BIO-popgen_course-project/Group6_Simulations1/software/Rlib")
library(optparse)

# Input arguements
option_list <- list(
  make_option("--path", type="character", help="path to .obs file"),
  make_option("--id", type="character",
    help="Id for output figures. Will return sfs_id.png"))

# Parse the arguements (You don't need to change this)
parser <- OptionParser(usage="%prog [options]", option_list=option_list)

# Read everything (You don't need to change this)
args <- parse_args(parser, positional_arguments = 0)
opt <- args$options

# This is an expample of how you call the arguement within the script
path <- as.character(strsplit(opt$path, ",")[[1]])
id <- strsplit(opt$id, ",")[[1]]
#___________________________________________________________________

obs <- read.table(path, skip = 2)

n <- sum(obs)
var_sites <- ncol(obs) - 1
norm <- sapply(obs, function(x){
  x / n
})
norm <- as.data.frame(norm)
norm_means <- colMeans(norm[, c(2:var_sites)]) # start from 2 since the first has a lot bigger percentage

# Determine the standard deviations within sites
sds <- c()
for (i in var_sites) {
  sds <- c(sds, sd(norm[, i]))
}

# Lower and upper boundaries for error bars
lower <- norm_means - sds / 2
upper <- norm_means + sds / 2

comb <- data.frame(norm_means, lower, upper)
rownames(comb) <- c(2:var_sites)
comb <- tibble::rownames_to_column(comb, var = "rownames")
comb$rownames <- as.numeric(comb$rownames)
  
# Plot
png(paste0("sfs_", id, ".png"))
ggplot2::ggplot(comb, ggplot2::aes(x = rownames, y = norm_means)) + 
  ggplot2::geom_bar(stat = "identity") + 
  ggplot2::geom_errorbar(ggplot2::aes(ymin = lower, ymax = upper), width = .3) +
  ggplot2::theme_classic() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle=90, hjust = 1, vjust = 0.5)) + 
  ggplot2::scale_x_discrete(limits = seq(0, ncol(norm), 5)) + 
  ggplot2::xlab("") + 
  ggplot2::ylab("Average proportion of sites")

