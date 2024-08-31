####### Introduction to Tidyverse
# It is a collection of tools for transforming and visualizing data,
# including ggplot2, readr, forcats, tibble, stringr, tidyr, purr and dplyr

##### Data wrangling
### The gapminder dataset
# It tracks economic and social indicators like life expectancy and the GDP per capita of countries over time.
install.packages("gapminder")

## Loading the gapminder and dplyr packages
# Load the gapminder package
library(gapminder)

# Load the dplyr package
library(dplyr) # provides step by step tools for transforming data (filter, sort, summarize...)

# Look at the gapminder dataset
gapminder



### The filter verb
# to look at a subset of observations
# %>% is called a pipe: "takes what ever is before it and feeds it into the next step"
# not removing rows from data but returning a new dataset

## Filtering for one year
# Filter the gapminder dataset for the year 1957
gapminder %>%
  filter(year == 1957)


## Filtering for one country and one year
# Filter for China in 2002
gapminder %>%
  filter(country == "China", year == 2002)



### The arrange verb
# to sort data and visualize extremes values

## Arranging observations by life expectancy
# Sort in ascending order of lifeExp
gapminder %>%
  arrange(lifeExp)

# Sort in descending order of lifeExp
gapminder %>%
  arrange(desc(lifeExp))


## Filtering and arranging
# Filter for the year 1957, then arrange in descending order of population
gapminder %>%
  filter(year == 1957) %>%
    arrange(desc(pop))



### The mutate verb
# to change or add a variable based on existing ones in the new data frame that is being returned
# GDP Per Capita: Gross Domestic Product of the country divided by the population. For the total GDP, itt should be multiplied by the population size,

## Using mutate to change or create a column
# Use mutate to change lifeExp to be in months
gapminder %>%
  mutate(lifeExp = lifeExp * 12)

# Use mutate to create a new column called lifeExpMonths
gapminder %>%
  mutate(lifeExpMonths = lifeExp * 12)


## Combining filter, mutate, and arrange
# Filter, mutate, and arrange the gapminder dataset
gapminder %>%
  filter(year == 2007) %>%
    mutate(lifeExpMonths = lifeExp * 12) %>%
      arrange(desc(lifeExpMonths))





##### Data visualizaton
### Visualizing with ggplot2
# Install, load and check ggplot
install.packages("ggplot2", dependencies = TRUE)
library(ggplot2)
search()
# ggplot(gapmider, aes(x = gdpPerCap, y = lifeExp)) + geom_point()
# gapminder: data that we are visualizing
# aes: mapping of dataset variables to aesthetics (visual dimensions or axis of a graph that can be used to communicate information) in the graph
# Now there is a need to specify the type of graph: `+ geom_point()`
# +: to add a layer to the graph
# geom : adding a geometric obect to the graph
# point: scatter plot where each observation corresponds to a point

## Variable assignment
# Create gapminder_1952
gapminder_1952 <- gapminder %>%
  filter(year == 1952)


## Comparing population and GDP per capita
# Change to put pop on the x-axis and gdpPercap on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) +
  geom_point()


## Comparing population and life expectancy
# Create a scatter plot with pop on the x-axis and lifeExp on the y-axis
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + geom_point()



### Log scales
# When the distribution of data to plot spans several order of magnitude, withe some very high values while others are low, it is easier to work with a logarithmic scale.
# That is a scale where each fixed distance represents a multiplication of the value.
# For GDP in gapminder, each unit on the x-axis will then represent a change of 10 times the GDP.
# This can be useful to show a linear relation between variables better.4
# formula: + scale_x_log10() / scale_y_log10() for the y-axis

## Putting the x-axis on a log scale
# Change this plot to put the x-axis on a log scale
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) +
  geom_point() + scale_x_log10() # because populations vary a lot among countries


## Putting the x- and y- axes on a log scale
# Scatter plot comparing pop and gdpPercap, with both axes on a log scale
ggplot(gapminder_1952, aes(x = pop, y = gdpPercap)) + geom_point() + scale_x_log10() + scale_y_log10()



### Additional aesthetics
# to give more information in the same plot
# color for categorical variables
# size for numeric variables

## Adding color to a scatter plot
# Scatter plot comparing pop and lifeExp, with color representing continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, 
                           color = continent)) + geom_point() + scale_x_log10()


## Adding size and color to a plot
# Add the size aesthetic to represent a country's gdpPercap
ggplot(gapminder_1952, aes(x = pop, y = lifeExp, color = continent, size = gdpPercap)) +
  geom_point() +
  scale_x_log10()



### Faceting
# dividing a plot into subplots based on a variable
# + facet_wrap(~ var)
# `~` in R means by i.e we are splitting the plot by `var`

## Creating a subgraph for each continent
# Scatter plot comparing pop and lifeExp, faceted by continent
ggplot(gapminder_1952, aes(x = pop, y = lifeExp)) + 
  geom_point() + scale_x_log10() + facet_wrap(~ continent)


## Faceting by year
# Scatter plot comparing gdpPercap and lifeExp, with color representing continent
# and size representing population, faceted by year
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, color = continent, 
                      size = pop)) + geom_point() + scale_x_log10() +
  facet_wrap(~ year)





##### Grouping and summarizing
# Data Transformation with dplyr

### The summarize verb
# turns many rows into one

## Summarizing the median life expectancy
# Summarize to find the median life expectancy
gapminder %>%
  summarize(medianLifeExp = median(lifeExp))


## Summarizing the median life expectancy in 1957
# Filter for 1957 then summarize the median life expectancy
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp))


## Summarizing multiple variables in 1957
# Filter for 1957 then summarize the median life expectancy and the maximum GDP per capita
gapminder %>%
  filter(year == 1957) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))



### The group_by verb
## Summarizing by year
# Find median life expectancy and maximum GDP per capita in each year
gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))


## Summarizing by continent
# Find median life expectancy and maximum GDP per capita in each continent in 1957
gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))


## Summarizing by continent and year
# Find median life expectancy and maximum GDP per capita in each continent/year combination
gapminder %>%
  group_by(year, continent) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))



### Visualizing summarized data
# expand_limits(y = 0): specifies that the y-axis should start at zero

## Visualizing median life expectancy over time
# by_year data
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianLifeExp = median(lifeExp),
            maxGdpPercap = max(gdpPercap))

# Create a scatter plot showing the change in medianLifeExp over time
ggplot(by_year, aes(x = year, y = medianLifeExp)) + 
  geom_point() + expand_limits(y = 0)


## Visualizing median GDP per capita per continent over time
# Summarize medianGdpPercap within each continent within each year: by_year_continent
by_year_continent <- gapminder %>%
  group_by(continent, year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Plot the change in medianGdpPercap in each continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_point() + expand_limits(y = 0)


## Comparing median life expectancy and median GDP per continent in 2007
# Summarize the median GDP and median life expectancy per continent in 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap), medianLifeExp = median(lifeExp))

# Use a scatter plot to compare the median GDP and median life expectancy
ggplot(by_continent_2007, aes(x = medianGdpPercap, y = medianLifeExp,
                              color = continent)) + geom_point()





##### Types of visualizations
### Line plots
# to show change over time, making the upward or downward trend clearer
# + geom_line(): for the line plot

## Visualizing median GDP per capita over time
# Summarize the median gdpPercap by year, then save it as by_year
by_year <- gapminder %>%
  group_by(year) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap over time
ggplot(by_year, aes(x = year, y = medianGdpPercap)) + 
  geom_line() + expand_limits(y = 0)


## Visualizing median GDP per capita by continent over time
# Summarize the median gdpPercap by year & continent, save as by_year_continent
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a line plot showing the change in medianGdpPercap by continent over time
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) + 
  geom_line() + expand_limits(y = 0)



### Bar plots
# to compare statistics for each of seera categories
# + geom_col(): for the bar plot.

## Visualizing median GDP per capita by continent
# Summarize the median gdpPercap by continent in 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Create a bar plot showing medianGdp by continent
ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) + geom_col()


## Visualizing GDP per capita by country in Oceania
# Filter for observations in the Oceania continent in 1952
oceania_1952 = gapminder %>%
  filter(continent == "Oceania", year == 1952)

# Create a bar plot of gdpPercap by country
ggplot(oceania_1952, aes(x = country, y = gdpPercap)) +
  geom_col()



### Histograms
# to describe the distribution of a one-dimensional numeric variable
# geom_histogram(binwidth = 5): for histogram where binwidth determines a size of 5 for each bin on the variable plot.

## Visualizing population
# 1952 Pop by Millions dataset
gapminder_1952 <- gapminder %>%
  filter(year == 1952) %>%
  mutate(pop_by_mil = pop / 1000000)

# Create a histogram of population (pop_by_mil)
ggplot(gapminder_1952, aes(x = pop_by_mil)) + 
  geom_histogram(bins = 50) # with 50 bins


## Visualizing population with x-axis on a log scale
# 1952 gapminder dataset
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x = pop)) + geom_histogram() + scale_x_log10()



### Box plots
# to compare the distribution of a numerical variable among several categories
# The black line in the middle of each box is the median of the distribution
# The top and bottom of each box represent the 75th and 25th percentile of that group, meaning half of the distribution lies within that box.
# The whiskers are the lines going up and down from the box cover additional observations
# The dots when we can see some are outliers
# + geom_boxplot() for box plots.

## Comparing GDP per capita across continents
# 1952 gapminder dataset
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap, fill = continent)) +
  geom_boxplot() + scale_y_log10() # fill to color the interior of each box plot


## Adding a title to your graph
# 1952 gapminder dataset
gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Add a title to this graph: "Comparing GDP per capita across continents"
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() + scale_y_log10() + 
  ggtitle("Comparing GDP per capita across continents")