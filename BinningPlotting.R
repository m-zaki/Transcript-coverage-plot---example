library(dplyr)
library(binr)
library(ggplot2)

# --------------------------------------------# 
# Example data on how to calculate mean coverage
# --------------------------------------------# 
# Vector of coverage
g1 <- round(
  c(rnorm(866, mean=100),
    rnorm(11, mean=70),
    rnorm(30, mean=10),
    rnorm(7, mean=45),
    rnorm(30, mean=0, sd=0),
    rnorm(56, mean=5)))


length(g1)

# Eg - want to bin the data into 100 bins
binfunc <- bins(1:length(g1), target.bins = 100, max.breaks = 100)
# Extract result from binfunction
binlength <- as.numeric(binfunc$binct) 
# Create a category of the bin
binlist <- list()
for (i in seq_along(binlength)){
  binlist[[i]] <-  rep(i, each=binlength[i])
}
bincateg <- unlist(binlist)
# Data frame containing the coverage and the bin it belongs to
df_cov <- data.frame(value = g1,
                     bin = bincateg)

# Get the mean of each bin
df_bin <- as.data.frame(group_by(df_cov, bin) %>% 
                          summarise(mean_cov = mean(value)))



ggplot(df_bin, aes(x=bin, y=mean_cov)) +
  geom_line() + 
  ylab("Read count") +
  xlab("5' to 3' coverage")
