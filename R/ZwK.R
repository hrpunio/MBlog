require(ggplot2)
library(scales)

number_ticks <- function(n) {function(limits) pretty(limits, n)}

d <- read.csv("ZwK.csv", sep = ';', row.names=NULL,  header=T, na.string="NA");
tdistkm = d$tdist / 1000;
d[,"tdistkm"]  <- tdistkm;



ggplot(d, aes(x = tdistkm)) +
  geom_line(aes(y = alt, colour = 'alt'), size=.3) +
  ylab(label="Altitude [m]") +
  xlab(label="Distance [km]") +
  scale_x_continuous(breaks=number_ticks(50)) +
  scale_y_continuous(breaks=number_ticks(15)) +
  theme(legend.title=element_blank()) +
  ggtitle("Żuławy w koło 2017") +
  theme(legend.position=c(.6, .9)) +
  theme(legend.text=element_text(size=12));

ggsave(file="ZwK.pdf", width=20, height=5)
