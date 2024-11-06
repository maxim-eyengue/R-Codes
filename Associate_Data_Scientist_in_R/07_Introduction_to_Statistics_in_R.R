####### Introduction to Statistics in R

##### Summary Statistics
### What is Statistics?
# - Field of Statistics: practice and study of collecting and analysing data.
# - Summary statistic: a fact about or summary of some data
# It can be used to answer tons of questions about the data but not all.

## Types of Statistics:
# - Descriptive Statistics: describe and summarize the data.
# - Inferential Statistics: use a sample of data to make inferences about a larger
# population.


## We will focus on these two types of data:
# - Numeric (Quantitative): numerical values.
# It can be continuous (measured i.e time, speed) or discrete (counted i.e pets)
# - Categorical (Qualitative): values belonging to distinct groups.
# It can be nominal(unordered i.e marriage status) or ordinal (ordered i.e degree
# of agreement). They can be represented with numbers.


## Why does data type matter?
# Plots: scatter plot for numerical data, counts and barplots for categorical ones



### Measures of center
# We will begin discussing summary statistics
# A Histograms take a bunch of data points and seperates it into bins, or ranges
# of values. The height of the bars represent the number of data points that fall
# into that bin. But we can use numerical summary statistics to summarize further.

## Typical or center value of the data:
# - Mean: also called average, is the sum of data points divided by their count
# It is much more sensitive to extreme values and works best for symetrical data.
# - Median: value where 50% of the data is lower than it and 50% of the data is higher.
# It is better to use when the data is skewed, and close to mean for symetrical data.
# Data piled up on the right is called left-skewed data. When it is piled up on the
# left, it is right skewed. The mean is pulled in the direction of the skew so lower
# than median for left skewed data, and higher for right skewed data. Th
# - Mode: most frequent value in the data (often used for categorical variables)


## Mean and median
# Data: food_consumption dataset from 2018 Food Carbon Footprint Index by nu3
# load dplyr
library(dplyr)

# Calculate mean food consumption 
mean(food_consumption$consumption)

# Calculate median food consumption 
median(food_consumption$consumption)

# Calculate the mode of food consumption
food_consumption %>% count(consumption, sort = TRUE)


## Mean vs median
# load ggplot
library(ggplot2)

# Histogram for rice Co2 emission
food_consumption %>%
  # Filter for rice food category
  filter(food_category == "rice") %>%
  # Create histogram of co2_emission
  ggplot(aes(co2_emission)) +
  geom_histogram()

# Histogram for rice Co2 emission
food_consumption %>%
  # Filter for rice food category
  filter(food_category == "rice") %>%
  # Create histogram of co2_emission
  ggplot(aes(co2_emission)) +
  geom_histogram()

# Mean and median for rice Co2 emission
food_consumption %>%
  # Filter for rice food category
  filter(food_category == "rice") %>% 
  # Summarize the mean_co2 and median_co2
  summarise(mean_co2 = mean(co2_emission),
            median_co2 = median(co2_emission))



### Measures of spread
# describes how spread apart or how close together the data points are.
# - Variance: average distance from each data point to the data's mean
# It is the average sum f square distance from the mean. Note that unbased distance
# is gotten with a division by n - 1, where n is the data size.
# - Standard deviation: the square root of the variance. The unit are easier to
# understand as they are not squared compared to the variance.
# - Mean absolute deviation: When SD squares distances penalizing longer distances
# more than shorter ones, the mean absolute deviation, penalizes each distance equally
# Indeed, it is the mean of the absolute values of distances from the mean variable.
# SD is more common than MAD but none is better.
# - Quartiles: split the data into four equal parts. The second quartile is the 
# median. The bottom of the box of a boxplot is the first quartile, the middle line
# inside is the second and the top is the third quartile.
# - Quantiles: also called percentiles, are a generalized version of quartiles, so
# they can split the data into 5 or 10 pieces. By default, the quantile function 
# returns the quartiles of the data, but can be adjusted with the `probs` argument
# which takes in a vector of proportions.
# `seq(0, 1, 0.2)`: vector from 0 to 1 with step of 0.2.
# - Interquartile range (IQR): distance between first and third quartile, also
# height of a boxplot.
# - Outliers: data point substantially different from the others.
# data (< Q1 - 1.5 * IQR) or (> Q1 + 1.5 * IQR) : are outliers.

## Variance and standard deviation
# Variance of co2 emission
var(food_consumption$co2_emission)

# Standard deviation of co2 emission
sd(food_consumption$co2_emission)


## Quartiles, quantiles, and quintiles
# Calculate the quartiles of co2_emission
quantile(food_consumption$co2_emission)

# Calculate the quintiles of co2_emission
quantile(food_consumption$co2_emission,
         probs = c(0, 0.2, 0.4, 0.6, 0.8, 1))

# Calculate the deciles of co2_emission
quantile(food_consumption$co2_emission,
         probs = seq(0, 1, 0.1))


## Finding outliers using IQR
# Compute the 25th percentile and 75th percentile of co2_emission
q1 <- quantile(food_consumption$co2_emission, 0.25)
q3 <- quantile(food_consumption$co2_emission, 0.75)

# Compute the IQR of co2_emission
iqr <- q3 - q1

# Calculate the lower and upper cutoffs for outliers
lower <- q1 - 1.5 * iqr
upper <- q3 + 1.5 * iqr

# Filter emissions_by_country to find outliers
food_consumption %>%
  filter(co2_emission < lower | co2_emission > upper)





##### Random Numbers and Probability
### What are the chances?
# We measure the chance of an event using probabilities, by calculating the
# number of ways an event can occur by the total number of possible outcomes
# 0 (can't happen) <= Probabilities <= 1 (always happen)
# sample_n() takes in a dataframe and the number of rows we want to pull out
# to sample randomly
# set.seed() for reproducibility
# Sampling without replacement means you pick a subset of the data and don't put
# it back in the original dataset before sampling it again. `sample_n(2)`
# Sampling with replacement means the subset picked is used again for next samplings.
# `sample_n(2, replace = TRUE)`
# Two events are independent if the probability of the second event isn't affected
# by the outcome of the first. They are dependents when the outcome of the first
# affect the one of the second.

## Calculating probabilities
# Count the deals for each product
amir_deals %>%
  count(product)

# Calculate probability of picking a deal with each product
amir_deals %>%
  count(product) %>%
  mutate(prob = n / sum(n))


## Sampling deals
# Set random seed to 31
set.seed(31)

# Sample 5 deals without replacement
amir_deals %>%
  sample_n(5)

# Sample 5 deals with replacement
amir_deals %>%
  sample_n(5, replace = TRUE)



### Discrete distributions
# A probability distribution describes the probability of each possible outcome in
# a scenario. The expected value is the mean of the probability distribution.
# Discrete probability distributions describe situations with discrete outcomes
# Discrete variables can be thought of as counted variables.
# When all outcomes have the same probability, this is th discrete uniform distribution
# The Law of Large Numbers is the idea that as the sample size increases, the sample
# mean will approach the theoretical mean.

## Creating a probability distribution
# Create a histogram of group_size
ggplot(restaurant_groups, aes(group_size)) +
  geom_histogram(bins = 5)

# Create probability distribution
size_distribution <- restaurant_groups %>%
  # Count number of each group size
  count(group_size) %>%
  # Calculate probability
  mutate(probability = n / sum(n))

# Calculate expected group size
expected_val <- mean(sum(size_distribution$probability *
                           size_distribution$group_size))

# Calculate probability of picking group of 4 or more
size_distribution %>%
  # Filter for groups of 4 or larger
  filter(group_size >= 4) %>%
  # Calculate prob_4_or_more by taking sum of probabilities
  summarise(prob_4_or_more = sum(probability))



### Continuous distributions
# To model continuous variables. We use lines for the plot of the distribution
# as variables can take any possible values. For the continuous uniform distribution, we
# get an horizontal line, as possible values have the same probability.
# `punif` calculates the probability for continuous distribution. It takes in a value, a
# min and a max for the distribution. By default it gives the probability of having less
# than the given value, but if we want the one for obtaining more, we have to set the
# attribute lower.tail to `FALSE`. The aea beneath any distribution must equal `1`.

## Data back-ups
# Min and max wait times for back-up that happens every 30 min
min <- 0
max <- 30

# Calculate probability of waiting less than 5 mins
prob_less_than_5 <- punif(5, min = 0, max = 30)
prob_less_than_5

# Calculate probability of waiting more than 5 mins
prob_greater_than_5 <- punif(5, min = 0, max = 30, lower.tail = FALSE)
prob_greater_than_5

# Calculate probability of waiting 10-20 mins
prob_between_10_and_20 <- punif(20, min = min, max = max) - punif(10, min = min, max = max)
prob_between_10_and_20


## Simulating wait times
# Set random seed to 334
set.seed(334)

# Generate 1000 wait times between 0 and 30 mins, save in time column
wait_times %>%
  mutate(time = runif(1000, min = 0, max = 30)) %>%
  # Create a histogram of simulated times
  ggplot(aes(time)) +
  geom_histogram(bins = 30)



### The binomial distribution
# Flipping a coin has binary outcomes (with two possible values)
# `rbinom(# of trials, # of coins, # probability of heads/success)` 
# produces a vector of length the number of trials, each value being
# the number of heads in the corresponding trial.
# The binomial distribution describes the probability of the number
# of successes in a sequence of independent trials i.e number of heads
# in a sequence of coin flips.
# It is a discrete distribution as the outcomes are countable.
# B(n, p) with n: number of trials, p: probability of success
# To get the probability of less than or equal to a certain num heads: 
# `dbinom(num heads, num trials n, prob of success p)`
# For a greater num heads, add `lower.tail = FALSE`
# Expected value: n * p
# Note that to apply this distribution, each trial must be independent,
# so the outcome of one has no effect on another one.

## Simulating sales deals
# Set random seed to 10
set.seed(10)

# Simulate a single deal
rbinom(1, 1, 0.3)

# Simulate 1 week of 3 deals
rbinom(1, 3, 0.3)

# Simulate 52 weeks of 3 deals
deals <- rbinom(52, 3, 0.3)

# Calculate mean deals won per week
mean(deals)


## Calculating binomial probabilities
# Probability of closing 3 out of 3 deals
dbinom(3, 3, 0.3)

# Probability of closing <= 1 deal out of 3 deals
pbinom(1, 3, 0.3)

# Probability of closing > 1 deal out of 3 deals
pbinom(1, 3, 0.3, lower.tail = FALSE)


## How many sales will be won?
# Expected number won with 30% win rate
won_30pct <- 3 * 0.3
won_30pct

# Expected number won with 25% win rate
won_25pct <- 3 * 0.25
won_25pct

# Expected number won with 35% win rate
won_35pct <- 3 * 0.35
won_35pct





##### More Distributions and the Central Limit Theorem

### The normal distribution
# A lot of statistical methods rely on it, and it applies to more real life
# situations than the distributions covered so far.
# It has a bell curve shape.
# It's symmetrical, so the left side is a mirror image of the right
# The area beneath the curve is 1 as for any continuous distribution
# The probability never hits 0, even if it looks like this at the tails.
# Only 0.006% of its area is contained beyond the edges of this graph
# The normal distribution is dscribed by its mean and its standard deviation.
# The standard normal distribution has a mean of 0 and standard deviation of 1
# The 68-95-99.7 rule:
# 68% of the area is within 1 sd of the mean
# 95% of the area falls within 2 sd of the mean
# 99.7% falls within 3 sd of the mean
# If a distribution of data is similar or close to a normal distribution
# we can use the corresponding normal distribution to approximate and get
# information from this data. To get the probability:
# `pnorm(value, mean, sd)` for less and adding `lower.tail = FALSE` for more
# To get the value: `qnorm(proba/perecntage, mean, sd)`
# rnorm(sample_size, mean, sd)

## Distribution of Amir's sales
# Histogram of amount with 10 bins
ggplot(amir_deals, aes(amount)) + geom_histogram(bins = 10)


## Probabilities from the normal distribution
# Probability of deal < 7500
pnorm(7500, mean = 5000, sd = 2000)

# Probability of deal > 1000
pnorm(1000, mean = 5000, sd = 2000, lower.tail = FALSE)

# Probability of deal between 3000 and 7000
pnorm(7000, mean = 5000, sd = 2000) - pnorm(3000, mean = 5000, sd = 2000)

# Calculate amount that 75% of deals will be more than
qnorm(0.75, mean = 5000, sd = 2000, lower.tail = FALSE)


## Simulating sales under new market conditions
# Calculate new average amount
new_mean <- 5000 * 1.2

# Calculate new standard deviation
new_sd <- 2000 * 1.3

# Simulate 36 sales
new_sales <- new_sales %>% 
  mutate(amount = rnorm(36, mean = new_mean, sd = new_sd))

# Create histogram with 10 bins
ggplot(new_sales, aes(amount)) + geom_histogram(bins = 10)



### The central limit theorem
# `sample()` samples from a vector when `sample_n()` samples from a data frame
# `replicate()` can be used to replicates vector elements
# A sampling distribution is a distribution of a summary statistic (mean, sd, ...)
# CLT: the sampling distribution of a statistic becomes closer to the normal
# distribution as the number of trials increases.
# It only applies when samples are taken randomly and are independent.
# CLT applies to statistics such as mean, sd, proportions.
# We can take a statistic from sampling distributions to get an estimate of the
# one of the original distribution.
# It is useful to work and sample to estimate huge population parameters.

## The CLT in action
# Create a histogram of num_users
ggplot(amir_deals, aes(num_users)) + geom_histogram(bins = 10)

# Set seed to 104
set.seed(104)

# Sample 20 num_users from amir_deals and take mean
sample(amir_deals$num_users, size = 20, replace = TRUE) %>%
  mean()

# Repeat the above 100 times
sample_means <- replicate(100, sample(amir_deals$num_users, size = 20, replace = TRUE) %>% mean())

# Create data frame for plotting
samples <- data.frame(mean = sample_means)

# Histogram of sample means
ggplot(samples, aes(mean)) +
  geom_histogram(bins = 10)


## The mean of means
# Set seed to 321
set.seed(321)

# Take 30 samples of 20 values of num_users, take mean of each sample
sample_means <- replicate(30, sample(all_deals$num_users, 20) %>% mean())

# Calculate mean of sample_means
mean(sample_means)

# Calculate mean of num_users in amir_deals
mean(amir_deals$num_users)



### The Poisson distribution
# A Poisson process is a process where events appear to happen at a certain rate
# but completely on random i.e number of clients arriving in a bakery each hour
# The Poisson distribution describes the probability of some # of events occurring
# over a fixed period of time.
# The Poisson distribution is described by a value called Lambda
# lambda: average number of events per time period + expected value of the distribution
# The Poisson distribution is a discrete distribution since we are counting events.
# Lambda changes the shape of the distribution but the peak of a Poisson distribution
# is always at its Lambda vlue
# `dpois(value, lambda)` give the probability to get value events for a Poisson
# distribution with lambda.
# `ppois(value, lambda)` for the probability of val events or less
# `lower.tail = FALSE` can also be used here.
# `rpois(val, lambda)` samples val data points from the Poisson distribution of
# parameter lambda

## Tracking lead responses
# Probability of 5 responses
dpois(5, lambda = 4)

# Probability of 5 responses from coworker
dpois(5, lambda = 5.5)

# Probability of 2 or fewer responses
ppois(2, lambda = 4)

# Probability of > 10 responses
ppois(10, lambda = 4, lower.tail = FALSE)



### More probability distributions

## Exponential distribution
# represents the probability of a certain time passing between Poisson events.
# i.e probability of fewer than 10 minutes between restaurant arrivals
# uses the same lambda value, which represents the rate, that the Poisson distribution does
# lambda and rate means the same value in this context.
# Unlike Poisson, the Exponential distribution is continuous as it represents time.
# `pexp(val, rate = lambda)` probability of waiting val for a new event 
# lower.tail = FALSE can be used here too.
# Recall: Lambda is the expected value of the Poisson distribution, which measures
# frequency in terms of rate or number of events.
# The exponential distribution measures frequency in terms of time between events.
# Its expected values is 1/lambda


## (Student's) t-distribution
# Its shape is similar to the one of the normal distribution but its tails are thicker
# Thus in a t-distribution observations are more likely to fall further from the mean
# Its parameter is the degree of freedom (df) affecting the thickness of the tails:
# Lower df = thicker tails, higher standard deviation
# Higher df = closer to normal distribution


## Log-normal distribution
# Variables following a log-normal distribution have a logarithm that is normally
# distributed. This results in distribution that are skewed, unlike the normal 
# distribution. A lot fo real world examples folow this distribution i.e length of
# chess games, blood pressure in adults, and the number of hospitalizations in
# the 2023 SARS outbreak 


## Modeling time between leads
# Probability response takes < 1 hour
pexp(1, rate = 1/2.5)

# Probability response takes > 4 hours
pexp(4, rate = 1/2.5, lower.tail = FALSE)

# Probability response takes 3-4 hours
pexp(4, rate = 1/2.5) - pexp(3, rate = 1/2.5)





##### Correlation and Experimental Design

### Correlation
# Scatter plots can be used to visualize relationships between numerical variables
# Response or Dependent variable: on the y-axis
# Explanatory or Independent variable: on the x-axis
# Correlation coefficient can  also be used to quantify the linear relationship
# between two variables. It's a number between -1 and 1 with a magnitude corresponding
# to the strength of the relationship, and the sign (+ or -), to its direction
# correlation coefficient of 0.99: almost perfect, 0.75: strong, 0.56: moderate,
# 0.21 weak, 0.04 / close to 0: no relationship, with a scatter plot looking random,
# which means knowing x does not tell anything about the value of y.
# A positive coefficient indicates that x and y increase together and a negative one,
# that if x increases, y decreases
# ggplot(df, aes(x, y)) + geom_point(): for scatter plot
# + geom_smooth(method = "lm", se = FALSE): to add a linear trendline to the scatterplot
# `se = FALSE` to remove error margins around the line, `lm`: linear trendline
# `cor(df$x, df$y)` to compute the correlation between two variables
# If there are missing values, we need to ignore them with `use = "pairwise.complete.obs"`
# Pearson product-moment correlation (r): most common measure of correlation
# There are variations: Kendall's tau and Spearman's rho.

## Relationships between variables
# `world_happiness` data from: https://worldhappiness.report/ed/2019/
# Create a scatterplot of happiness_score vs. life_exp with a linear trendline
ggplot(world_happiness, aes(life_exp, happiness_score)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)

# Correlation between life_exp and happiness_score
cor(world_happiness$life_exp, world_happiness$happiness_score)



### Correlation caveats
## Correlation doesn't capture non-linear relationships (quadratic, etc.)
# Make sure to always visualize the data
# When data is highly skewed, we can create a new variable by applying a log transformation (log(x))
# The relationship will then look much ore linear than the one with the skewed data
# There are other transformations that can be used to make a relationship more linear:
# Square root transformation (sqrt(x))
# Reciprocal transformation (1/x)
# The choice depends on the data and how skewed it is.
# It can be applied in different combinations to x and y, e.g:
# log(x) and log(y) // sqrt(x) and 1/y
# Why transformations?
# Certain statistical methods rely on variables having a linear relationship
# Correlation coefficient, Linear regression,

## Correlation does not imply causation
# x is correlated with y does not mean x causes y
# A phenomenon called confounding can lead to spurious correlations
# Coffee drinking and lung cancer can be highly correlated without any causality relation
# A third variable like smoking (confounder) generally associated with coffee drinking
# might be the real reason why coffee appears causal to cancer when it is also just associated with it
# The relation between coffee and cancer is a spurious correlation
# Holidays, special deals (confounder), and retail sales are another example.


## What can't correlation measure?
# Scatterplot of gdp_per_cap and life_exp
ggplot(world_happiness, aes(gdp_per_cap, life_exp)) +
  geom_point()

# Correlation between gdp_per_cap and life_exp
cor(world_happiness$gdp_per_cap, world_happiness$life_exp)


## Transforming variables
# Scatterplot of happiness_score vs. gdp_per_cap
ggplot(world_happiness, aes(gdp_per_cap, happiness_score)) + geom_point()

# Calculate correlation
cor(world_happiness$happiness_score, world_happiness$gdp_per_cap)

# Create log_gdp_per_cap column
world_happiness <- world_happiness %>%
  mutate(log_gdp_per_cap = log(gdp_per_cap))

# Scatterplot of happiness_score vs. log_gdp_per_cap
ggplot(world_happiness, aes(log_gdp_per_cap, happiness_score)) +
  geom_point()

# Calculate correlation
cor(world_happiness$log_gdp_per_cap, world_happiness$happiness_score)


## Does sugar improve happiness?
# Scatterplot of grams_sugar_per_day and happiness_score
ggplot(world_happiness, aes(grams_sugar_per_day,
                            happiness_score)) + geom_point()

# Correlation between grams_sugar_per_day and happiness_score
cor(world_happiness$grams_sugar_per_day,
    world_happiness$happiness_score)



### Design of Experiments
# Data is often created as result of a study and needs to be analysed and
# interpreted differently depending on how the study was designed and the data generated
# Experiments aims to answer a question in the form:
# what is the effect of the treatment on the response?
# treatment: explanatory variable and response: dependent variable

## Controlled experiments:
# Participants are randomly assigned to treatment or control (no treatment) group
# Groups should be comparable so that causation can be inferred. if not, it could
# lead to confounding (bias)
# The gold standard of experiments helps eliminating bias:
# - Randomized controlled trial: participants are randomly assigned to treatments/control
# Choosing randomly helps ensure that groups are comparable
# - Placebo: resembles the treatment, but has no effect, for participants not to know if
# they are in the treatment or control group. It ensures the effect of the treatment
# is due to the treatment itself not the idea of getting it.
# - Double-blind trial: the person administrating the treatment doesn't know if it is
# a real treatment or a placebo. It prevents bias in responses and / or analysis of results
# less bias = more causation


## Observational studies:
# Participants are not assigned randomly to groups, useful for research
# not conducive to controlled experiments, i.e smoking. Causation hardly inferred.
# Establish association, not causation. Note that there might be confounders.


##  Longitudinal vs cross-sectional studies
# Longitudinal: same participants followed over a period of time to examine the
# effect of treatment on response. More expensive and time consuming
# Cross-sectional: data collected from a single snapshot in time, cheaper, faster
# and more convenient.