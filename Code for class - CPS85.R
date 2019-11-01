#------------------------------------------------------
# Code for data visualization with ggplot2 class
#------------------------------------------------------
library(mosaicData)
library(ggplot2)

# simple bar plot
ggplot(data=CPS85, aes(x=sector)) + 
  geom_bar()

# stacked bar plot
ggplot(data=CPS85, aes(x=sector, fill=sex)) + 
  geom_bar()

# grouped bar plot
ggplot(data=CPS85, aes(x=sector, fill=sex)) + 
  geom_bar(position="dodge")

# filled bar plot
ggplot(data=CPS85, aes(x=sector, fill=sex)) + 
  geom_bar(position="fill")


# histogram
ggplot(data=CPS85, aes(x=wage)) + 
  geom_histogram()


# frequency polygon
ggplot(data=CPS85, aes(x=wage)) + 
  geom_freqpoly()

# grouped frequency polygons
ggplot(data=CPS85, aes(x=wage, color=sector)) + 
  geom_freqpoly()

# kernal density plot
ggplot(data=CPS85, aes(x=wage)) + 
  geom_density(fill="red")

# grouped kernal density plot
ggplot(data=CPS85, aes(x=wage, fill=union)) + 
  geom_density(alpha=.3)

# boxplot
ggplot(data=CPS85, aes(x=sector, y=wage)) + 
  geom_boxplot()


# strip plot
ggplot(data=CPS85, aes(x=wage, y=sector)) +
  geom_point()

# jittered strip plot
ggplot(data=CPS85, aes(x=wage, y=sector, color=sector)) + 
  geom_jitter() +
  theme(legend.position="none")


# scatter plot
ggplot(data=CPS85, aes(x=exper, y=wage)) + 
  geom_point()

# drop outlier
CPS85rev <- CPS85[CPS85$wage < 40,]

# scatter plot with fit
ggplot(data=CPS85rev, aes(x=exper, y=wage)) + 
  geom_point() + 
  geom_smooth()

# scatter plot with line of best fit
ggplot(data=CPS85rev, aes(x=exper, y=wage)) + 
  geom_point() + 
  geom_smooth(method="lm")

# grouping
ggplot(data=CPS85rev, aes(x=exper, y=wage, color=sex)) + 
  geom_point()

ggplot(data=CPS85rev, aes(x=exper, y=wage, 
                          color=sex, shape=sex)) + 
  geom_point() + geom_smooth(method="lm")

# facets
ggplot(data=CPS85rev, aes(x=exper, y=wage, color=sex)) + 
  geom_point() + 
  facet_grid(. ~ sex) + geom_smooth(method="lm", se=FALSE)

# line charts
ggplot(economics, aes(date, unemploy)) + geom_line()

ggplot(economics, aes(date, unemploy)) + 
  geom_line(linetype="dashed", color="blue", size=1)

ggplot(data=CPS85rev, aes(x=exper, y=wage)) + 
  geom_point() + geom_smooth(method="lm", se=FALSE) +
  facet_grid(sex ~ sector) 

# scales
ggplot(CPS85, aes(x=exper, y=wage)) + geom_point() +
  scale_x_continuous(breaks=seq(0,55,5), limits=c(0, 55)) +
  scale_y_continuous(breaks=seq(0, 28, 2),limits=c(0,28))


ggplot(CPS85, aes(x=sex)) + geom_bar() +
  scale_x_discrete(limits = c("F", "M"),
                   labels = c("Female", "Male"))

# colors/fills
ggplot(CPS85, aes(x=sex, fill=sex)) + geom_bar() +
  scale_fill_manual(values=c("red", "blue"))

ggplot(CPS85, aes(x=sector, fill=sector)) + geom_bar() +
  scale_fill_brewer()

ggplot(CPS85, aes(x=sector, fill=sector)) + geom_bar() +
  scale_fill_brewer(palette = "Set3")

# annotations
medwage <- median(CPS85rev$wage)
ggplot(data=CPS85rev, aes(x=exper, y=wage, color=sex)) + 
  geom_point(size=2) + scale_color_brewer(palette="Paired") +
  geom_hline(yintercept=medwage, color="black", linetype="dashed") +
  annotate("text", x=5, y=medwage+.5, label="Median Wage", color="black")

ggplot(data=CPS85rev, aes(x=exper, y=wage, color=sex)) + 
  geom_point(size=2) + 
  geom_hline(yintercept=medwage, color="black", linetype="dashed") +
  geom_smooth(method="lm", se=FALSE) +
  scale_x_continuous(breaks=seq(0,55,5), limits=c(0, 55)) +
  scale_y_continuous(breaks=seq(0, 28, 2),limits=c(0,28)) +
  scale_color_manual(values=c("red", "steelblue"),limits = c("F", "M"),
                   labels = c("Female", "Male")) +
  annotate("text", x=52, y=medwage+.5, label="Median Wage", color="black") +
  labs(title="Relationship of Wages by Years of Experience", 
       subtitle="1985 Current Population Survey",
       caption = "source: https://cran.r-project.org/web/packages/mosaicData/",
       x = "Experence (in years)", 
       y="Hourly Wages (US dollars)",
       color = "Gender") +
  theme_bw() +
  theme(legend.position="top")
