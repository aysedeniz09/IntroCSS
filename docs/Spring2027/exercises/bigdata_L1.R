# Lecture 1: Why computational social science? ####
# COM EM 747 / COM EM 855 · Lecture 1 · January 25, 2027 · Dr. Ayse D. Lokmanoglu
# Lecture notes (same code, with pictures): bigdata_L1-github.md on GitHub
#
# HOW TODAY WORKS
#   We go back and forth: I show you some code, then you try it yourself in
#   the Activity right after it. Every section has an Activity. Write your
#   code in the empty space under each Activity. Work with your neighbors.
#
#   Go slowly. Run every line yourself, even the ones I already ran. Typing
#   and running the code is how you learn it.
#
# HOW TO USE THIS SCRIPT IN RSTUDIO
#   - Run one line: put your cursor on it and press
#       Ctrl + Enter   (Windows)
#       Cmd + Enter    (Mac)
#   - Run several lines: highlight them, then use the same keys.
#   - The answer shows up in the Console (bottom left).
#   - Lines starting with # are comments. R skips them. They're notes for you.
#   - If the Console shows a + instead of >, R thinks your code isn't finished
#     (usually a missing ) or "). Click in the Console and press Esc.
#   - SAVE this script often (File -> Save) so you keep your work.
#   - Click the "Outline" button (top right of this pane) to jump between
#     sections.
#
#   Section   Topic
#   1         A tour of RStudio
#   2         Projects and folders
#   3         R Packages
#   4         R Basic Grammar
#   5         Data Types
#   6         Basic Arithmetic
#   7         Vectors
#   8         Data Frames: base R and tidy
#   9         Your first real dataset
#   10        Put it together
#   --        Cheat Sheet


# 1. A tour of RStudio ####
# RStudio has four main panes:
#
#   Source (top left)        Where your scripts open. You write code here.
#   Console (bottom left)    Where R runs code and shows you the answer.
#   Environment (top right)  Everything you've stored so far.
#   Files / Plots / Packages / Help (bottom right)

## 1.1 The Console ----
# The Console is where you directly interact with R. Type a command, press
# Enter, and see the result. The Console does NOT save your commands. Once you
# close RStudio, they're gone. That's why we write code in scripts.
#
# TRY: click in the Console, type 2 + 2, and press Enter.
#
# What does [1] mean in the answer? It means "here is the first item of the
# answer." Ignore it for now. It will make sense in Section 7.

## 1.2 The Terminal ----
# The Terminal (a tab next to the Console) is for your computer, not for R.
# We will not use Terminal most of the time.

## 1.3 Scripts ----
# A script is a text file where you write and save R code. You're reading
# one right now! Make a new one with File -> New File -> R Script.
x <- 5
y <- 10
z <- x + y
print(z)

# Run these lines with Ctrl + Enter / Cmd + Enter. The answer appears in the
# Console.

## Activity 1 ----
#   1. Find the four panes in your RStudio. Which one is the Console?
#   2. In the Console, calculate 2 + 2, then 10 / 4.
#   3. Open a new R Script. Type 3 * 5 in it and run it with Ctrl+Enter /
#      Cmd+Enter. Where did the answer show up?
#   4. Save the script as practice.R. Where did RStudio save it?





# 2. Projects and folders ####

## 2.1 RStudio Projects ----
# An RStudio Project keeps all the files for one piece of work together, and
# it automatically points R at the project folder.
#
# How to create a project:
#   1. File -> New Project...
#   2. New Directory -> New Project
#   3. Give it a clear name (example: EMS747_Project)
#   4. Choose a location you can easily find again (Desktop or Documents)
#
# RStudio makes a file ending in .Rproj. ALWAYS open your work by clicking
# that .Rproj file.

## 2.2 Organize your project folder ----
# Inside your project folder, create these folders (Files pane -> New Folder):
#   data/      for datasets (CSV, Excel, etc.)
#   scripts/   for R scripts you write during the semester
#
# Your project should look like this:
#   EMS747_Project/
#     EMS747_Project.Rproj
#     data/
#     scripts/
#     bigdata_L1.R

## 2.3 Your working directory ----
# The working directory is the folder R is looking at right now. When your
# project is open, it should be your project folder.
getwd()

# In words: "get the working directory."
#
# Why this matters: at the end of today (Section 9), we load data with short
# paths like read_csv("data/my_file.csv"). That only works if R is looking at your
# project folder.

## Activity 2 ----
#   1. Create a project called EMS747_Class_Exercises. Notice the .Rproj file
#      RStudio makes.
#   2. Inside it, make two folders: data and scripts.
#   3. Move this script (bigdata_L1.R) into your project folder and open it
#      from the Files pane.
#   4. Run getwd(). Does the path end in EMS747_Class_Exercises?
#   5. Close RStudio. Reopen your project by double-clicking the .Rproj file.
#      Run getwd() again. Is it the same?





# 3. R Packages ####
# Packages are add-on toolboxes that other people wrote. Using one takes two
# steps. Think of it like a book:
#   install.packages() buys the book and puts it on your shelf. ONCE per
#     computer.
#   library() takes the book off the shelf so you can use it. EVERY time you
#     open R.
#
# In this class we use the tidyverse: a bundle of packages that work well
# together (dplyr, tidyr, readr, stringr, ggplot2, lubridate, ...).
install.packages("tidyverse")   # ONCE (can take a few minutes)
library(tidyverse)              # EVERY time you open R

# Notice: the name is in quotes in install.packages("tidyverse") but not in
# library(tidyverse).
#
# When you load it, R prints a list of the packages it turned on. That's a
# message, not an error.
#
# Check the package documentation with ?
?dplyr

## Activity 3 ----
#   1. Install the tidyverse (this can take a few minutes, that's normal).
#   2. Load it with library(). What does R print?
#   3. Run ?dplyr. Where did the help page open?
#   4. Run library(tidyvers) (misspelled on purpose). What error do you get?
#      What does it mean?





# 4. R: Basic Grammar ####

## 4.1 Storing things: assignment ----
# Doing math is nice, but the answers disappear. To KEEP something, we give
# it a name. This is called ASSIGNMENT.
apple <- 5
apple

# In words: "apple gets 5."
#
# What just happened?
#   - R made a box, wrote "apple" on the label, and put the number 5 inside.
#   - The LEFT side (apple) is a name you make up.
#   - The ARROW <- means "store whatever is on the right into the name on the
#     left." Type < then -. Shortcut: Alt + - (Windows), Option + - (Mac).
#   - Storing is quiet. Nothing prints until you type the name.
#   - Look at your Environment pane: apple is there now.
#
# There are three ways to assign. We use <- in this class.
x = "Simple_Assignment"
print(x)

y <- "Leftward Assignment"
print(y)

"Rightward_Assignment" -> z
print(z)

# If you store something new under a name that already exists, the old value
# is REPLACED. R does not warn you.
apple <- 10
apple

# You can use stored values in math, and store the result in a new box:
banana <- 3
fruit_total <- apple + banana
fruit_total

# In words: "fruit_total gets apple plus banana."

## 4.2 R is case-sensitive ----
x <- 2

print(X)   # this gives an error ON PURPOSE

# It gave an error, why? Cause R is case sensitive. x and X are two
# different names.
print(x)

# "object 'X' not found" is the most common error you will see.
# CHECK YOUR SPELLING AND CAPITAL LETTERS FIRST.

## Activity 4.1 ----
#   1. Create a box called coffees that stores 2, and a box called teas that
#      stores 3.
#   2. Create drinks that stores coffees + teas. Print it.
#   3. Now change teas to 10. Print drinks again. Did it change? Why not?
#      Write the line that would update it.
#   4. Store the name of your favorite drink in a box called fav_drink (text
#      goes in quotes). Then type Fav_drink. What happens, and why?





## 4.3 Comments ----
# Comments are notes in the code that R ignores. Use # to write comments.
# R only has single line comments, so repeat the # for each line.
variable_2 <- "Leftward Assignment" ## this is the most common used by R coders
# Other's work as well

## 4.4 Names you can and can't use ----
# Rules for names:
#   - Start with a letter: candy1 works, 1candy does not.
#   - No spaces. Use underscores: fruit_total, not fruit total.
#   - Be descriptive: study_hours is better than sh.
#
# Reserved keywords already mean something to R, so you can't use them:
#   if, else            conditional code
#   for, while, repeat  loops
#   function            defines a function
#   TRUE, FALSE         logical values (yes/no)
#   NULL                the absence of a value
#   NA                  missing data ("Not Available")
#   Inf                 infinity (e.g., division by zero)
#   NaN                 "Not a Number" (e.g., 0 / 0)

## Activity 4.2 ----
#   1. Above your code from Activity 4.1, add a comment that says what the
#      code does.
#   2. Which of these names work? GUESS FIRST, then try storing the number 1
#      in each one:
#        my_score    2nd_score    my score    TRUE    score2
#   3. Run ls(). It lists every box you've stored. Compare it to your
#      Environment pane.





# 5. Data Types ####

## 5.1 Numeric, Character, Logical, Factor ----
# Every value in R has a TYPE:
#   numeric     numbers                    3.14, 42
#   character   text, ALWAYS in quotes     "Hello", "R"
#   logical     yes/no values              TRUE, FALSE
#   factor      categories                 "Masters", "PhD" (later this semester)
#
# typeof() tells you the type.
age <- 25  # Numeric
typeof(age)

name <- "Alice"  # Character
typeof(name)

is_student <- TRUE  # Logical
typeof(is_student)

# What does typeof() do? It asks R: "how are you storing this value inside
# the computer?" Every value has exactly one storage type.
#
# QUESTION? WHAT IS DOUBLE?
# R has two ways to store numbers:
#
#   typeof() says   What it is                    Example          How you make it
#   "double"        any number, decimals allowed   25, 3.14, -2     just type the number
#   "integer"       whole numbers only             25L, 1:5         add an L, or use :
#
#   - "Double" is short for "double precision." R stores each number with
#     about 15-16 digits of accuracy. The name comes from computer history:
#     it uses twice the memory of an older "single precision" format. You
#     don't need to know more than that.
#   - Every number you type is a double, even a whole number like 25. That's
#     why typeof(age) above says "double", not "integer".
#   - Integers show up on their own when you make a sequence with :
#     (Section 7.4). Don't be surprised when you see "integer" there.
#   - For your work, both just mean "number." Math works the same on both.
#     To ask "is this a number?", use is.numeric():
typeof(25)       # a number you type: double
typeof(25L)      # the L makes it an integer
typeof(1:5)      # a sequence made with : is integer
is.numeric(25)   # is it a number? yes
is.numeric(1:5)  # is it a number? yes

# You will see these types again, shortened. When you print a tibble or use
# glimpse() (Sections 8 and 9), R labels each column with a short version of
# its type:
#
#   typeof()      Short label in a tibble   Means
#   "double"      <dbl>                     number
#   "integer"     <int>                     whole number
#   "character"   <chr>                     text
#   "logical"     <lgl>                     TRUE/FALSE
#
# So when you see <dbl> next to a column, it means "this column is numbers."
#
# QUOTES MATTER. 5 is a number. "5" is text that happens to look like a
# number. You can't do math with text:
"5" + 1   # this gives an error ON PURPOSE
5 + 1

## Activity 5.1 ----
#   1. Check the type of "Boston", 84.2, and FALSE. GUESS FIRST.
#   2. Check the type of "84.2". Why is it different from 84.2?
#   3. GUESS FIRST: what does typeof(10) give? And typeof(10L)? And
#      typeof(1:10)? Run them to check.
#   4. Is 10L a number? Check with is.numeric().
#   5. Fix the error: "10" + 5





## 5.2 Asking TRUE/FALSE questions ----
# R answers yes/no questions with TRUE or FALSE. We'll use this all semester
# to keep only the rows we want.
#
#   ==        "is equal to?"
#   !=        "is not equal to?"
#   >  <      "is greater / less than?"
#   >= <=     "is greater / less than or equal to?"
age > 18           # "is age greater than 18?"
age == 30          # "is age equal to 30?"
age != 30          # "is age NOT equal to 30?"
"Boston" == "boston"   # capital letters count!

# <- STORES. == ASKS.
# age <- 30 puts 30 in the box. age == 30 asks "is there a 30 in the box?"
#
# One handy trick: R treats TRUE as 1 and FALSE as 0. Remember this, it comes
# back in Section 7.
TRUE + TRUE + FALSE

## Activity 5.2 ----
#   1. GUESS FIRST whether each is TRUE or FALSE. Then run them.
#        10 > 3
#        5 == 5.0
#        "tea" == "Tea"
#        7 != 7
#        76.7 >= 80
#   2. Store your age in a box called my_age. Write a question that asks
#      "is my_age at least 21?"
#   3. What does TRUE + TRUE + TRUE + FALSE give you? Why?





# 6. Basic Arithmetic ####
#   +   addition
#   -   subtraction
#   *   multiplication
#   /   division
#   ^   exponentiation (power)
a <- 10
b <- 3

sum <- a + b  # Addition
print(sum)

product <- a * b  # Multiplication
print(product)

power <- a ^ b  # Exponentiation
print(power)

# R follows the usual math order: powers first, then * and /, then + and -.
# Use parentheses to be safe:
2 + 3 * 4     # 3 * 4 first, then + 2
(2 + 3) * 4   # 2 + 3 first, then * 4

## Activity 6 ----
#   1. How many minutes are in a week? (7 days x 24 hours x 60 minutes)
#   2. Store the number of hours you sleep per night in sleep. How many hours
#      do you sleep in a year?
#   3. GUESS FIRST, then run: 10 - 2 * 3 and (10 - 2) * 3.





# 7. Vectors ####
# A VECTOR is a list of values of the SAME type, stored under one name.
# Almost everything in R is built from vectors. Every column in a dataset is
# a vector.

## 7.1 Creating Vectors ----
# Use c(). c stands for COMBINE.
numbers <- c(1, 2, 3, 4, 5)  # Numeric vector
names <- c("Alice", "Bob", "Charlie")  # Character vector
is_student <- c(TRUE, FALSE, TRUE)  # Logical vector

# In words: "numbers gets the combination of 1, 2, 3, 4, and 5."
typeof(numbers)
typeof(names)
typeof(is_student)

# Vectors can hold text too:
fruits <- c("Banana", "Mango", "Strawberry", "Grapes")  # ADD YOUR FAVORITES!
fruits

## 7.2 Getting items out: indexing ----
# Use square brackets []. fruits[3] means "the 3rd item of fruits."
fruits[3]  # Third item

fruits[c(1, 4)]  # First and fourth items

fruits[2:3]  # Items 2 through 3

fruits[-2]  # Everything EXCEPT the second item

# Now [1] in your answers makes sense: it tells you the position of the first
# item on that line.
#
# Practice: How do you select only items 1, 3, and 5? How do you exclude
# items 2 and 4?
# Selecting items:
fruits[c(1, 3, 5)]

# Excluding items:
fruits[-c(2, 4)]

# Saving a subset:
favorite_fruits <- fruits[c(1, 3)]
favorite_fruits

# Why is there an NA above? fruits only has 4 items, so there is no item 5.
# R gives NA, which means "missing."

## Activity 7.1 ----
#   1. Create a vector called hobbies with 4 of your hobbies.
#   2. Get the first item. Then the first two items.
#   3. Get everything except the last item.
#   4. Create a vector called my_numbers with 5 numbers. What type is it?





## 7.3 Vector functions ----
# FUNCTIONS are R's built-in tools. The pattern is always:
#     function_name(what_you_give_it)
study_hours <- c(2, 5, 3, 8, 4)

length(study_hours)   # how many items
mean(study_hours)     # average
max(study_hours)      # biggest
min(study_hours)      # smallest
sum(study_hours)      # add them all up

# Some functions take more than one input, separated by commas. round() takes
# a number and how many decimal places you want:
round(mean(study_hours), 1)

# Read nested functions from the INSIDE OUT: "take the mean of study_hours,
# then round it to 1 decimal."
#
# Asking a question of a whole vector gives one TRUE/FALSE per item:
study_hours > 4

# Because TRUE = 1 and FALSE = 0 (Section 5.2), sum() COUNTS the TRUEs and
# mean() gives the PROPORTION:
sum(study_hours > 4)    # how many days were more than 4 hours?
mean(study_hours > 4)   # what proportion of days?

# Some functions don't work on every type:
length(fruits)       # Number of elements
fruits * 2           # Produces an ERROR

# Why does fruits * 2 produce an error?

## 7.4 Vector Sequences ----
# We can create sequences with :. In words, 11:20 means "every whole number
# from 11 to 20."
A <- 11:20
print(A)

B <- 0:10
print(B)

# TRY: Vector functions with your number vectors
length(A)       # Number of elements
B * 2           # This time no error
1:length(A)     # Sequence from 1 to the vector length
B[2:3]          # Access multiple items
A[-c(1, 4)]     # Exclude items 1 and 4

## Activity 7.2 ----
# Here are the hours of sleep one student got each night for a week:
#     sleep <- c(7, 6.5, 5, 8, 7.5, 9, 6)
#   1. Store the sleep vector.
#   2. What is the average? Round it to 1 decimal.
#   3. What were the most and least hours of sleep?
#   4. How many nights did they sleep less than 7 hours? (Hint: sum())
#   5. What was the sleep on night 3? On nights 6 and 7?
#   6. Make a vector of the numbers 1 to 100 using :. What is their sum?





## 7.5 Combining Vectors & Type Coercion ----
numbers <- 1:5
text <- "Hello"
combo <- c(numbers, text)
combo

# Notice the quotes: every number became text!
#
# A vector can only hold ONE type, so R converts everything to the same
# type. Order of precedence: Character > Numeric > Logical.
typeof(numbers)      # "integer"
typeof(text)         # "character"
typeof(combo)        # "character"

## 7.6 Vector Arithmetic & Recycling ----
# We can also do arithmetic with vectors! R does it item by item:
c(1, 2, 3) + c(10, 20, 30)

# In words: 1 + 10, 2 + 20, 3 + 30.
#
# What will happen if we use vectors of different sizes?
D <- 20:24
E <- 25:30

D+E

# R applies RECYCLING:
#   - D (length 5) is recycled to match the length of E (length 6).
#   - D becomes: 20, 21, 22, 23, 24, 20 (repeating the first element).
#   - Then: (20 + 25), (21 + 26), (22 + 27), (23 + 28), (24 + 29), (20 + 30)
# R gives you a WARNING when this happens. Recycling is usually a mistake, so
# check your lengths!

## Activity 7.3 ----
#   1. Combine c(1, 2, 3) with c("One", "Two", "Three"). What type is the
#      result? Why?
#   2. What happens if you combine c(1, 2, 3) with TRUE? What did TRUE become?
#   3. Here are prices in dollars: prices <- c(4.5, 3, 6.25). Convert them to
#      cents by multiplying the whole vector by 100.
#   4. GUESS FIRST: what does c(1, 2, 3, 4) + c(10, 20) give? Run it.





# 8. Data Frames: base R and tidy ####
# A DATA FRAME is a table where each COLUMN is a variable (a vector) and each
# ROW is an observation. Think of it as a spreadsheet.
#   - Each column can be a different type.
#   - Every column must have the same length!!

## 8.1 Create a data frame ----
# Base R uses data.frame():
df <- data.frame(
  Name = c("Ayse", "Jessy", "Chris"),  # Character column
  Age = c(25, 30, 35),  # Numeric column
  Professor = c(TRUE, FALSE, TRUE)  # Logical column
)

# Print the data frame
print(df)

# The tidyverse uses tibble(). It works the same way:
people <- tibble(
  Name = c("Ayse", "Jessy", "Chris"),
  Age = c(25, 30, 35),
  Professor = c(TRUE, FALSE, TRUE)
)

people

# A TIBBLE is a tidyverse data frame. It prints more neatly: it tells you the
# size (3 x 3) and the type of each column (<chr>, <dbl>, <lgl>).
# In this class we use tibbles.
#
# Vectors in a data frame must have the same length:
tibble(
  Name = c("Ayse", "Jessy", "Chris"),
  Age = c(25, 30)   # only 2 ages for 3 names: ERROR ON PURPOSE
)

# You can stack two tibbles with the same columns using bind_rows():
new_people <- tibble(
  Name = c("Donpeng"),
  Age = c(28),
  Professor = c(FALSE)
)

all_people <- bind_rows(people, new_people)
all_people

# In words: "all_people gets people with new_people stacked underneath."

## Activity 8.1 ----
#   1. Create a tibble called us_df with two columns:
#        city = c("Boston", "Chicago", "Seattle")
#        population = c(700000, 2700000, 750000)
#   2. Create a tibble called asia_df:
#        city = c("Beijing", "Shanghai", "Taipei", "Kaohsiung")
#        population = c(21540000, 24280000, 2640000, 2775000)
#   3. Combine them into one tibble called all_cities with bind_rows(). How
#      many rows does it have?
#   4. Make a tibble of 3 of your own favorite cities and their estimated
#      populations.





## 8.2 Looking at a data frame ----
# The first tools to use on ANY new dataset. R has a built-in dataset of cars
# called mtcars, so let's practice on it:
#   head()          the first 6 rows
#   tail()          the last 6 rows
#   nrow(), ncol()  number of rows, number of columns
#   names()         the column names
#   glimpse()       every column, its type, and the first few values (tidy)
#   summary()       quick statistics for every column
#   View()          opens it like a spreadsheet (capital V!)
head(mtcars)    # First 6 rows
nrow(mtcars)    # Number of rows
ncol(mtcars)    # Number of columns
names(mtcars)   # Column names

glimpse(mtcars)

# glimpse() is the tidyverse version of base R's str(). Both show the
# structure; glimpse() is easier to read.
summary(people)

## Activity 8.2 ----
#   1. How many rows and columns does mtcars have?
#   2. Use glimpse() on all_cities from Activity 8.1. What type is each
#      column?
#   3. Run View(mtcars). Click a column name to sort it. Which car has the
#      highest mpg?
#   4. Run summary(all_cities). What is the largest population?





## 8.3 Base R vs. tidy: the same task two ways ----
# REMINDER: R has two "dialects." BASE R is what comes with R. The TIDYVERSE
# is a set of packages with a cleaner, more readable style. You will see BOTH
# online, in old code, and from ChatGPT. In this class we write TIDY code,
# but you should be able to recognize base R when you see it.
#
#   Task                  Base R                         Tidy
#   Get one column        df$Age                         people |> pull(Age)
#   Pick columns          df[, c("Name", "Age")]         people |> select(Name, Age)
#   Keep rows             df[df$Age > 25, ]              people |> filter(Age > 25)
#   Sort                  df[order(df$Age), ]            people |> arrange(Age)
#   Sort, biggest first   df[order(-df$Age), ]           people |> arrange(desc(Age))
#   Add a column          df$Grad <- c(2021, 2026, 2019) people |> mutate(Grad = c(2021, 2026, 2019))
#   Average of a column   mean(df$Age)                   people |> summarise(mean_age = mean(Age))
#
# Keep rows where Age is over 25:
# Base R
df[df$Age > 25, ]

# Tidy
people |>
  filter(Age > 25)

# In words (tidy): "start with people, AND THEN keep the rows where Age is
# greater than 25." Remember > from Section 5.2? filter() keeps every row
# where the question is TRUE.
#
# Pick columns:
# Base R
df[, c("Name", "Age")]

# Tidy
people |>
  select(Name, Age)

# Sort by Age, oldest first:
# Base R
df[order(-df$Age), ]

# Tidy
people |>
  arrange(desc(Age))

# Add a column:
people <- people |>
  mutate(Graduation = c(2021, 2026, 2019))

people

# In words: "people gets people, AND THEN a new column called Graduation."
# Without people <- at the start, the new column would print but not be
# saved.
#
# Average age:
# Base R
mean(df$Age)

# Tidy
people |>
  summarise(mean_age = mean(Age))

# You don't need to memorize these verbs today. Next class we learn filter(),
# select(), mutate(), arrange(), and summarise() one at a time, slowly, with
# real data.

## Activity 8.3 ----
# Use the people tibble.
#   1. Keep only the professors (hint: filter(Professor == TRUE)).
#   2. Select only the Name column.
#   3. Sort by Name in alphabetical order (hint: arrange()).
#   4. READ THE BASE R: what does df[df$Age < 30, ] do? Write the tidy
#      version.





## 8.4 The pipe |> ----
# The |> symbol is called the PIPE. Read it as "AND THEN." It takes what's on
# the left and hands it to the function on the right. The pipe lets you chain
# steps, top to bottom, like a recipe:
people |>
  filter(Age > 25) |>
  arrange(desc(Age))

# In words: "start with people, AND THEN keep the rows where Age is over 25,
# AND THEN sort by Age, oldest first."
#
# Without the pipe, you would have to read it inside out:
arrange(filter(people, Age > 25), desc(Age))

# Same answer, much harder to read.
#
# Shortcut: Mac: Cmd + Shift + M, Windows: Ctrl + Shift + M
# To make the shortcut type |>: Tools -> Global Options -> Code -> check
# "Use native pipe operator, |>". Online you will also see %>%. It's an older
# pipe that does almost the same thing.

## Activity 8.4 ----
#   1. Turn on the native pipe in RStudio (Tools -> Global Options -> Code).
#      Test the shortcut.
#   2. Using all_cities from Activity 8.1, write a pipe that keeps cities with
#      a population over 1,000,000 AND THEN sorts them from biggest to
#      smallest.
#   3. Say your pipe out loud to your neighbor using "and then."





# 9. Your first real dataset ####
# Typing data by hand doesn't scale. Real data comes in files, usually CSV
# files (comma-separated values: a spreadsheet saved as plain text).

## 9.1 Loading a CSV file ----
# The tidyverse reads CSV files with read_csv(). Our first dataset describes
# 2,000 students: how they spend their day, their GPA, and their stress level.
students <- read_csv("https://media.githubusercontent.com/media/aysedeniz09/IntroCSS/refs/heads/main/data/student_lifestyle_dataset.csv")

# In words: "students gets the result of reading this CSV file." Same <- as
# apple <- 5, but now the box holds a whole table.
#
# When it loads, R prints a short report of the columns it found. That's a
# message, not an error.
#
# Loading from your computer: most of the time your data is a file in your
# data/ folder (Section 2.2). Because your project is open, a short path works:
#     students <- read_csv("data/student_lifestyle_dataset.csv")
#
# Base R reads CSV files with read.csv() (with a dot). You will see it online.
# In this class we use read_csv() (with an underscore), which gives you a
# tibble.

## 9.2 Meet the data ----
# Use the tools from Section 8.2 on any new dataset:
glimpse(students)

# Each ROW is one student. In research terms, a student is the UNIT OF
# ANALYSIS. Each COLUMN is a VARIABLE.
#
# WHAT DO THE COLUMNS MEAN? Always read the data dictionary.
#   Student_ID                        A number for each student
#   Study_Hours_Per_Day               Hours spent studying per day
#   Extracurricular_Hours_Per_Day     Hours on clubs and activities per day
#   Sleep_Hours_Per_Day               Hours of sleep per day
#   Social_Hours_Per_Day              Hours spent socializing per day
#   Physical_Activity_Hours_Per_Day   Hours of exercise per day
#   GPA                               Grade point average
#   Stress_Level                      "Low", "Moderate", or "High"
#   college                           The student's college
#   GPA_Level                         "LowGPA", "MediumGPA", or "HighGPA"
#   Stress_Level2                     "LowModerate" or "High"
#   books_read                        Number of books read
#
# Copy column names from names(students). The capital letters and
# underscores must match exactly (Section 4.2).
names(students)

## 9.3 Your first questions ----
# Now use the tidy verbs from Section 8.3 on real data.
#
# How many students sleep less than 6 hours a night?
students |> 
  filter(Sleep_Hours_Per_Day < 6) |> 
  nrow()

# In words: "start with students, AND THEN keep the rows where sleep is less
# than 6, AND THEN count the rows." 402 of the 2,000 students sleep less than
# 6 hours.
#
# Who studies the most?
students |> 
  arrange(desc(Study_Hours_Per_Day)) |> 
  select(Student_ID, Study_Hours_Per_Day, GPA) |> 
  head(5)

# In words: "start with students, AND THEN sort by study hours, biggest
# first, AND THEN keep three columns, AND THEN show the first 5 rows."
#
# What does a typical student look like?
students |> 
  summarise(
    mean_gpa = mean(GPA),
    mean_sleep = mean(Sleep_Hours_Per_Day),
    mean_study = mean(Study_Hours_Per_Day)
  )

# On average, students have a GPA of 3.12, sleep 7.5 hours, and study 7.5
# hours a day.
#
# Next class we go further: comparing groups (for example, colleges) with
# group_by() and count().

## Activity 9 ----
#   1. Load the student data into a box called students.
#   2. How many students and how many columns are there? What type is GPA?
#      What type is college?
#   3. How many students have a Stress_Level of "High"? (Hint: text goes in
#      quotes.)
#   4. What is the average Social_Hours_Per_Day? Round it to 1 decimal.
#   5. Show the 5 students who read the most books, with only their
#      Student_ID, books_read, and GPA.
#   6. READ THE BASE R: what does students[students$GPA > 3.5, ] do? Write the
#      tidy version.





# 10. Put it together ####

## Class Exercise ----
#   1. Create a tibble of 5 of your favorite movies called movies, with
#      columns for Title, Year, and Rating (out of 10).
#   2. Look at it with glimpse(). What type is each column?
#   3. Filter rows: show only movies released after 2010.
#   4. Add a new column: Oscar, saying whether each movie won an Oscar (TRUE
#      or FALSE). Save it back into movies.
#   5. Sort: show the movies from highest to lowest rating.
#   6. Use a pipe to do steps 3 and 5 together: movies after 2010, highest
#      rated first.
#   7. Base R check: write step 3 in base R. Does it give the same answer?
#   8. What is the average rating of your movies? Round it to 1 decimal.





# BEFORE NEXT CLASS
#   Assignment 1 (due Feb 1): make a GitHub account and install Git. Follow
#   Step 4 of the installation guide:
#   https://aysedeniz09.github.io/IntroCSS/install.html
#   Then submit your GitHub username and a screenshot of git --version on
#   Blackboard.
#
# Save this script: File -> Save.


# Lecture 1 Cheat Sheet ####
#   What you want            Code
#   Run code                 Ctrl + Enter (Windows) / Cmd + Enter (Mac)
#   Stuck on +               press Esc in the Console
#   Working directory        getwd()
#   Install (once)           install.packages("tidyverse")
#   Load (every time)        library(tidyverse)
#   Store something          apple <- 5                  "apple gets 5"
#   Comment                  # note                      R ignores this
#   Check the type           typeof()                    "double" = number
#   Is it a number?          is.numeric()
#   Tibble labels            <dbl> number, <int> whole number, <chr> text, <lgl> TRUE/FALSE
#   Ask a question           ==  !=  >  <  >=  <=        gives TRUE/FALSE
#   Make a vector            c(1, 2, 3)                  "combine 1, 2, 3"
#   Get items                x[2], x[c(1, 3)], x[2:3], x[-2]
#   Vector functions         length() mean() max() min() sum() round(x, 1)
#   Count / proportion       sum(x > 4) / mean(x > 4)
#   Sequence                 1:10
#   Make a tibble            tibble(col1 = c(...), col2 = c(...))
#   Stack tibbles            bind_rows(df1, df2)
#   Look at data             head() nrow() ncol() names() glimpse() summary() View()
#   Load a CSV               students <- read_csv("data/file.csv")
#   Pipe                     |>                          "and then"
#   Help                     ?function_name
#   Most common error        object 'X' not found -> check spelling and capitals
#
# Base R vs. tidy
#   Task             Base R                     Tidy (we use this)
#   One column       df$Age                     df |> pull(Age)
#   Pick columns     df[, c("Name", "Age")]     df |> select(Name, Age)
#   Keep rows        df[df$Age > 25, ]          df |> filter(Age > 25)
#   Sort             df[order(-df$Age), ]       df |> arrange(desc(Age))
#   Add a column     df$new <- ...              df |> mutate(new = ...)
#   Summarize        mean(df$Age)               df |> summarise(mean_age = mean(Age))
#   Structure        str(df)                    glimpse(df)
