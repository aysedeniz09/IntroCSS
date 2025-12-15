Why computational social science?
================
Dr. Ayse D. Lokmanoglu
Lecture 1, (B) Jan 22, (A) Jan 27

## R Exercises

------------------------------------------------------------------------

## Intro to R Studio

RStudio is an **integrated development environment (IDE)** for R, a
programming language widely used for data analysis, statistical
modeling, and visualization

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rconsole.jpg?raw=true)

------------------------------------------------------------------------

### R Studio: The Console

The Console is where you directly interact with R. You can type R
commands, hit Enter, and see the immediate results.

Key Features: - Executes code line-by-line. - Useful for quick
calculations or testing small snippets of code. - Does not save
commands—once you close RStudio, the history of commands in the Console
is gone unless explicitly saved.

***TRY: write `2 + 2` in the console and press Enter.***

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rconsole2.png?raw=true)

------------------------------------------------------------------------

### R Studio: The Terminal

The Terminal is separate from the Console and provides access to your
computer’s command-line interface (CLI).

Key Features: - Allows you to run system-level commands (e.g.,
navigating file systems, managing files). - Useful for integrating with
tools like Git or installing software packages.

Key Difference from Console: - The Console is R-specific, while the
Terminal is for general command-line tasks.

<mark>We will not use Terminal most of the time</mark>

***TRY: In the Terminal, type `ls` (Mac/Linux) or `dir` (Windows) to
list files in your current directory.***

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rterminal.png?raw=true)

------------------------------------------------------------------------

### RStudio: Project

An RStudio Project is a way to organize your work by grouping files,
data, and scripts for a specific task or analysis.

Why Use Projects? - Keeps your workspace clean and focused. -
Automatically sets the working directory to the project folder. -
Ensures reproducibility by keeping everything needed for a project in
one place.

How to Create a Project: 1. Click on <span class="inline-button">**File
→ New Project….**</span>. 2. Choose whether to create a new directory,
use an existing directory, or clone a Git repository. 3. Give it a name
and location.

***TRY: Create a project called “EMS747_Class_Exercises” and notice how
RStudio creates a .Rproj file for managing it.***

------------------------------------------------------------------------

### RStudio: Project (continued)

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rproject.jpg?raw=true)

------------------------------------------------------------------------

### RStudio: Script

A script is a text file where you write and save R code for future
use. - Scripts let you document your work, making it reproducible and
shareable. - You can save time by re-running pre-written code instead of
typing commands repeatedly. How to Create and Use a Script: - Click on
<span class="inline-button">**File → New File → R Script**</span>. -
Write R code in the script editor. - E.g.

``` r
x <- 5
y <- 10
z <- x + y
print(z)
```

    ## [1] 15

- Highlight the code you want to run and press
  <span class="inline-button">**Ctrl+Enter**</span> (Windows/Linux) or
  <span class="inline-button">**Cmd+Enter**</span> (Mac) to execute it
  in the Console.

------------------------------------------------------------------------

### RStudio: Script (continued)

![](images/R_Script_1.png)

------------------------------------------------------------------------

### R Markdown in R Studio

- [R
  Markdown](https://rstudio.github.io/cheatsheets/html/rmarkdown.html)
  is a framework that allows you to integrate code, output, and
  narrative in one document.
- You can produce reports in multiple formats: HTML, PDF, Word, etc.

Why do we use R Markdown? - Combine code and text for reproducible
research. - Create interactive and visually appealing documents. - Easy
to share analyses with others.

[R Markdown Cheathseet](https://rmarkdown.rstudio.com/lesson-15.HTML)

------------------------------------------------------------------------

### How to create a document in R Markdown

- Click on <span class="inline-button">**File**</span> \>
  <span class="inline-button">**New File**</span> \>
  <span class="inline-button">**R Markdown**</span>.
- Choose a title, author, and output format (HTML, PDF, or Word).
- Edit the template provided in the new .Rmd file.
- <mark>For our class you can use the Markdown from BB and take notes on
  that!</mark>

To run code you use code Chunks - Surround code chunks with `{r}` at the
beginning and close them with three backticks at the end. - or use the
Insert Code Chunk button. Add a chunk label and/or chunk options inside
the curly braces after r.

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/rcodechunk.png?raw=true)

------------------------------------------------------------------------

### R: Basic Grammar

#### Variable Assignment

Variables are used to store data or values.

`=` (Simple Assignment) **Similar to python**

<mark>`<-` (Leftward Assignment) **Most Common used by R coders and we
will use this**</mark>

`->` (Rightward Assignment) **Rarely used**

``` r
x = "Simple_Assignment" 
print(x)
```

    ## [1] "Simple_Assignment"

``` r
y <- "Leftward Assignment"
print(y)
```

    ## [1] "Leftward Assignment"

``` r
"Rightward_Assignment" -> z
print(z)
```

    ## [1] "Rightward_Assignment"

------------------------------------------------------------------------

### R is case-sensitive

``` r
x <- 2

print(X)
```

    ## Error in eval(expr, envir, enclos): object 'X' not found

It gave an error, why?

Cause R is <mark> case sensitive </mark>

``` r
print(x)
```

    ## [1] 2

------------------------------------------------------------------------

### Comments

To comment - Comments are notes in the code that R ignores. Use `#` to
write comments. - R only has single line comments so if you want
multiple lines you need to repeat the `#` for each line.

``` r
variable_2 <- "Leftward Assignment" ## this is the most common used by R coders
# Other's work as well 
```

------------------------------------------------------------------------

### R Reserved Keywords

You cannot use these keywords as variable names. These are reserved
keywords for R.

| Words | Description |
|----|----|
| if | Used for conditional execution of code blocks. |
| else | Specifies an alternative block of code to execute if the `if` condition is false. |
| while | Executes a block of code repeatedly as long as a condition is true. |
| repeat | Creates an infinite loop that must be terminated with a `break` statement. |
| for | Loops through a sequence of elements. |
| function | Defines a function, a reusable block of code. |
| in | Used in `for` loops to specify the sequence being iterated over. |
| next | Skips the current iteration in a loop and moves to the next one. |
| break | Exits a loop immediately. |
| TRUE | Logical constant representing a boolean value of `true`. |
| FALSE | Logical constant representing a boolean value of `false`. |
| NULL | Represents the absence of a value or an undefined value. |
| Inf | Represents infinity (e.g., division by zero). |
| NaN | Represents “Not a Number,” often resulting from undefined mathematical operations. |
| NA | Represents missing data or “Not Available.” |
| NA_integer\_ | Represents a missing integer value. |
| NA_complex\_ | Represents a missing complex number. |
| NA_real\_ | Represents a missing real (numeric) value. |

------------------------------------------------------------------------

### Data Types

- Numeric: Numbers

  - e.g., `3.14`, `42`

- -Character: Text or strings

  - e.g., `"Hello"`, `"R"`

- Logical: Boolean values

  - `TRUE`, `FALSE`

- Factor: Categorical data

  - e.g., `"Male"`, `"Female"`

- You can use `typeof()` to see what type of data it is

**TRY: Writing different data types**

``` r
age <- 25  # Numeric
typeof(age)
```

    ## [1] "double"

``` r
name <- "Alice"  # Character
typeof(name)
```

    ## [1] "character"

``` r
is_student <- TRUE  # Logical
typeof(is_student)
```

    ## [1] "logical"

Question? What is double?

------------------------------------------------------------------------

**TRY: Create variables and see what types they are**

------------------------------------------------------------------------

### Dates

- Date: Represents calendar dates.
  - e.g., “2023-01-01”
- `POSIXct/POSIXlt`: Represents date and time.
  - e.g., “2023-01-01 12:34:56”
- R uses the `Date` and `POSIXct/POSIXlt` classes for working with dates
  and times.
- Use `as.Date()` to convert strings to dates.
- Use `Sys.Date()` for the current date.
- Use `Sys.time()` for the current date and time.

``` r
a <- "2023-01-01"
typeof(a)
```

    ## [1] "character"

``` r
b <- as.Date(a)
typeof(b)
```

    ## [1] "double"

**TRY: Converting strings to dates**

``` r
# Convert a string to a date
my_date <- as.Date("2023-01-01")
typeof(my_date)

# Get the current date
today <- Sys.Date()

# Add 7 days to a date
future_date <- today + 7

# Display the date and class
print(future_date)
class(future_date)
```

------------------------------------------------------------------------

### Basic Arithmetic

Operators in R:

- Addition: `+`

- Subtraction: `-`

- Multiplication: `*`

- Division: `/`

- Exponentiation: `^`

**TRY**

``` r
a <- 10
b <- 3

sum <- a + b  # Addition
print(sum)  
```

    ## [1] 13

``` r
product <- a * b  # Multiplication
print(product)
```

    ## [1] 30

``` r
power <- a ^ b  # Exponentiation
print(power)
```

    ## [1] 1000

------------------------------------------------------------------------

**TRY** - Create variables and use basic arithmetic, I started for you
play with them more!

``` r
x<-20
x<-5
x
```

    ## [1] 5

``` r
y<-10
x*y
```

    ## [1] 50

------------------------------------------------------------------------

### Vectors

A vector is a sequence of data elements of the same type. - Creating
Vectors: Use the `c()` function.

**TRY**

``` r
numbers <- c(1, 2, 3, 4, 5)  # Numeric vector
names <- c("Alice", "Bob", "Charlie")  # Character vector
is_student <- c(TRUE, FALSE, TRUE)  # Logical vector
```

**TRY what types they are**

``` r
typeof(numbers)
```

    ## [1] "double"

You can access an element in a vector with square brackets `[]`

``` r
print(numbers[2])  # Prints the second element of the vector
```

    ## [1] 2

------------------------------------------------------------------------

### Vectors beyond numbers

- Vectors can hold various types of data, including:
- Character: Strings of text.
- Numeric: Numbers.
- Logical: TRUE, FALSE.

``` r
phrase <- "Vectors are fun!"
phrase
```

    ## [1] "Vectors are fun!"

``` r
fruits <- c("Banana", "Mango", "Strawberry", "Grapes")  # ADD YOUR FAVORITES!
fruits
```

    ## [1] "Banana"     "Mango"      "Strawberry" "Grapes"

- You can again access it using `[]` square brackets, try it yourself!
  .tiny-code\[

``` r
fruits[2]  # Access the 2nd item
```

    ## [1] "Mango"

------------------------------------------------------------------------

### Vector functions

- Access specific items with `[]` (we practices above)
- `length()`: Finds the number of elements in a vector.

``` r
# Vector properties
length(fruits)       # Number of elements
```

    ## [1] 4

``` r
fruits * 2           # Produces an ERROR
```

    ## Error in fruits * 2: non-numeric argument to binary operator

``` r
1:length(fruits)     # Sequence from 1 to the vector length
```

    ## [1] 1 2 3 4

``` r
fruits[2:3]          # Access multiple items
```

    ## [1] "Mango"      "Strawberry"

``` r
fruits[-c(1, 4)]     # Exclude items 1 and 4
```

    ## [1] "Mango"      "Strawberry"

Why does `fruits * 2` produce an error?

------------------------------------------------------------------------

### Vectors continued, sequences

We can create sequences with vectors using `:`

``` r
A <- 11:20
print(A)
```

    ##  [1] 11 12 13 14 15 16 17 18 19 20

``` r
B <- 0:10
print(B)
```

    ##  [1]  0  1  2  3  4  5  6  7  8  9 10

**TRY: Vector functions with your number vectors**

``` r
# Vector properties
length(A)       # Number of elements
```

    ## [1] 10

``` r
B * 2           # This time no error
```

    ##  [1]  0  2  4  6  8 10 12 14 16 18 20

``` r
1:length(A)     # Sequence from 1 to the vector length
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
B[2:3]          # Access multiple items
```

    ## [1] 1 2

``` r
A[-c(1, 4)]     # Exclude items 1 and 4
```

    ## [1] 12 13 15 16 17 18 19 20

------------------------------------------------------------------------

### Vector Indexing

- Access items with `[]`
- Exclude an item with `-`:

``` r
fruits[3]  # Third item
```

    ## [1] "Strawberry"

``` r
fruits[c(1, 4)]  # First and fourth items
```

    ## [1] "Banana" "Grapes"

``` r
fruits[-2]  # Exclude the second item
```

    ## [1] "Banana"     "Strawberry" "Grapes"

Practice: - How do you select only items 1, 3, and 5? - How do you
exclude items 2 and 4?

``` r
# Selecting items:
fruits[c(1, 3, 5)]
```

    ## [1] "Banana"     "Strawberry" NA

``` r
# Excluding items:
fruits[-c(2, 4)]
```

    ## [1] "Banana"     "Strawberry"

``` r
# Saving a subset:
favorite_fruits <- fruits[c(1, 3)]
favorite_fruits
```

    ## [1] "Banana"     "Strawberry"

------------------------------------------------------------------------

### Combining Vectors

Combine vectors of different types:

``` r
numbers <- 1:5
text <- "Hello"
combo <- c(numbers, text)
combo
```

    ## [1] "1"     "2"     "3"     "4"     "5"     "Hello"

Type Coercion: - R converts all elements in a vector to the same type.

- Order of precedence:

  - `Character > Numeric > Logical`.

``` r
typeof(numbers)      # "integer"
```

    ## [1] "integer"

``` r
typeof(text)         # "character"
```

    ## [1] "character"

``` r
typeof(combo)        # "character"
```

    ## [1] "character"

Practice:

- Combine a vector of numbers and a vector of colors.

- Check the resulting vector’s type using `typeof()`.

------------------------------------------------------------------------

### Vectors class exercises

1.  Create a vector of your favorite hobbies.

    - Access the first two items.

    - Exclude the last item.

2.  Combine vectors of numbers and character strings.

    - What is the type of the resulting vector?
    - What happens if you add `TRUE` to the vector?

``` r
numbers <- 1:3
strings <- c("One", "Two", "Three")
combined <- c(numbers, strings)
```

------------------------------------------------------------------------

### Vectors and Arithmetics

We can also do artihmetics with vectors!

``` r
A + B
```

    ##  [1] 11 13 15 17 19 21 23 25 27 29 21

What will happen if we vectors of different sizes?

``` r
D <- 20:24
E <- 25:30

D+E
```

    ## [1] 45 47 49 51 53 50

R applies **recycling** which means…

- D (length 5) is recycled to match the length of E (length 6).

- D becomes: 20, 21, 22, 23, 24, 20 (repeating the first element).

- Then, element-wise addition is performed:

  - `(20 + 25), (21 + 26), (22 + 27), (23 + 28), (24 + 29), (20 + 30)` -
    45, 47, 49, 51, 53, 50

------------------------------------------------------------------------

### From Vectors to Data Frames

A data frame is a table-like structure (multiple vectors combined into
rows and column) in R where each column can have a different data type
(numeric, character, logical, etc.). Think of it as a spreadsheet where
each column is a variable, and each row is an observation.

#### 1. Create a dataframe

- Use the `data.frame()` function to create a data frame.

``` r
# Create a data frame
df <- data.frame(
  Name = c("Ayse", "Jessy", "Chris"),  # Character column
  Age = c(25, 30, 35),  # Numeric column
  Professor = c(TRUE, FALSE, TRUE)  # Logical column
)

# Print the data frame
print(df)
```

    ##    Name Age Professor
    ## 1  Ayse  25      TRUE
    ## 2 Jessy  30     FALSE
    ## 3 Chris  35      TRUE

``` r
### OR

Name <- c("Ayse", "Jessy", "Chris")  # Character column
Age <- c(25, 30, 35)  # Numeric column
Professor <- c(TRUE, FALSE, TRUE)  # Logical column

df <- data.frame(Name, Age, Professor)
print(df)
```

    ##    Name Age Professor
    ## 1  Ayse  25      TRUE
    ## 2 Jessy  30     FALSE
    ## 3 Chris  35      TRUE

------------------------------------------------------------------------

#### <mark>Vectors in a data frame must have the same length!!</mark>

``` r
# Mismatched lengths will fail
names <- c("Alice", "Bob", "Charlie")
ages <- c(25, 30)  # Fewer elements
people <- data.frame(names, ages)  # ERROR
```

    ## Error in data.frame(names, ages): arguments imply differing number of rows: 3, 2

Let’s fix the error

``` r
# Fix the error:
ages <- c(25, 30, 35)
people <- data.frame(names, ages)
people
```

    ##     names ages
    ## 1   Alice   25
    ## 2     Bob   30
    ## 3 Charlie   35

------------------------------------------------------------------------

**TRY: Practice creating a dataframe**

1.  Create a vector of your favorite sports.
    - Select items 2 through 4.
    - Exclude item 1.
2.  Combining Vectors:
    - Combine a vector of numbers `(1:5)` with a vector of shapes
      `("Circle", "Square", "Triangle")`.
    - Check the type of the resulting vector.
3.  Building Data Frames:
    - Create a data frame with `us_df`:
      - `us_cities <- c("Boston", "Chicago", "Seattle")`
      - `us_populations <- c(700000, 2700000, 750000)`
    - Create another data frame with `asia_df`:
      - `asia_cities <- c("Beijing", "Shanghai", "Taipei", "Kaohsiung")`
      - `asia_populations <- c(21540000, 24280000, 2640000, 2775000)`

- Create a data frame with your own set of favorite cities (at least 3
  cities and estimated populations).

- Add more cities to the asia_df:

  - Include “Guangzhou” with a population of 18,810,000.
  - Include “New Taipei City” with a population of 4,000,000.

- Combine all cities into one data frame:

  - Merge US and Asian city data frames into one combined table.

------------------------------------------------------------------------

#### 2. Explore/Inspect a Data Frame

Basic Functions to Explore a Data Frame:

- `head(df)`: Displays the first 6 rows of the data frame.

- `tail(df)`: Displays the last 6 rows.

- `dim(df)`: Returns the dimensions (rows, columns).

- `str(df)`: Shows the structure of the data frame, including data
  types.

- `summary(df)`: Provides summary statistics for each column.

``` r
head(df)        # First 6 rows
```

    ##    Name Age Professor
    ## 1  Ayse  25      TRUE
    ## 2 Jessy  30     FALSE
    ## 3 Chris  35      TRUE

``` r
tail(df)        # Last 6 rows
```

    ##    Name Age Professor
    ## 1  Ayse  25      TRUE
    ## 2 Jessy  30     FALSE
    ## 3 Chris  35      TRUE

``` r
dim(df)         # Dimensions: rows and columns
```

    ## [1] 3 3

``` r
str(df)         # Structure
```

    ## 'data.frame':    3 obs. of  3 variables:
    ##  $ Name     : chr  "Ayse" "Jessy" "Chris"
    ##  $ Age      : num  25 30 35
    ##  $ Professor: logi  TRUE FALSE TRUE

``` r
summary(df)     # Summary statistics
```

    ##      Name                Age       Professor      
    ##  Length:3           Min.   :25.0   Mode :logical  
    ##  Class :character   1st Qu.:27.5   FALSE:1        
    ##  Mode  :character   Median :30.0   TRUE :2        
    ##                     Mean   :30.0                  
    ##                     3rd Qu.:32.5                  
    ##                     Max.   :35.0

------------------------------------------------------------------------

#### 3. Accessing Data in a Data Frame

Accessing Columns:

- Use the `$` operator:`df$ColumnName`.

- Use bracket notation: `df[ , "ColumnName"]`.

``` r
print(df$Name)  # Access the 'Name' column
```

    ## [1] "Ayse"  "Jessy" "Chris"

``` r
print(df[, "Age"])  # Access the 'Age' column
```

    ## [1] 25 30 35

Accessing Rows:

- Use bracket notation with a row index: `df[row_number, ]`.

``` r
print(df[1, ])  # Access the first row
```

    ##   Name Age Professor
    ## 1 Ayse  25      TRUE

Accessing Specific Elements:

- Use `df[row, column]`.

``` r
print(df[2, 3])  # Access the element in the 2nd row and 3rd column
```

    ## [1] FALSE

------------------------------------------------------------------------

#### 4. Adding and Removing Data

<mark> Don’t forget `[row, column]`</mark>

Adding Columns:

- Use the `$` operator or bracket notation to add a new column.

``` r
df$Graduation <- c("2021", "2026", "2019")  # Add a new column 'Graduation'
print(df)
```

    ##    Name Age Professor Graduation
    ## 1  Ayse  25      TRUE       2021
    ## 2 Jessy  30     FALSE       2026
    ## 3 Chris  35      TRUE       2019

Adding Rows:

- Use the `rbind()` function.

``` r
new_row <- data.frame(Name = "Donpeng", Age = 28, Professor = FALSE, Graduation = "2025")
df <- rbind(df, new_row)  # Add a new row
print(df)
```

    ##      Name Age Professor Graduation
    ## 1    Ayse  25      TRUE       2021
    ## 2   Jessy  30     FALSE       2026
    ## 3   Chris  35      TRUE       2019
    ## 4 Donpeng  28     FALSE       2025

Removing Columns:

- Use the `NULL` assignment, `-` or subset the data frame.

``` r
df$Graduation <- NULL  # Remove the 'Graduation' column
print(df)
```

    ##      Name Age Professor
    ## 1    Ayse  25      TRUE
    ## 2   Jessy  30     FALSE
    ## 3   Chris  35      TRUE
    ## 4 Donpeng  28     FALSE

``` r
df2 <- df[,-3]
print(df2)
```

    ##      Name Age
    ## 1    Ayse  25
    ## 2   Jessy  30
    ## 3   Chris  35
    ## 4 Donpeng  28

Same with rows, use `-`.

``` r
df3 <- df[-2,]
print(df3)
```

    ##      Name Age Professor
    ## 1    Ayse  25      TRUE
    ## 3   Chris  35      TRUE
    ## 4 Donpeng  28     FALSE

------------------------------------------------------------------------

#### 5. Data Manipulations

Manipulating data is key to preparing it for analysis.

Common tasks:

- Filtering rows.

- Selecting columns.

- Sorting data.

- Aggregating data.

------------------------------------------------------------------------

#### 6. Filtering and Subsetting Data

Filtering Rows: Use logical conditions inside square brackets.

**TRY: Filter rows where Age \> 25**

``` r
# Filter rows where Age > 25
df_filtered <- df[df$Age > 25, ]
print(df_filtered)
```

    ##      Name Age Professor
    ## 2   Jessy  30     FALSE
    ## 3   Chris  35      TRUE
    ## 4 Donpeng  28     FALSE

Selecting Specific Columns: Use column indices or names.

**TRY: Select only ‘Name’ and ‘Age’ columns**

``` r
# Select only 'Name' and 'Age' columns
df_subset <- df[, c("Name", "Age")]
print(df_subset)
```

    ##      Name Age
    ## 1    Ayse  25
    ## 2   Jessy  30
    ## 3   Chris  35
    ## 4 Donpeng  28

------------------------------------------------------------------------

#### 7. Ordering Data

Rearrange rows based on column values.

**TRY: Sort by Age in ascending order**

``` r
# Sort by Age in ascending order
sorted_df <- df[order(df$Age), ]

# Sort by Age in descending order
sorted_df_desc <- df[order(-df$Age), ]
```

**TRY: Sort rows by Name in alphabetical order.**

------------------------------------------------------------------------

#### 8. Common Data Frame Functions

- `nrow(df)`: Returns the number of rows.
- `ncol(df)`: Returns the number of columns.
- `colnames(df)`: Returns column names.
- `rownames(df)`: Returns row names.
- `merge(df1, df2)`: Combines two data frames by matching rows. *We will
  learn to do this in Tidy next week*

------------------------------------------------------------------------

#### 9. Basic Aggregations

Compute summary statistics (e.g., mean, sum) for groups of data.

**TRY:**

``` r
# Example: Calculate mean Age 
mean(df$Age)
```

    ## [1] 29.5

**TRY: Try with other functions such as `max()`, `min()`, `sum()`, and
others**

------------------------------------------------------------------------

### Class Exercise

1.  Create a Data Frame: Create a data frame of your favorite movies,
    including columns for Title, Year, and Rating.

2.  Filter Rows: Filter the data frame to show only movies released
    after 2010.

3.  Add a New Column: Add a column indicating whether the movie has won
    an Oscar (`TRUE` or `FALSE`).

------------------------------------------------------------------------

### Functions

Functions perform specific tasks. They take inputs (arguments) and
return outputs.

- Syntax: `function_name(arguments)`

**TRY**

``` r
sum_result <- sum(c(1, 2, 3))  # Sum of a vector
print(sum_result) 
```

    ## [1] 6

``` r
mean_result <- mean(c(4, 5, 6))  # Mean of a vector
print(mean_result) 
```

    ## [1] 5

------------------------------------------------------------------------

### Conditional Statements

Conditional statements allow you to perform different actions based on
conditions.

- Keywords: `if`, `else if`, `else`

**TRY**

``` r
x <- 15

if (x > 10) {
  print("x is greater than 10")
} else if (x == 10) {
  print("x is equal to 10")
} else {
  print("x is less than 10")
}
```

    ## [1] "x is greater than 10"

------------------------------------------------------------------------

### Loops

Loops allow repetitive tasks to be automated.

Common Loops:

- `for`: Iterates over a sequence.

``` r
# for loop
for (i in 1:5) {
  print(i)
}
```

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5

- `while`: Repeats as long as a condition is TRUE.

``` r
# while loop
x <- 1
while (x <= 5) {
  print(x)
  x <- x + 1
}
```

    ## [1] 1
    ## [1] 2
    ## [1] 3
    ## [1] 4
    ## [1] 5

------------------------------------------------------------------------

### What is Regex (Regular Expression)?

- A regular expression (regex) is a sequence of characters that defines
  a search pattern.
- Used for:
  - Matching patterns in text.
  - Extracting or replacing specific text.
  - Validating strings (e.g., usernames, email addresses).
- Easily process large text datasets.
- Clean and analyze text data efficiently.

------------------------------------------------------------------------

### RegEx Basic Syntax

[Regex Cheat Sheet](https://rstudio.github.io/cheatsheets/regex.pdf)

We will use the [`stringr` package](https://stringr.tidyverse.org/)

``` r
install.packages("stringr")
```

``` r
library(stringr)
```

| Regex.Pattern | Matches | Example |
|:---|:---|:---|
| . | Any single character | “Mario1” matches “M.rio1” |
| ^ | Start of a string | “^Zelda” matches “Zelda…” |
| \$ | End of a string | “end\$” matches “The end” |
| \* | Zero or more of the preceding character | “A\*B” matches “AAAB” |
| \+ | One or more of the preceding character | “Go+” matches “Gooo” |
| \[\] | Match any character in the set | “\[PS\]” matches “P”, “S” |
| \| | Logical OR | “Mario\|Zelda” matches either |

Regex Patterns and Examples

------------------------------------------------------------------------

### Extract Text

Let’s create a dataset:

``` r
reviews <- c(
  "The new Mario Kart is amazing!",
  "Zelda: Breath of the Wild is a masterpiece.",
  "I can't wait for Final Fantasy XVI.",
  "Have you tried playing God of War: Ragnarok?",
  "Elden Ring redefined the RPG genre."
)
```

Let’s extract the titles: Maria Kart, Zelda, Final Fantasy XVI, God of
War: Ragnarok

``` r
# Extract video game titles using regex
titles <- str_extract(reviews, "Mario Kart|Zelda: Breath of the Wild|Final Fantasy XVI|God of War: Ragnarok|Elden Ring")

print(titles)
```

    ## [1] "Mario Kart"                "Zelda: Breath of the Wild"
    ## [3] "Final Fantasy XVI"         "God of War: Ragnarok"     
    ## [5] "Elden Ring"

------------------------------------------------------------------------

### Validate Text & Data

You can use regex to validate if a text or pattern of text is in your
data

``` r
game_codes <- c("GAME-1234", "INVALID", "PLAY-5678", "GAMEX-9999", "GAME-567")
valid_codes <- str_detect(game_codes, "^(GAME|PLAY)-\\d{4}$")

print(valid_codes)
```

    ## [1]  TRUE FALSE  TRUE FALSE FALSE

------------------------------------------------------------------------

### Extract using a pattern

Let’s extract years — numbers of 4 digits

``` r
release_info <- c(
  "The Legend of Zelda was released in 2023.",
  "Elden Ring: GOTY Edition, releasing in 2024.",
  "Final Fantasy XVI came out in 2023."
)

years <- str_extract(release_info, "\\b\\d{4}\\b")

print(years)
```

    ## [1] "2023" "2024" "2023"

------------------------------------------------------------------------

### Match words using patterns

Identify words that start with G or R

``` r
text <- c("God of War is great", "Ragnarok is a masterpiece", "Mario Kart rules")

# Find words starting with G or R
matches <- str_extract_all(text, "\\b[G|R]\\w+")

print(matches)
```

    ## [[1]]
    ## [1] "God"
    ## 
    ## [[2]]
    ## [1] "Ragnarok"
    ## 
    ## [[3]]
    ## character(0)

------------------------------------------------------------------------

### R Packages

- Packages are collections of R functions, data, and compiled code.
- Extend the functionality of base R.
- Simplifies complex tasks.
- Widely used for specialized analyses.

E.g., [`tidy`](https://tidyr.tidyverse.org/),
[`dplyr`](https://dplyr.tidyverse.org/),
[`ggplot2`](https://ggplot2.tidyverse.org/)

------------------------------------------------------------------------

### Installing & Loading Packages

- Installation
  - Use the `install.packages()` function to install a package from
    CRAN.

``` r
install.packages("tidyr")
install.packages("dplyr")
install.packages("lubridate")
```

- Loading
  - Use the `library()` function to load an installed package.

``` r
library(tidyr)
library(dplyr)
library(lubridate)
```

- Check the package documentation with `?`

``` r
?tidyr
```

``` r
?dplyr
```

***N.B. Packages only need to be installed once but must be loaded in
each session `library()`. Keep packages updated with
`update.packages()`***

------------------------------------------------------------------------

### Lubridate Package

[`Lubridate`](https://lubridate.tidyverse.org/) is a package that makes
working with dates easier.

- [`Lubridate` Cheat
  Sheet](https://rawgit.com/rstudio/cheatsheets/main/lubridate.pdf) - It
  provides easy functions to parse, manipulate, and extract date-time
  components.

``` r
install.packages("lubridate") # only once
library(lubridate) # everytime you start R
```

Key Functions:

- Parsing Dates and Times:

  - `ymd()`, `dmy()`, `mdy(`): Convert strings to dates.

  - `ymd_hms()`, `mdy_hms()`: Handle date-time strings with hours,
    minutes, seconds.

- Extracting Components:

  - `year()`, `month()`, `day()`: Extract parts of a date.

  - `hour()`, `minute()`, `second()`: Extract time components.

- Manipulating Dates:

  - `today()`, `now()`: Current date or date-time.

  - Arithmetic: Add or subtract days, months, etc.

- Time Zones:

  - Set or change time zones with `with_tz()` or `force_tz()`.

------------------------------------------------------------------------

**TRY: Play with dates**

``` r
library(lubridate)

# Parse a date
my_date <- ymd("2023-01-01")

# Parse a date-time
my_datetime <- ymd_hms("2023-01-01 12:34:56")

# Extract components
year(my_date)    # 2023
```

    ## [1] 2023

``` r
month(my_date)   # 1
```

    ## [1] 1

``` r
day(my_date)     # 1
```

    ## [1] 1

``` r
hour(my_datetime) # 12
```

    ## [1] 12

``` r
# Add 7 days
future_date <- my_date + days(7)

# Set a time zone
new_timezone <- with_tz(my_datetime, tzone = "America/New_York")
print(new_timezone)
```

    ## [1] "2023-01-01 07:34:56 EST"

------------------------------------------------------------------------

### Lecture 1 Cheat Sheet

| **Topic** | **Key Points** |
|----|----|
| **Variable Assignment** | `=` (simple assignment), `<-` (most common), and `->` (rare). R is case-sensitive. |
| **Comments** | Use `#` for single-line comments. |
| **R Reserved Keywords** | Reserved for R’s functionality, e.g., `if`, `for`, `TRUE`, `NULL`, `Inf`, `NA`. |
| **Data Types** | Numeric, Character, Logical, Factor, and Dates (`Date`, `POSIXct`). |
| **Basic Arithmetic** | Addition `+`, Subtraction `-`, Multiplication `*`, Division `/`, Exponentiation `^`. |
| **Vectors** | Sequences of data elements of the same type. Created with `c()`. |
| **Vector Functions** | `length()`, indexing with `[]`, `rep()`, sequence generation with `:`. |
| **Combining Vectors** | Use `c()`. Type coercion converts all elements to the same type (Character \> Numeric \> Logical). |
| **Data Frames** | Table-like structures combining multiple vectors with the same length. Created with `data.frame()`. |
| **Inspecting Data Frames** | `head()`, `tail()`, `str()`, `summary()`, `dim()`, `colnames()`, `rownames()`. |
| **Manipulating Data Frames** | Filter rows (`df[df$col > value, ]`), select columns (`df[, c("col1", "col2")]`), sort with `order()`. |
| **Basic Aggregations** | Group and summarize data using `aggregate()` and functions like `mean()`, `sum()`, `max()`. |
| **R Packages** | Install with `install.packages()` and load with `library()`. E.g., `tidy`, `dplyr`, `lubridate`. |
| **Dates with Lubridate** | Parse dates (`ymd()`, `mdy()`, etc.), extract components (`year()`, `month()`), manipulate (`+ days`). |
| **Functions** | Perform tasks with inputs (arguments) and outputs. E.g., `sum()`, `mean()`, custom-defined functions. |
| **Conditional Statements** | Use `if`, `else if`, `else` for logic. |
| **Loops** | Automate repetitive tasks with `for` and `while`. |
| **Regular Expressions (Regex)** | Match patterns in text (`str_extract()`, `str_detect()`), extract years, validate patterns. |
