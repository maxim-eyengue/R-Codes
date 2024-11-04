####### Joining Data with dplyr
# to combine data across multiple tables to answer more complex questions with dplyr.
# LEGO dataset from the Rebrickable website (`https://rebrickable.com/downloads/`)
# with information about sets, parts, themes, and colors that make up the LEGO history.


##### Joining tables

### The inner_join verb
# `theme_id` var in the `sets` table links to the `id` var in the `themes` table
# Each set has its theme. Joining these two tables allows to see it.
# `by` helps to specify on which variables to proceed the join
# `suffix` add more information on the variables which belong to both tables 
# with the same names in other to know from which table it comes
# properly instead of the default c("x", "y")

## Joining parts and part categories
# Join tables and Use the suffix argument to replace .x and .y suffixes
parts %>% 
  inner_join(part_categories, by = c("part_cat_id" = "id"), suffix = c(
    "_part", "_category"))

# Note that each part has exactly one category, so the joined table has exactly 
# as many observations as the parts table



### Joining with a one-to-many relationship
# The inventory table is introduced so that each inventory is a product made 
# of diverse parts
# In this situation joining with the set tables, as each set can have multiple 
# versions each corresponding to an inventory item. The joined table will be 
# bigger than the set table

## Joining parts and inventories
# Combine the parts and inventory_parts tables
parts %>%
  inner_join(inventory_parts, by = c("part_num"))
# The joined table is bigger because of the one to many relationship


## Joining in either direction (as the have the same id)
# Combine the parts and inventory_parts tables
inventory_parts %>%
  inner_join(parts, by = c("part_num"))



### Joining three or more tables
# We can pipe any number of joins that we want. We just have to specify
# the correct ids at the right places

## Joining three tables
# Add inventories and inventory_parts using an inner join 
sets %>%
  inner_join(inventories, by = c("set_num")) %>%
  inner_join(inventory_parts, by = c("id" = "inventory_id"))


## What's the most common color?
#  Add an inner join for the colors table and Count the number of colors and sort
sets %>%
  inner_join(inventories, by = "set_num") %>%
  inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  inner_join(colors, by = c("color_id" = "id"), suffix = c("_set", "_color")) %>%
  count(name_color, sort = TRUE)





##### Left and Right Joins

### The left_join verb
# recall: inner join
# inventory_parts_joined <- inventories %>%
#   inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
#   select(-id, -version) %>% # to remove id and version columns
#   arrange(desc(quantity))
# With inner joins, we keep information appearing in both tables.
# It is even possible to join on multiple columns.
# However to keep all information from the left table, we can use `left_join`
# The left_join verb shows all information present in the left table, the one
# present in both table but not the one only in the right table.

## Left joining two sets by part and color
# Millenium falcon lego set
millennium_falcon <- inventory_parts_joined %>%
  filter(set_num == "7965-1")

# Star destroyer lego set
star_destroyer <- inventory_parts_joined %>%
  filter(set_num == "75190-1")

# Combine the star_destroyer and millennium_falcon tables
millennium_falcon %>%
  left_join(star_destroyer, by = c("part_num", "color_id"),
            suffix = c("_falcon", "_star_destroyer"))


## Left joining two sets by color
# Aggregate Millennium Falcon for the total quantity in each part
millennium_falcon_colors <- millennium_falcon %>%
  group_by(color_id) %>%
  summarize(total_quantity = sum(quantity))

# Aggregate Star Destroyer for the total quantity in each part
star_destroyer_colors <- star_destroyer %>%
  group_by(color_id) %>%
  summarize(total_quantity = sum(quantity))

# Left join the Millennium Falcon colors to the Star Destroyer colors
millennium_falcon_colors %>%
  left_join(star_destroyer_colors, by = "color_id",
            suffix = c("_falcon", "_star_destroyer") )


## Finding an observation that doesn't have a match
# Inventory with version 1
inventory_version_1 <- inventories %>%
  filter(version == 1)

# Join versions to sets
sets %>%
  left_join(inventory_version_1, by = "set_num") %>%
  # Filter for where version is not a number (na)
  filter(is.na(version))



### The right_join verb
# As left joins keep all the information from the first table whether or not they
# appear in the second, a right join keep all observations from the second whether
# or not they appear in the first.
# Left joins and right joins are miror images of each other
# replace_na is a verb that replaces missing values

## Counting part colors, filling na and cleaning up the count
# Are there any part_cat_ids not present in parts?
parts %>%
  # Count the part_cat_id
  count(part_cat_id) %>%
  # Right join part_categories
  right_join(part_categories, by = c("part_cat_id" = "id"))
  # Filter for NA
  filter(is.na(n))
  # Use replace_na to replace missing values in the n column
  replace_na(list(n = 0))

  

### Joining tables to themselves
# An hierarchical table has a relation to itself is a table that has a relation
# to itself (i.e `id` and `parent_id` in the same table).
# We can join a hierarchical table to itself to explore the hierarchy of columns

## Joining themes to their children
# Join table to determine parent Harry's information
themes %>% 
  # Inner join the themes table
  inner_join(themes, by = c("id" = "parent_id"), suffix = c("_parent", "_child")) %>%
  # Filter for the "Harry Potter" parent name 
  filter(name_parent == "Harry Potter")


## Joining themes to their grandchildren
# Join themes to itself again to find the grandchild relationships
themes %>% 
  inner_join(themes, by = c("id" = "parent_id"),
             suffix = c("_parent", "_child")) %>%
  inner_join(themes, by = c("id_child" = "parent_id"),
             suffix = c("_parent", "_grandchild"))


## Left joining a table to itself
# Join themes to its own children and find those without children
themes %>% 
  # Left join the themes table to its own children
  left_join(themes, by = c("id" = "parent_id"), suffix = c("_parent", "_child")) %>%
  # Filter for themes that have no child themes
  filter(is.na(name_child))





##### Full, Semi and Anti Joins

### The full_join verb
# To keep all observations from both tables whether or not they match.

## Differences between Batman and Star Wars
# Create table
inventory_parts_joined <- inventories %>%
  inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  arrange(desc(quantity)) %>%
  select(-id, -version)

# Start with inventory_parts_joined table
inventory_parts_joined %>%
  # Combine with the sets table 
  inner_join(sets, by = c("set_num")) %>%
  # Combine with the themes table 
  inner_join(themes, by = c("theme_id" = "id"), suffix = c("_set", "_theme"))


## Aggregating each theme

# Save data
# Inventory
inventory_sets_themes <- inventory_parts_joined %>%
  inner_join(sets, by = "set_num") %>%
  inner_join(themes, by = c("theme_id" = "id"), suffix = c("_set", "_theme"))
# Batman
batman <- inventory_sets_themes %>%
  filter(name_theme == "Batman")
# Star wars
star_wars <- inventory_sets_themes %>%
  filter(name_theme == "Star Wars")

# Count the part number and color id, weight by quantity
# For batman
batman %>%
  count(part_num, color_id, wt = quantity)
# For star wars
star_wars %>%
  count(part_num, color_id, wt = quantity)


## Full joining Batman and Star Wars LEGO parts
# Combine to see differences
batman_parts %>%
  # Combine the star_wars_parts table 
  full_join(star_wars_parts, by = c("part_num", "color_id"),
            suffix = c("_batman", "_star_wars")) %>%
  # Replace NAs with 0s in the n_batman and n_star_wars columns 
  replace_na(list(n_batman = 0, n_star_wars = 0))


## Comparing Batman and Star Wars LEGO parts
# Get enough information to make our findings more interpretable 
parts_joined %>%
  # Sort the number of star wars pieces in descending order 
  arrange(desc(n_star_wars)) %>%
  # Join the colors table to the parts_joined table
  inner_join(colors, by = c("color_id" = "id")) %>%
  # Join the parts table to the previous join 
  inner_join(parts, by = "part_num", suffix = c("_color", "_part"))



### The semi_join and anti_join verbs
# inner, left, right and full join are mutating verbs adding variables.
# semi_join and anti_join verbs are filtering joins. They keep or remove information
# from the tables but does not add new ones.
# semi_join asks what observations in the first table are also in the second
# anti_join asks what observations in the first table are not in the second

## Something within one set but not another
# Load batmobite dataset
batmobile <- inventory_parts_joined %>%
  filter(set_num == "7784-1") %>%
  select(-set_num)

# Load batwing dataset
batwing <- inventory_parts_joined %>%
  filter(set_num == "70916-1") %>%
  select(-set_num)

# Filter the batwing set for parts that are also in the batmobile set
batwing %>%
  semi_join(batmobile, by = "part_num")

# Filter the batwing set for parts that aren't in the batmobile set
batwing %>%
  anti_join(batmobile, by = "part_num")


## What colors are included in at least one set?
# Use inventory_parts to find colors included in at least one set
colors %>%
  semi_join(inventory_parts, by = c("id" = "color_id"))


## Which set is missing version 1?
# Use filter() to extract version 1 
version_1_inventories <- inventories %>%
  filter(version == 1)

# Use anti_join() to find which set is missing a version 1
sets %>%
  anti_join(version_1_inventories, by = "set_num")



### Visualizing set differences

# scale fill manual to set up the colors to match the rgb values:
# setNames(colors_joined$rgb, colors_joined$name)
# fct_reorder() from the library `forcats` to reorder the column meaningfully

## Aggregating sets to look at their differences

# Load `inventory_parts_themes`
inventory_parts_themes <- inventories %>%
  inner_join(inventory_parts, by = c("id" = "inventory_id")) %>%
  arrange(desc(quantity)) %>%
  select(-id, -version) %>%
  inner_join(sets, by = "set_num") %>%
  inner_join(themes, by = c("theme_id" = "id"), suffix = c("_set", "_theme"))

# Create batman_colors dataset
batman_colors <- inventory_parts_themes %>%
  # Filter the inventory_parts_themes table for the Batman theme
  filter(name_theme == "Batman") %>%
  group_by(color_id) %>%
  summarize(total = sum(quantity)) %>%
  # Add a fraction column of the total divided by the sum of the total 
  mutate(fraction = total / sum(total))

# Filter and aggregate the Star Wars set data; add a fraction column
star_wars_colors <- inventory_parts_themes %>%
  # Filter the inventory_parts_themes table for the Batman theme
  filter(name_theme == "Star Wars") %>%
  group_by(color_id) %>%
  summarize(total = sum(quantity)) %>%
  # Add a fraction column of the total divided by the sum of the total 
  mutate(fraction = total / sum(total))


## Combining sets
# Combine tables for later comparison
batman_colors %>%
  # Join the Batman and Star Wars colors
  full_join(star_wars_colors, by = "color_id", suffix = c("_batman", "_star_wars")) %>%
  # Replace NAs in the total_batman and total_star_wars columns
  replace_na(list(total_batman = 0, total_star_wars = 0)) %>%
  inner_join(colors, by = c("color_id" = "id")) %>%
  # Create the difference and total columns
  mutate(difference = fraction_batman - fraction_star_wars,
         total = total_batman + total_star_wars) %>%
  # Filter for totals greater than 200
  filter(total > 200)  


## Visualizing the difference: Batman and Star Wars
# Data to visualize
colors_joined <- batman_colors %>%
  full_join(star_wars_colors, by = "color_id", suffix = c("_batman", "_star_wars")) %>%
  replace_na(list(total_batman = 0, total_star_wars = 0)) %>%
  inner_join(colors, by = c("color_id" = "id")) %>%
  mutate(difference = fraction_batman - fraction_star_wars,
         total = total_batman + total_star_wars) %>%
  filter(total >= 200) %>%
  mutate(name = fct_reorder(name, difference))

# Create a bar plot using colors_joined and the name and difference columns
ggplot(colors_joined, aes(name, difference, fill = name)) +
  geom_col() +
  coord_flip() +
  scale_fill_manual(values = color_palette, guide = "none") +
  labs(y = "Difference: Batman - Star Wars")





##### Case Study: Joins on Stack Overflow Data

### Stack Overflow Questions
# Each question on Stack Overflow has votes (up and downs) and can get many answers
# We will apply all the learned verbs on a dataset from Stack Overflow
# questions table: all questions with dates and scores
# question_tags table: matches questions to tags ids
# tags table: links tags ids to tags names


## Left joining questions and tags
# Join the questions and question_tags tables
questions_with_tags <- questions %>%
  left_join(question_tags, by = c("id" = "question_id")) %>%
  # Join in the tags table
  left_join(tags, by = c("tag_id" = "id")) %>%
  # Replace the NAs in the tag_name column
  replace_na(list(tag_name = "only-r"))


## Comparing scores across tags
# Find out the average score of the most asked questions
questions_with_tags %>% 
  # Group by tag_name
  group_by(tag_name) %>%
  # Get mean score and num_questions
  summarize(score = mean(score),
            num_questions = n()) %>%
  # Sort num_questions in descending order
  arrange(desc(num_questions))


## What tags never appear on R questions?
# Using a join, filter for tags that are never on an R question
tags %>%
  anti_join(question_tags, by = c("id" = "tag_id"))



### Joining questions and answers
# answers table: id, date, question id and scores
# A question can have 0 or multiple tables

## Finding gaps between questions and answers
# Join together questions with answers so we can measure the time between questions and answers
questions %>%
  # Inner join questions and answers with proper suffixes
  inner_join(answers, by = c("id" = "question_id"), suffix = c("_question", "_answer")) %>%
  # Subtract creation_date_question from creation_date_answer to create gap
  mutate(gap = as.integer(creation_date_answer - creation_date_question))


## Joining question and answer counts
# Count and sort the question id column in the answers table
answer_counts <- answers %>%
  count(question_id, sort = TRUE)

# Combine the answer_counts and questions tables
question_answer_counts <- questions %>%
  left_join(answer_counts, by = c("id" = "question_id")) %>%
  # Replace the NAs in the n column
  replace_na(list(n = 0))


## Joining questions, answers, and tags
# Identify which R topics get the most traction on Stack Overflow
tagged_answers <- question_answer_counts %>%
  # Join the question_tags tables
  inner_join(question_tags, by = c("id" = "question_id")) %>%
  # Join the tags table
  inner_join(tags, by = c("tag_id" = "id"))


## Average answers by question
# Find out how many answers each question gets on average
tagged_answers %>%
  # Aggregate by tag_name
  group_by(tag_name) %>%
  # Summarize questions and average_answers
  summarize(questions = n(),
            average_answers = mean(n)) %>%
  # Sort the questions in descending order
  arrange(desc(questions))



### The bind_rows verb
# binds tables together, stacking one on top of the other
# year() from the `lubridate` library turns a date into the relevant year.

## Joining questions and answers with tags
# Inner join the question_tags and tags tables with the questions table
questions_with_tags  <- questions %>%
  inner_join(question_tags, by = c("id" = "question_id")) %>%
  inner_join(tags, by = c("tag_id" = "id"))

# Inner join the question_tags and tags tables with the answers table
answers_with_tags  <- answers %>%
  inner_join(question_tags, by = "question_id") %>%
  inner_join(tags, by = c("tag_id" = "id"))


## Binding and counting posts with tags
# Combine the two tables into posts_with_tags
posts_with_tags <- bind_rows(questions_with_tags %>% mutate(type = "question"),
                             answers_with_tags %>% mutate(type = "answer"))

# Add a year column, then count by type, year, and tag_name
by_type_year_tag <- posts_with_tags %>%
  mutate(year = year(creation_date)) %>%
  count(type, year, tag_name)


## Visualizing questions and answers in tags
# Filter for the dplyr and ggplot2 tag names 
by_type_year_tag_filtered <- by_type_year_tag %>%
  filter(tag_name %in% c("ggplot2","dplyr"))

# Create a line plot faceted by the tag name 
ggplot(by_type_year_tag_filtered, aes(year, n, color = type)) +
  geom_line() +
  facet_wrap(~ tag_name)