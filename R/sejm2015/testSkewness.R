library(moments)
library(ggplot2);

k <- read.csv("hojarska.csv", sep = ';',  header=T, na.string="NA");

skewness(k$glosy)


skewness(k$glosy)

nrow(k)

skewness(k$glosy)

sum(k$glosy)

##k

# https://stackoverflow.com/questions/32978615/geom-histogram-what-is-the-default-origin-of-the-first-bin
#  By default, the histogram is centered at 0, and the first bars xlimits are at 0.5*binwidth and -0.5*binwidth
# We can get the breaks out by using:

p <-  ggplot(data = s, aes(x = glosy)) + geom_histogram(binwidth = 4)
p

### + xlim(c(0,156)) + ylim(c(0,1500))
##+ scale_x_continuous(expand = c(0,0), limits = c(0,156))
breaks <- ggplot_build(p)$data
#ggplot_build(p)$data[[1]]

breaks

# https://www.datacamp.com/community/tutorials/make-histogram-ggplot2
# http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html
#

h <- hist(k$glosy, breaks=seq(0,max(k$glosy), by=4) )

h

h <- hist(k$glosy, breaks=seq(0,max(k$glosy), by=4), freq=F)

sum(h$density)
