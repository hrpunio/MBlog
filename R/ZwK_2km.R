require(ggplot2)
library(scales)

number_ticks <- function(n) {function(limits) pretty(limits, n)}

d <- read.csv("zulawy-wkolo_2km.csv", sep = ';', row.names=NULL,  header=T, na.string="NA");
tdistkm = d$tdist / 1000;
d[,"tdistkm"]  <- tdistkm;



ggplot(d, aes(x = tdistkm)) +
  geom_line(aes(y = slope, colour = 'slope'), size=.3) +
  ylab(label="Slope [%]") +
  xlab(label="Distance [km]") +
  scale_x_continuous(breaks=number_ticks(50)) +
  scale_y_continuous(breaks=number_ticks(15)) +
  geom_abline(intercept = 0, slope = 0, size = 1.25, color='blue') +
  theme(legend.title=element_blank()) +
  ggtitle("Żuławy w koło 2017 (2 km averages)") +
  theme(legend.position=c(.6, .9)) +
  theme(legend.text=element_text(size=12));

ggsave(file="ZwK_2km_slope.pdf", width=20, height=5)
