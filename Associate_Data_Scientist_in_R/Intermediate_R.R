####### Intermediate R

##### Conditionals and Control Flow
### Relational Operators: ==, !=, >, <, >=, <=
## Equality
# They can be used on numbers, strings, with vectors to vectors (elt by elt considering positions), 
# and vectors to numbers. R also knows hot to compare other data types such as matrices and lists.
# Comparison of logicals
TRUE == FALSE

# Comparison of numerics
(-6 * 14)  != (17 - 101)

# Comparison of character strings
"useR" == "user"

# Compare a logical with a numeric
TRUE == 1

# Other examples
3 == (2 + 1)
"intermediate" != "r"
TRUE != FALSE
"Rchitect" != "rchitect" # Note that R is case sensitive


## Greater and less than (or equal to)
# some examples
(1 + 2) > 4
"dog" < "Cats"
TRUE <= FALSE

# Comparison of numerics
-6 * 5 + 2 >= -10 + 1

# Comparison of character strings
"raining" <= "raining dogs"

# Comparison of logicals
TRUE > FALSE


## Compare vectors
# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Popular days
linkedin > 15

# Quiet days
linkedin <= 5

# LinkedIn more popular than Facebook
linkedin > facebook


## Compare matrices
# The social data has been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)

# When does views equal 13?
views == 13

# When is views less than or equal to 14?
views <= 14



### Logical Operators: & (&&), | (||), !
# Doubled operators evaluate only the first elts of structures (vectors for example)
## & and |
# Some examples
TRUE & TRUE
FALSE | TRUE
5 <= 5 & 2 < 3
3 < 4 | 7 < 6

# The linkedin and last variable are already defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
last <- tail(linkedin, 1)

# Is last under 5 or above 10?
last < 5 | last > 10

# Is last between 15 (exclusive) and 20 (inclusive)?
last > 15 & last <= 20

# The social data (linkedin, facebook, views) has been created for you

# linkedin exceeds 10 but facebook below 10
linkedin > 10 & facebook < 10

# When were one or both visited at least 12 times?
linkedin >= 12 | facebook >= 12

# When is views between 11 (exclusive) and 14 (inclusive)?
views > 11 & views <= 14


## ! negates a logical value
# Some examples
!TRUE
!(5 > 3)
!!FALSE

# Test
x <- 5
y <- 7
!(!(x < 4) & !!!(y > 12))


## Blend it all together
# li_df is pre-loaded in your workspace

# Select the second column, named day2, from li_df: second
second = li_df$day2

# Build a logical vector, TRUE if value in second is extreme: extremes
extremes = second > 25 | second < 5

# Count the number of TRUEs in extremes
sum(extremes)



### Conditional Statements
## The if statement
# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Examine the if statement for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
}

# Write the if statement for num_views
if (num_views > 15){
  print("You are popular!")
}


## Add an else
# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else {
  print("Unknown medium")
}

# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
} else {
  print("Try to be more visible!")
}


## Customize further: else if
# Variables related to your last day of recordings
medium <- "LinkedIn"
num_views <- 14

# Control structure for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information")
} else if (medium == "Facebook") {
  # Add code to print correct string when condition is TRUE
  print("Showing Facebook information")
} else {
  print("Unknown medium")
}

# Control structure for num_views
if (num_views > 15) {
  print("You're popular!")
} else if (num_views <= 15 & num_views > 10) {
  # Add code to print correct string when condition is TRUE
  print("Your number of views is average")
} else {
  print("Try to be more visible!")
}


## Take the control
# Variables related to your last day of recordings
li <- 15
fb <- 9

# Code the control-flow construct
if (li >= 15 & fb >= 15) {
  sms <- 2 * (li + fb)
} else if (li < 10 & fb < 10) {
  sms <- 0.5 * (li + fb)
} else {
  sms <- li + fb
}

# Print the resulting sms to the console
sms



##### Loops
### While loop
# Always make sure that your while loop would end at some point
# the break statement stops the while loop

## Write a while loop
# Initialize the speed variable
speed <- 64

# Code the while loop
while (speed > 30) {
  print("Slow down!")
  speed <- speed - 7
}

# Print out the speed variable
speed


## Throw in more conditionals
# Initialize the speed variable
speed <- 64

# Extend/adapt the while loop
while (speed > 30) {
  print(paste("Your speed is",speed))
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}


## Stop the while loop: break
# the break statement is a control statement. When R encounters it, the while loop is abandoned completely.
# Initialize the speed variable
speed <- 88

while (speed > 30) {
  print(paste("Your speed is", speed))
  
  # Break the while loop when speed exceeds 80
  if (speed > 80) {
    break
  }
  
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}


## Build a while loop from scratch
# Initialize i as 1 
i <- 1

# Code the while loop
while (i <= 10) {
  print(3 * i)
  if (3 * i %% 8 == 0) {
    break
  }
  i <- i + 1
}



### For Loop
# `break` simply stops the execution of the loop
# `next` skips any remaining statements in the loop and continues the execution of the program
# nchar: function for number of characters

## Loop over a verctor
# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Loop version 1
for (views in linkedin){
  print(views)
}

# Loop version 2
for (i in 1:length(linkedin)){
  print(linkedin[i])
}


## Loop over a list
# The nyc list is already specified
nyc <- list(pop = 8405837, 
            boroughs = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"), 
            capital = FALSE)

# Loop version 1
for (elt in nyc){
  print(elt)
}

# Loop version 2
for (i in 1:length(nyc)){
  print(nyc[[i]])
}


## Loop over a matrix
# The 3*3 matrix ttt, that represents the status of a tic-tac-toe game, contains the values "X", "O" and "NA".
ttt = matrix(c("0", NA, "X", NA, "O", "O", "X", NA, "X"), byrow = TRUE, nrow = 3)

# define the double for loop
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row", i, "and column", j, "the board contains", ttt[i, j]))
  }
}


## Mix it up with control flow
# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Code the for loop with conditionals
for (li in linkedin) {
  if ( li > 10 ) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  print(li)
}


## Next, you break it
# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Adapt/extend the for loop
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  
  # Add if statement with break
  if (li > 16){
    print("This is ridiculous, I'm outta here!")
    break 
  }
  
  # Add if statement with next
  if (li < 5) {
    print("This is too embarrassing!")
    next
  }
  
  print(li)
}


## Build a for loop from scratch
# Pre-defined variables
rquote <- "r's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]]

# Initialize rcount
rcount <- 0

# Finish the for loop
for (char in chars) {
  if (char == "r") {
    rcount <- rcount + 1
  }
  if (char == "u") {
    break
  }
}

# Print out rcount
rcount




##### Functions
# help(sd) and ?sd to have some help 
# na.rm = FALSE: missing values not removed by default

### Introduction to Functions
## Function documentation
# Consult the documentation on the mean() function
help(mean) # ?mean

# Inspect the arguments of the mean() function
args(mean)


## Use a function
# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Calculate average number of views
avg_li <- mean(linkedin)
avg_fb <- mean(facebook)

# Inspect avg_li and avg_fb
avg_li
avg_fb

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Calculate the mean of the sum
avg_sum = mean(linkedin + facebook)

# Calculate the trimmed mean of the sum
avg_sum_trimmed = mean(linkedin + facebook, trim = 0.2)

# Inspect both new variables
avg_sum
avg_sum_trimmed

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, NA, 17, 14)
facebook <- c(17, NA, 5, 16, 8, 13, 14)

# Basic average of linkedin
mean(linkedin)

# Advanced average of linkedin
mean(linkedin, na.rm = TRUE)


## Functions inside functions
# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, NA, 17, 14)
facebook <- c(17, NA, 5, 16, 8, 13, 14)

# Calculate the mean absolute deviation
mean(abs(linkedin - facebook), na.rm = TRUE)


### Writing Functions
# The last function in the definition of the body function is evaluated as a return.
## Write a function
# Create a function pow_two()
pow_two <- function(number) {
  number ^ 2
}

# Use the function
pow_two(12)

# Create a function sum_abs()
sum_abs <- function(arg1, arg2) {
  abs(arg1) + abs(arg2)
}

# Use the function
sum_abs(-2, 3)

# Example of function not requiring input
throw_die <- function() {
  number <- sample(1:6, size = 1)
  number
} # definition
throw_die() # execution

# Define the function hello()
hello <- function() {
  print("Hi there!")
  return(TRUE)
}

# Call the function hello()
hello()

# Finish the pow_two() function
pow_two <- function(x, print_info = TRUE) {
  y <- x ^ 2
  if(print_info) {
    print(paste(x, "to the power two equals", y))
  }
  return(y)
}


## R you functional?
# The linkedin and facebook vectors have already been created for you

# Define the interpret function
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return (num_views)
  } else {
    print("Try to be more visible!")
    return (0)
  }
}

# Call the interpret function twice
interpret(linkedin[1])
interpret(facebook[2])

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# The interpret() can be used inside interpret_all()
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Define the interpret_all() function
# views: vector with data to interpret
# return_sum: return total number of views on popular days?
interpret_all <- function(views, return_sum = TRUE) {
  count <- 0
  
  for (v in views) {
    count <- count + interpret(v)
  }
  
  if (return_sum) {
    return(count)
  } else {
    return(NULL)
  }
}

# Call the interpret_all() function on both linkedin and facebook
interpret_all(linkedin)
interpret_all(facebook)



### R Packages
# Code, data, documentation and tests already installed or not on our R environment
install.packages("ggvis") # with functions such as layer_points, scale_nominal and add_axis

# To see available packages
search()

# load package
library("ggvis")
# Or:
require("ggvis") # trows a warning if the package is not available instead of an error for `library()`
search()

## Load an R Package
# Load the ggplot2 package
library(ggplot2)

# Retry the qplot() function
qplot(mtcars$wt, mtcars$hp)

# Check out the currently attached packages again
search()





##### The Apply Family
### lapply 
# function that applys a function over list or vector and always returns a list. Note that the `unlist()` function can turn lists to vectors.
## Use lapply with a built-in R function
# The vector pioneers has already been created for you
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")

# Split names from birth year
split_math <- strsplit(pioneers, split = ":")

# Convert to lowercase strings: split_low
split_low <- lapply(split_math, tolower)

# Take a look at the structure of split_low
str(split_low)


## Use lapply with our own function
# Code from previous exercise:
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

# Write function select_first()
select_first <- function(x) {
  x[1]
}

# Apply select_first() over split_low: names
names = lapply(split_low, select_first)

# Write function select_second()
select_second <- function(x) {
  x[2]
}

# Apply select_second() over split_low: years
years = lapply(split_low, select_second)


## lapply and anonymous functions
# split_low has been created for you
split_low

# Transform: use anonymous function inside lapply
names <- lapply(split_low, function(x){x[1]})

# Transform: use anonymous function inside lapply
years <- lapply(split_low, function(x){x[2]})


## Use lapply with additional arguments
# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

# Generic select function
select_el <- function(x, index) {
  x[index]
}

# Use lapply() twice on split_low: names and years
names = lapply(split_low, select_el, index = 1)
years <- lapply(split_low, select_el, 2)



### sapply
# `simplify apply` returns a named vector containing the same information as the vector obtained ear lier using 
# the `lapply` and `unlist` functions together.
# When it cannot simplify a list to an array, it returns a named list instead.

## How to use sapply
# temp definition
temp = list(c(3, 7, 9, 6, -1), c(6, 9, 12, 13, 5), c(4, 8, 3, -1, -3), c(1, 4, 7, 2, -2),
            c(5, 7, 9, 4, 2), c(-3, 5, 8, 9, 4), c(3, 6, 9, 4, 1))
temp

# Use lapply() to find each day's minimum temperature
lapply(temp, min)

# Use sapply() to find each day's minimum temperature
sapply(temp, min)

# Use lapply() to find each day's maximum temperature
lapply(temp, max)

# Use sapply() to find each day's maximum temperature
sapply(temp, max)


## sapply with our own function
# temp is already defined in the workspace

# Finish function definition of extremes_avg
extremes_avg <- function(x) {
  ( min(x) + max(x) ) / 2
}

# Apply extremes_avg() over temp using sapply()
sapply(temp, extremes_avg)

# Apply extremes_avg() over temp using lapply()
lapply(temp, extremes_avg)


## sapply with function returning vector
# temp is already available in the workspace

# Create a function that returns min and max of a vector: extremes
extremes <- function(x) {
  c(min = min(x), max = max(x))
}

# Apply extremes() over temp with sapply()
sapply(temp, extremes)

# Apply extremes() over temp with lapply()
lapply(temp, extremes)


## sapply can't simplify, now what?
# temp is already prepared for you in the workspace

# Definition of below_zero()
below_zero <- function(x) {
  return(x[x < 0])
}

# Apply below_zero over temp using sapply(): freezing_s
freezing_s = sapply(temp, below_zero)

# Apply below_zero over temp using lapply(): freezing_l
freezing_l = lapply(temp, below_zero)

# Are freezing_s and freezing_l identical?
identical(freezing_s, freezing_l) # comparing list using the inbuilt function `identical`


## sapply with functions that return NULL
# temp is already available in the workspace

# Definition of print_info()
print_info <- function(x) {
  cat("The average temperature is", mean(x), "\n")
}

# Apply print_info() over temp using sapply()
sapply(temp, print_info)

# Apply print_info() over temp using lapply()
lapply(temp, print_info)



### vapply
# offers the possibility to explicitly specify the output format
# safer than sapply to simplify results as more strict

## Use vapply
# temp is already available in the workspace

# Definition of basics()
basics <- function(x) {
  c(min = min(x), mean = mean(x), max = max(x))
}

# Apply basics() over temp using vapply()
vapply(temp, basics, numeric(3))

# temp is already available in the workspace

# Definition of the basics() function
basics <- function(x) {
  c(min = min(x), mean = mean(x), median = median(x), max = max(x))
}

# Fix the error:
vapply(temp, basics, numeric(4))


## From sapply to vapply
# temp is already defined in the workspace

# Convert to vapply() expression
vapply(temp, max, numeric(1))

# Convert to vapply() expression
vapply(temp, function(x, y) { mean(x) > y }, y = 5, logical(1))





##### Utilities
### Useful Functions
## Mathematical utilities
# The errors vector has already been defined for you
errors <- c(1.9, -2.6, 4.0, -9.5, -3.4, 7.3)

# Sum of absolute rounded values of errors
sum(abs(round(errors)))


## Find the error
# Don't edit these two lines
vec1 <- c(1.5, 2.5, 8.4, 3.7, 6.3)
vec2 <- rev(vec1)

# Fix the error
mean(c(abs(vec1), abs(vec2))) # adding c()


## Data Utilities
# seq(): Generate sequences, by specifying the from, to, and by arguments.
# rep(): Replicate elements of vectors and lists.
# sort(): Sort a vector in ascending order. Works on numerics, but also on character strings and logicals.
# rev(): Reverse the elements in a data structures for which reversal is defined.
# str(): Display the structure of any R object.
# append(): Merge vectors or lists.
# is.*(): Check for the class of an R object.
# as.*(): Convert an R object from one class to another.
# unlist(): Flatten (possibly embedded) lists to produce a vector.
# The linkedin and facebook lists have already been created for you
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)

# Convert linkedin and facebook to a vector: li_vec and fb_vec
li_vec = unlist(linkedin)
fb_vec = unlist(facebook)

# Append fb_vec to li_vec: social_vec
social_vec <- append(li_vec, fb_vec)

# Sort social_vec
sort(social_vec, decreasing = TRUE)


## Find the error
# Fix me
rep(seq(1, 7, by = 2), times = 7) # after switching the functions


## Beat Gauss using R
# Create first sequence: seq1
seq1 <- seq(1, 500, by = 3)

# Create second sequence: seq2
seq2 <- seq(1200, 900, by = -7)

# Calculate total sum of the sequences
sum(seq1, seq2)



### Regular Expressions
# sequence of (meta)characters that form a search pattern which you can use to match strings.
# ^a and a$ respectively match a at the beginning and the end of strings
# grep(pattern = re, x = str) == which(grepl(pattern = re, x = str))
# sub() or gsub() for replacing respectively the first or all patterns in a given string

## grepl & grep
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl(pattern = "edu", emails)

# Use grep() to match for "edu", save result to hits
hits = grep(pattern = "edu", emails)

# Subset emails using hits
emails[hits]

# @, because a valid email must contain an at-sign.
# .*, which matches any character (.) zero or more times (*). Both the dot and the asterisk are metacharacters. You can use them to match any character between the at-sign and the ".edu" portion of an email address.
# \\.edu$, to match the ".edu" part of the email at the end of the string. The \\ part escapes the dot: it tells R that you want to use the . as an actual character.
# \\s: Match a space. The "s" is normally a character, escaping it (\\) makes it a metacharacter.
# [0-9]+: Match the numbers 0 to 9, at least once (+).
# ([0-9]+): The parentheses are used to make parts of the matching string available to define the replacement.
# In sub(".*\\s([0-9]+)\\snomination.*$", "\\1", awards), the \\1 in the replacement argument of sub() gets set to the string that is captured by the regular expression [0-9]+

# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for .edu addresses more robustly
grepl(pattern = "@.*\\.edu$", x = emails)

# Use grep() to match for .edu addresses more robustly, save result to hits
hits = grep(pattern = "@.*\\.edu$", x = emails)

# Subset emails using hits
emails[hits]


## sub & gsub
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "global@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use sub() to convert the email domains to datacamp.edu
sub(pattern = "@.*\\.edu$", replacement = "@datacamp.edu", x = emails)

# Test
awards <- c("Won 1 Oscar.",
            "Won 1 Oscar. Another 9 wins & 24 nominations.",
            "1 win and 2 nominations.",
            "2 wins & 3 nominations.",
            "Nominated for 2 Golden Globes. 1 more win & 2 nominations.",
            "4 wins & 1 nomination.")

sub(".*\\s([0-9]+)\\snomination.*$", "\\1", awards)



### Times & Dates
Sys.Date() # today
Sys.time() # time
as.Date("1970-02-01") # convert str to date, format = "%Y-%m-%d" by default
Sys.Date() + 3 # arithmetic
# Dates add daily when times do so with seconds. Note that R displays automatically displays easily interpretable formats.
# Dates are numerically only the number of days since the first January of 1970, same for seconds with time.
# unclass() to gets the numeric form of dates & times
# You can check out the packages: lubridate, zoo and xts to learn more.

## Right here, right now
# Get the current date: today
today <- Sys.Date()

# See what today looks like under the hood
unclass(today)

# Get the current time: now
now <- Sys.time() # POSIXct object

# See what now looks like under the hood
unclass(now)


## Create and format dates
# Date Formats
# %Y: 4-digit year (1982)
# %y: 2-digit year (82)
# %m: 2-digit month (01)
# %d: 2-digit day of the month (13)
# %A: weekday (Wednesday)
# %a: abbreviated weekday (Wed)
# %B: month (January)
# %b: abbreviated month (Jan)

# Same date
as.Date("1982-01-13")
as.Date("Jan-13-82", format = "%b-%d-%y")
as.Date("13 January, 1982", format = "%d %B, %Y")

# Formating date
today <- Sys.Date()
format(Sys.Date(), format = "%d %B, %Y")
format(Sys.Date(), format = "Today is a %A!")

# Definition of character strings representing dates
str1 <- "May 23, '96"
str2 <- "2012-03-15"
str3 <- "30/January/2006"

# Convert the strings to dates: date1, date2, date3
date1 <- as.Date(str1, format = "%b %d, '%y")
date2 <- as.Date(str2, format = "%Y-%m-%d")
date3 <- as.Date(str3, format = "%d/%B/%Y")

# Convert dates to formatted strings
format(date1, "%A")
format(date2, "%d")
format(date3, "%b %Y")


## Create and format times
# Time Formats
# %H: hours as a decimal number (00-23)
# %I: hours as a decimal number (01-12)
# %M: minutes as a decimal number
# %S: seconds as a decimal number
# %T: shorthand notation for the typical format %H:%M:%S
# %p: AM/PM indicator
# ?strptime for a full list of conversion symbols

# Definition of character strings representing times
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"

# Convert the strings to POSIXct objects: time1, time2
time1 <- as.POSIXct(str1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2, format = "%Y-%m-%d %H:%M:%S")

# Convert times to formatted strings
format(time1, "%M")
format(time2, "%I:%M %p")


## Calculations with Dates
# With 5 dates you can create yourself
day1 = "2024-08-11" 
day2 = "2024-08-13"
day3 = "2024-08-18"
day4 = "2024-08-24"
day5 = "2024-08-29"

# day1, day2, day3, day4 and day5 are already available in the workspace

# Difference between last and first pizza day
day5 - day1

# Create vector pizza
pizza <- c(day1, day2, day3, day4, day5)

# Create differences between consecutive pizza days: day_diff
day_diff = diff(pizza) # ?diff

# Average period between two consecutive pizza days
mean(day_diff)


## Calculations with Times
# Login and logout times for an Internet user
login = c(as.POSIXct("2024-08-15 10:18:04 UTC"), as.POSIXct("2024-08-20 09:14:18 UTC"), as.POSIXct("2024-08-20 12:21:51 UTC"),
          as.POSIXct("2024-08-20 12:37:24 UTC"), as.POSIXct("2024-08-22 21:37:55 UTC"))
logout = c(as.POSIXct("2024-08-15 10:56:29 UTC"), as.POSIXct("2024-08-20 09:14:52 UTC"), as.POSIXct("2024-08-20 12:35:48 UTC"),
           as.POSIXct("2024-08-20 13:17:22 UTC"), as.POSIXct("2024-08-22 22:08:47 UTC"))

# Calculate the difference between login and logout: time_online
time_online = logout - login

# Inspect the variable time_online
time_online

# Calculate the total time online
sum(time_online)

# Calculate the average time online
mean(time_online)


## Time is for the essence
astro <- c(spring = "20-Mar-2015", summer = "25-Jun-2015", fall = "23-Sep-2015", winter = "22-Dec-2015")
astro
meteo <- c(spring = "March 1, 15", summer = "June 1, 15", fall = "September 1, 15", winter = "December 1, 15")
meteo         

# Convert astro to vector of Date objects: astro_dates
astro_dates = as.Date(astro, format = "%d-%b-%Y")

# Convert meteo to vector of Date objects: meteo_dates
meteo_dates = as.Date(meteo, format = "%B %d, %y")

# Calculate the maximum absolute difference between astro_dates and meteo_dates
max(abs(astro_dates - meteo_dates))