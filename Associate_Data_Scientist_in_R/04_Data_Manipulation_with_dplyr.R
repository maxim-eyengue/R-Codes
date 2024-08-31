####### Data Manipulation with dplyr
# for exploring, transforming and aggregating data
# It is part of the Tidyverse collection
# Install and Load the Tidyverse
install.packages("tidyverse", dependencies = TRUE)
library(tidyverse)
# Explore and draw insights from 2015 United States Census data (`counties`)
# Note that a county is a subregion of one of the 50 regions of the United States

##### Transforming Data with dplyr
### Exploring data with dplyr
# how to explore and draw insights from data
# verbs: filter, arrange, mutate and select

## Understanding data
# Take a look at the counties dataset
glimpse(counties)


## Selecting columns
# Select state, county, pop and poverty
counties %>%
  select(state, county, population, poverty)



### The filter and arrange verbs
# arrange to sort data in function of given variables with desc() for descending order
# filter to extract obserations based on conditions

## Arranging observations
# The variables: private_work, public_work, self_employed describe whether people work for the government, for private companies, or for themselves.
# Create the counties_selected dataset
counties_selected <- counties %>%
  select(state, county, population, private_work, public_work, self_employed)

# Add a verb to sort in descending order of public_work
counties_selected %>%
  arrange(desc(public_work))


## Filtering for conditions
# filter(): verb to get only observations that match a particular condition, or match multiple conditions
# Create dataset
counties_selected <- counties %>%
  select(state, county, population)

# Filter for counties with a population above 1000000
counties_selected %>%
  filter(population > 1000000)

# Filter for counties in California state with a population above 1000000
counties_selected %>%
  filter(state == "California", population > 1000000)


## Filtering and arranging
# Select data
counties_selected <- counties %>%
  select(state, county, population, private_work, public_work, self_employed)

# Filter for Texas and more than 10000 people; sort in descending order of private_work
counties_selected %>%
  # Filter for Texas and more than 10000 people
  filter(state == "Texas", population > 10000) %>%
  # Sort in descending order of private_work
  arrange(desc(private_work))



### The mutate() verb
# to add new variables or change existing ones
# can also be used to select column of interest as specifying `.keep = "none"` help to signify any column not included in the mutate verb shoud be discarded

## Calculating the number of government employees
# Select the state, county, population, and public_work columns
counties_selected <- counties %>%
  select(state, county, population, public_work)

# Add a new column public_workers with the number of people employed in public work
counties_selected %>%
  mutate(public_workers = population * public_work / 100) %>%
  # Sort in descending order of the public_workers column
  arrange(desc(public_workers))


## Calculating the percentage of women in a county
# Select the columns state, county, population, men, and women
counties_selected <- counties %>%
  select(state, county, population, men, women)

# Calculate proportion_women as the fraction of the population made up of women
counties_selected %>%
  mutate(proportion_women =  women / population)


## Mutate, filter, and arrange
# Keep state, county, population and add proportion_men
counties %>%
  mutate(state, county, population, proportion_men = men / population, .keep = "none") %>%
  # Filter for population of at least 10,000
  filter(population > 10000) %>%
  # Arrange proportion of men in descending order 
  arrange(desc(proportion_men))





##### Aggregating Data
# taking many observations and summarize it into one

### The count verb
# to find out the number of observations
# adding variable help to get more information
# `sort = TRUE` can be used to sort the result
# To get the total of a variable (population for example) with respect to another (state), we can use
# count(state, wt = population)

## Counting by region
# counties dataset with columns for region, state, population, and the number of citizens
counties_selected <- counties %>%
  select(county, region, state, population, citizens)

# Use count to find the number of counties in each region
counties_selected %>%
  count(region, sort = TRUE)


## Counting citizens by state
# Find number of counties per state, weighted by citizens, sorted in descending order
counties_selected %>%
  count(state, wt = citizens, sort = TRUE)


## Mutating and counting
# Select dataset
counties_selected <- counties %>%
  select(county, region, state, population, walk)

# Add population_walk containing the total number of people who walk to work 
counties_selected %>%
  mutate(population_walk = population * walk / 100) %>%
  # Count weighted by the new column, sort in descending order
  count(state, wt = population_walk, sort = TRUE)



### The group_by, summarize, and ungroup verbs
# summarize takes many obserations and turns them into one using various functions:
# sum, mean, median, min, max, n
# group_by offers the possiblity to agregate within groups
# Note that when sumarizing after grouping by two variables, the last group (or variable) gets pilled off

## Summarizing
# for collapsing a large dataset into a single observation.
# Create dataset
counties_selected <- counties %>%
  select(county, population, income, unemployment)

# Summarize to find minimum population, maximum unemployment, and average income
counties_selected %>%
  summarize(min_population = min(population),
            max_unemployment = max(unemployment),
            average_income = mean(income))


## Summarizing by state
# Create dataset
counties_selected <- counties %>%
  select(state, county, population, land_area)

# Group the data by state, and summarize to create new columns
counties_selected %>%
  group_by(state) %>%
  summarize(total_area = sum(land_area),
            total_population = sum(population)) %>%
  # Add a density column containing the total population per square mile
  mutate(density = total_population / total_area) %>%
  # Sort by density in descending order
  arrange(desc(density))


## Summarizing by state and region
# Select data
counties_selected <- counties %>%
  select(region, state, county, population)

# Group and summarize to find the total population
counties_selected %>%
  group_by(region, state) %>%
  summarize(total_pop = sum(population)) %>%
  # Calculate the average_pop and median_pop columns 
  summarize(average_pop = mean(total_pop), median_pop = median(total_pop))



### The slice_min and slice_max verbs
# operates on a group table to extract the most extreme observations from each group
# n indicates the number of extreme values requested for a group
# slice_max(population, `n = 3`): for a group by state returns for each state, 3 observations with the top 3 highest population sizes
# Slicin verbs are often used for creating visualizations

## Selecting a county from each region
# Select Data
counties_selected <- counties %>%
  select(region, state, county, metro, population, walk)

# Find the county in each region with the highest percentage of citizens who walk to work
counties_selected %>%
  # Group by region
  group_by(region) %>%
  # Find the county with the highest percentage of people who walk to work
  slice_max(walk, n = 1)


## Finding the lowest-income state in each region
# Select data
counties_selected <- counties %>%
  select(region, state, county, population, income)

# Calculate the average income of counties  within each region and state and find the state with the lowest one
counties_selected %>%
  group_by(region, state) %>%
  # Calculate average income
  summarize(average_income = mean(income)) %>%
  # Find the lowest income state in each region
  slice_min(average_income, n = 1)


## Using summarize, slice_max, and count together
# Select data
counties_selected <- counties %>%
  select(state, metro, population)

# Count of states where people live in metro areas and in non-metro areas
counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) %>%
  # Extract the most populated row for each state
  slice_max(total_pop, n = 1) %>%
  # Count the states with more people in Metro or Nonmetro areas
  ungroup() %>%
  count(metro)





##### Selecting and Transforming Data
### Selecting
# select verb can be used to select variables or a range of columns
# the `contains` function helps to select columns containing a provided string
# `starts_with`: to select only the variables starting with a particular string
# `ends_with`: to find columns ending in a string
# `last_col`: which graps the last column
# `matches`: which select columns that has a specific pattern
# Adding a `-` in front of a column nam helps to remove this variable from the table

## Selecting columns
# Glimpse the counties table
glimpse(counties)

# Find which counties have the highest rates of working in the service industry.
counties %>%
  # Select state, county, population, and industry-related columns
  select(state, county, population, professional : production) %>%
  # Arrange service in descending order 
  arrange(desc(service))


## Select helpers
# Select the state, county, population, and those ending with "work" and Filter for counties that have at least 50% of people engaged in public work
counties %>%
  select(state, county, population, ends_with("work")) %>%
  filter(public_work > 50)



### The rename verb
# to rename existing variables
# It is also possible to rename variables as part of the select verb 
# (requires to select all the other columns we would like to keep)

## Renaming a column after count
# Count the number of counties in each state and Rename the n column to num_counties
counties %>%
  count(state) %>%
  rename(num_counties = n)


## Renaming a column as part of a select
# Select state, county, and poverty as poverty_rate for more clarity
counties %>%
  select(state, county, poverty, poverty_rate = poverty)



### The relocate verb
# to change column positions in the tibble
# `.before (or .after) = column`: relocates before (or after) the variable `column`
# we can also relocate with select() but select keeps only the specified columns

## Using relocate
# Relocate density and population
counties_selected %>%
  # Move the density column to the end
  relocate(density, .after = last_col()) %>%
  # Move the population column to before land_area
  relocate(population, .before = land_area)


## Choosing among the four verbs
# Change the name of the unemployment column
counties %>%
  rename(unemployment_rate = unemployment)

# Keep the state and county columns, and the columns containing poverty
counties %>%
  select(state, county, contains("poverty"))

# Calculate the fraction_women column without dropping the other columns
counties %>%
  mutate(fraction_women = women / population)

# Move the region column to before state
counties %>%
  relocate(region, .before = state)





##### Case Study: The babynames Dataset
### The babynames data
# contains the names of babies born in the United States each year
# the `%in%` can allow to filter for multiple values

## Filtering and arranging for one year
# Find out the most common names in 1990
babynames %>%
  # Filter for the year 1990
  filter(year == 1990) %>%
  # Sort the number column in descending order 
  arrange(desc(number))


## Finding the most popular names each year
# Find the most common name in each year
babynames %>%
  group_by(year) %>%
  slice_max(number)


## Visualizing names with ggplot2
# Filter for the names Steven, Thomas, and Matthew
selected_names <- babynames %>%
  filter(name %in% c("Steven", "Thomas", "Matthew"))

# Plot the names using a different color for each name
ggplot(selected_names, aes(x = year, y = number, color = name)) +
  geom_line()



### Grouped mutates
# It is a combination of group_by and mutate
# It's handy to add ungroup() to make sure the tibble is not grouped anymore 
# This ensure to avoid mistakes in case we use other verbs

## Finding the year each name is most common
# Calculate the fraction of people born each year with the same name
babynames %>%
  group_by(year) %>%
  mutate(year_total = sum(number)) %>%
  ungroup() %>%
  mutate(fraction = number / year_total) %>%
  # Find the year each name is most common
  group_by(name) %>%
  slice_max(fraction, n = 1)


## Adding the total and maximum for each name
# Add columns name_total and name_max for each name
babynames %>%
  group_by(name) %>%
  mutate(name_total = sum(number),
         name_max = max(number)) %>%
  # Ungroup the table 
  ungroup() %>%
  # Add the fraction_max column containing the number by the name maximum 
  mutate(fraction_max = number / name_max)


## Visualizing the normalized change in popularity
# Normalized popularity of each name
names_normalized <- babynames %>%
  group_by(name) %>%
  mutate(name_total = sum(number),
         name_max = max(number)) %>%
  ungroup() %>%
  mutate(fraction_max = number / name_max)

# Filter for the names Steven, Thomas, and Matthew
names_filtered <- names_normalized %>%
  filter(name %in% c("Steven", "Thomas", "Matthew"))

# Visualize the names in names_filtered over time
ggplot(names_filtered, aes(x = year, y = fraction_max, color = name)) + geom_line()



### Window functions
# A window function takes a vector and returns another vector of the same length
# to compare consecutive steps and calculate the changes
# finding for example differences between pairs of consecutive obserations
# We'll be using the lag() function which moves items tothe right
# Note that lags produces`NA` values

## Using ratios to describe the frequency of a name
# Ratio of the frequency of baby names between consecutive years
babynames_fraction %>%
  # Arrange the data in order of name, then year 
  arrange(name, year) %>%
  # Group the data by name
  group_by(name) %>%
  # Add a ratio column that contains the ratio of fraction between each year 
  mutate(ratio = fraction / lag(fraction))


## Biggest jumps in a name
# Subset of data
babynames_ratios_filtered <- babynames_fraction %>%
  arrange(name, year) %>%
  group_by(name) %>%
  mutate(ratio = fraction / lag(fraction)) %>%
  filter(fraction >= 0.00001)

# Look further into the biggest changes in the popularity of a name
babynames_ratios_filtered %>%
  # Extract the largest ratio from each name 
  slice_max(ratio, n = 1) %>%
  # Sort the ratio column in descending order 
  arrange(desc(ratio)) %>%
  # Filter for fractions greater than or equal to 0.001
  filter(fraction >= 0.001)
