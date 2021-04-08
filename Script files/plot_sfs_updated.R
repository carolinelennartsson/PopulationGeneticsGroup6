plot_sfs_diff <- function(file_int, file_cont, id){
  obs_int <- read.table(file_int, skip = 2) # skip the header and col names
  obs_cont <- read.table(file_cont, skip = 2)
  
  int <- as.matrix(obs_int[, 1:ncol(obs_int)])
  cont <- as.matrix(obs_cont[, 1:ncol(obs_cont)])
  
  int_n <- apply(int, 1, function(x) x / sum(x))
  cont_n <- apply(cont, 1, function(x) x / sum(x))
  
  # THESE ARE THE MEANS THAT ARE PLOTTED AS A BAR PLOT
  int_mean <- colMeans(t(int_n))
  cont_mean <- colMeans(t(cont_n))
  
  sds_int <- c()
  for (i in ncol(int_n)) {
    sds_int <- c(sds_int, sd(int_n[, i]))
  }
  
  sds_cont <- c()
  for (i in ncol(cont_n)) {
    sds_cont <- c(sds_cont, sd(cont_n[, i]))
  }
  # Lower and upper boundaries for error bars
  lower_int <- int_mean - (sds_int / 2)
  upper_int <- int_mean + (sds_int / 2)
  
  lower_cont <- cont_mean - (sds_cont / 2)
  upper_cont <- cont_mean + (sds_cont / 2)
  
  
  comb_int <- data.frame(int_mean, lower_int, upper_int)
  rownames(comb_int) <- c(1:nrow(int_n))
  
  comb_cont <- data.frame(cont_mean, lower_cont, upper_cont)
  rownames(comb_cont) <- c(1:nrow(cont_n))
  
  comb <- cbind(comb_int, comb_cont)
  
  comb_try <- as.data.frame(cbind(cont_mean, int_mean))
  rownames(comb_try) <- c(1:nrow(comb_try))
  comb_try_r <- rownames_to_column(comb_try)
  
  comb_try_long <- 
    comb_try_r %>% 
    pivot_longer(-rowname, names_to = "case", values_to = "means")

  comb_try_long$means <- -log2(comb_try_long$means)

  comb_try_long$rowname <- as.numeric(comb_try_long$rowname)
  
  png(filename = paste0(id, ".png"))
  ggplot2::ggplot(comb_try_long, ggplot2::aes(x=rowname, y=means, fill=case)) +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::theme_classic() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle=90, hjust = 1, vjust = 0.5)) +
    ggplot2::theme(legend.title = ggplot2::element_blank()) +
    scale_fill_manual(values = c("black", "gray"), labels = c("Continuous", "Instantaneous"))  +
    ggplot2::scale_x_discrete(limits = seq(0, 100, 5)) + 
    ggplot2::xlab("Frequency") + 
    title(id) +
    ggplot2::ylab("-log2(proportion)")
}

