Why computational social science?
================
Dr. Ayse D. Lokmanoglu
Lecture 1, (B) Jan 21, 2026, (A) Jan 26, 2026

# R Exercises

## Lecture 1 Table of Contents

| Section | Topic                                  |
|---------|----------------------------------------|
| 1       | Intro to R Studio                      |
| 1.1     | The Console                            |
| 1.2     | The Terminal                           |
| 1.3     | Projects                               |
| 1.4     | Organize your project file             |
| 1.5     | Scripts                                |
| 2       | Working directory and paths            |
| 2.1     | Check your working directory           |
| 3       | R Markdown                             |
| 3.1     | How to create a document in R Markdown |
| 3.2     | Running vs knitting                    |
| 4       | R Packages                             |
| 4.1     | Installing & Loading                   |
| 5       | R Basic Grammar                        |
| 5.1     | Variable Assignment                    |
| 5.2     | Case Sensitivity                       |
| 5.3     | Comments                               |
| 5.4     | Reserved Keywords                      |
| 6       | Data Types                             |
| 6.1     | Numeric, Character, Logical, Factor    |
| 6.2     | Dates                                  |
| 6.3     | Lubridate Package                      |
| 7       | Basic Arithmetic                       |
| 8       | Vectors                                |
| 8.1     | Creating Vectors                       |
| 8.2     | Vector Indexing                        |
| 8.3     | Vector Functions                       |
| 8.4     | Sequences                              |
| 8.5     | Combining Vectors & Type Coercion      |
| 8.6     | Vector Arithmetic & Recycling          |
| 9       | Data Frames                            |
| 9.1     | Creating Data Frames                   |
| 9.2     | Exploring/Inspecting Data Frames       |
| 9.3     | Accessing Data                         |
| 9.4     | Adding and Removing Data               |
| 9.5     | Filtering and Subsetting               |
| 9.6     | Ordering Data                          |
| 9.7     | Common Data Frame Functions            |
| 9.8     | Basic Aggregations                     |

------------------------------------------------------------------------

## 1. Intro to R Studio

RStudio is an **integrated development environment (IDE)** for R, a
programming language widely used for data analysis, statistical
modeling, and visualization

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rconsole.jpg?raw=true)

------------------------------------------------------------------------

### 1.1 The Console

The Console is where you directly interact with R. You can type R
commands, hit Enter, and see the immediate results.

Key Features: - Executes code line-by-line. - Useful for quick
calculations or testing small snippets of code. - Does not save
commands—once you close RStudio, the history of commands in the Console
is gone unless explicitly saved.

***TRY: write `2 + 2` in the console and press Enter.***

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rconsole2.png?raw=true)

------------------------------------------------------------------------

### 1.2 The Terminal

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

### 1.3 Project

An RStudio Project is a way to organize your work by grouping files,
data, and scripts for a specific task or analysis.

Why Use Projects? - Keeps your workspace clean and focused. -
Automatically sets the working directory to the project folder. -
Ensures reproducibility by keeping everything needed for a project in
one place.

How to Create a Project: 1. Click on <span class="inline-button">**File
→ New Project….**</span>. 2. Choose whether to create a new directory,
use an existing directory, or clone a Git repository. 3. Give it a clear
name (example: EMS747_Project) 4. Choose a location you can easily find
again

***TRY: Create a project called “EMS747_Class_Exercises” and notice how
RStudio creates a .Rproj file for managing it.***

<mark>When you create a project, RStudio makes a file ending in
`.Rproj`. Always open your work by clicking that `.Rproj` file.</mark>

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rproject.jpg?raw=true)

------------------------------------------------------------------------

### 1.4 Organize your project file

Inside your project folder, create these folders:

- `data/` for datasets (CSV, Excel, etc.)  
- `scripts/` for R scripts you write during the semester

In RStudio: use the Files pane → New Folder.

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/new_folder_rproject.png?raw=true)

Your project should look like this:

``` text
EMS747_Project/
  EMS747_Project.Rproj
  data/
  scripts/
  bigdata_L1_github.Rmd
```

------------------------------------------------------------------------

### 1.5 Scripts

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

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/R_Script_1.png?raw=true)

------------------------------------------------------------------------

## 2. Working directory and paths

### 2.1 Check your working directory

When your project is open, run:

``` r
getwd()
```

    ## [1] "/Users/alokman/Library/CloudStorage/GoogleDrive-alokman@bu.edu/My Drive/Teaching/S26_EMS747/ClassSlides"

You should see a path ending in your project folder name.

#### Why this matters

In the next lecture, we will load datasets from your `data/` folder
using relative paths like:

``` r
read.csv("data/my_file.csv")
```

------------------------------------------------------------------------

## 3. R Markdown

- [R
  Markdown](https://rstudio.github.io/cheatsheets/html/rmarkdown.html)
  is a framework that allows you to integrate code, output, and text in
  one document.
- You can produce reports in multiple formats: HTML, PDF, Word, etc.

**Instead of copying results into a separate document, you generate the
document directly from the code.**

Why do we use R Markdown? - Combine code and text for reproducible
research. - Create interactive and visually appealing documents. - Easy
to share analyses with others.

[R Markdown Cheathseet](https://rmarkdown.rstudio.com/lesson-15.HTML)

------------------------------------------------------------------------

### 3.1 How to create a document in R Markdown

- Click on <span class="inline-button">**File**</span> \>
  <span class="inline-button">**New File**</span> \>
  <span class="inline-button">**R Markdown**</span>.
- Choose a title, author, and output format (HTML, PDF, or Word).
- Edit the template provided in the new .Rmd file.
- <mark>For our class you can use the Markdown from BB and take notes on
  that!</mark>

------------------------------------------------------------------------

### 3.2 Running vs knitting

- Run a chunk to execute code line by line  
- Knit to rebuild the entire document from top to bottom.

In RMD empty space is for text.

To run code you use code Chunks - Surround code chunks with `{r}` at the
beginning and close them with three backticks at the end. - or use the
Insert Code Chunk button. Add a chunk label and/or chunk options inside
the curly braces after r.

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/rcodechunk.png?raw=true)

------------------------------------------------------------------------

## 4. R Packages

- Packages are collections of R functions, data, and compiled code.
- Extend the functionality of base R.
- Simplifies complex tasks.
- Widely used for specialized analyses.

E.g., [`tidy`](https://tidyr.tidyverse.org/),
[`dplyr`](https://dplyr.tidyverse.org/),
[`ggplot2`](https://ggplot2.tidyverse.org/)

------------------------------------------------------------------------

### 4.1 Installing & Loading Packages

- Installation
  - Use the `install.packages()` function to install a package from
    CRAN.

``` r
install.packages("tidyr")
install.packages("dplyr")
install.packages("stringr")
```

- Loading
  - Use the `library()` function to load an installed package.

``` r
library(tidyr)
library(dplyr)
library(stringr)
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

## 5. R: Basic Grammar

### 5.1 Variable Assignment

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

### 5.2 R is case-sensitive

``` r
x <- 2

print(X)
```

    ## Error: object 'X' not found

It gave an error, why?

Cause R is <mark> case sensitive </mark>

``` r
print(x)
```

    ## [1] 2

------------------------------------------------------------------------

### 5.3 Comments

To comment - Comments are notes in the code that R ignores. Use `#` to
write comments. - R only has single line comments so if you want
multiple lines you need to repeat the `#` for each line.

``` r
variable_2 <- "Leftward Assignment" ## this is the most common used by R coders
# Other's work as well 
```

------------------------------------------------------------------------

### 5.4 R Reserved Keywords

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

## 6. Data Types

### 6.1 Numeric, Character, Logical, Factor

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

### 6.2 Dates

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

### 6.3 Lubridate Package

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
my_date + months(6)
```

    ## [1] "2023-07-01"

``` r
# Set a time zone
new_timezone <- with_tz(my_datetime, tzone = "America/New_York")
print(new_timezone)
```

    ## [1] "2023-01-01 07:34:56 EST"

------------------------------------------------------------------------

## 7. Basic Arithmetic

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

## 8. Vectors

A vector is a sequence of data elements of the same type.

------------------------------------------------------------------------

### 8.1 Creating Vectors

- Creating Vectors: Use the `c()` function.

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

#### Vectors beyond numbers

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

------------------------------------------------------------------------

### 8.2 Vector functions

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

### 8.3 Vector Sequences

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

### 8.4 Vector Indexing

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

### 8.5 Combining Vectors & Type Coercion

Combine vectors of different types:

``` r
numbers <- 1:5
text <- "Hello"
combo <- c(numbers, text)
combo
```

    ## [1] "1"     "2"     "3"     "4"     "5"     "Hello"

Type Coercion:

- R converts all elements in a vector to the same type.
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

#### Vectors class exercises

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

### 8.6 Vector Arithmetic & Recycling

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

## 9. Data Frames

A data frame is a table-like structure (multiple vectors combined into
rows and column) in R where each column can have a different data type
(numeric, character, logical, etc.). Think of it as a spreadsheet where
each column is a variable, and each row is an observation.

### 9.1 Create a dataframe

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
ages <- c(25, 30, NA)  # Fewer elements
people <- data.frame(names, ages)  # ERROR
```

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

### 9.2 Exploring/Inspecting Data Frames

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
dim(mtcars)
```

    ## [1] 32 11

``` r
str(df)  
```

    ## 'data.frame':    3 obs. of  3 variables:
    ##  $ Name     : chr  "Ayse" "Jessy" "Chris"
    ##  $ Age      : num  25 30 35
    ##  $ Professor: logi  TRUE FALSE TRUE

``` r
str(mtcars) # Structure
```

    ## 'data.frame':    32 obs. of  11 variables:
    ##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
    ##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
    ##  $ disp: num  160 160 108 258 360 ...
    ##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
    ##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
    ##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
    ##  $ qsec: num  16.5 17 18.6 19.4 17 ...
    ##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
    ##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
    ##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
    ##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

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

### 9.3 Accessing Data

Accessing Columns:

- Use the `$` operator:`df$ColumnName`.

- Use bracket notation: `df[ , "ColumnName"]`.

``` r
print(df$Name)  # Access the 'Name' column
```

    ## [1] "Ayse"  "Jessy" "Chris"

``` r
summary(df$Name)
```

    ##    Length     Class      Mode 
    ##         3 character character

``` r
print(df[, 1])
```

    ## [1] "Ayse"  "Jessy" "Chris"

``` r
print(df[, "Age"])  # Access the 'Age' column
```

    ## [1] 25 30 35

Accessing Rows:

- Use bracket notation with a row index: `df[row_number, ]`.

``` r
print(df[2, ])  # Access the first row
```

    ##    Name Age Professor
    ## 2 Jessy  30     FALSE

Accessing Specific Elements:

- Use `df[row, column]`.

``` r
print(df[2, 3])  # Access the element in the 2nd row and 3rd column
```

    ## [1] FALSE

``` r
print(df[2, "Professor"])
```

    ## [1] FALSE

------------------------------------------------------------------------

### 9.4 Adding and Removing Data

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
new_row <- data.frame(Name = "Donpeng", Age = 28, Professor = NA, Graduation = "2025")
df <- rbind(df, new_row)  # Add a new row
print(df)
```

    ##      Name Age Professor Graduation
    ## 1    Ayse  25      TRUE       2021
    ## 2   Jessy  30     FALSE       2026
    ## 3   Chris  35      TRUE       2019
    ## 4 Donpeng  28        NA       2025

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
    ## 4 Donpeng  28        NA

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
    ## 4 Donpeng  28        NA

------------------------------------------------------------------------

### 9.5 Filtering and Subsetting

Manipulating data is key to preparing it for analysis.

Common tasks:

- Filtering rows.

- Selecting columns.

- Sorting data.

- Aggregating data.

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
    ## 4 Donpeng  28        NA

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

``` r
df_subset <- df[, c(1, 2)]
```

------------------------------------------------------------------------

### 9.6 Ordering Data

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

### 9.7 Common Data Frame Functions

- `nrow(df)`: Returns the number of rows.
- `ncol(df)`: Returns the number of columns.
- `colnames(df)`: Returns column names.
- `rownames(df)`: Returns row names.
- `merge(df1, df2)`: Combines two data frames by matching rows. *We will
  learn to do this in Tidy next week*

------------------------------------------------------------------------

### 9.8 Basic Aggregations

Compute summary statistics (e.g., mean, sum) for groups of data.

**TRY:**

``` r
# Example: Calculate mean Age 
mean(df$Age)
```

    ## [1] 29.5

``` r
max(df$Age)
```

    ## [1] 35

``` r
min(df$Age)
```

    ## [1] 25

``` r
sum(df$Age)
```

    ## [1] 118

``` r
sd(df$Age)
```

    ## [1] 4.203173

**TRY: Try with other functions such as `max()`, `min()`, `sum()`, and
others**

------------------------------------------------------------------------

#### Class Exercise

1.  Create a Data Frame: Create a data frame of your favorite movies,
    including columns for Title, Year, and Rating.

2.  Filter Rows: Filter the data frame to show only movies released
    after 2010.

3.  Add a New Column: Add a column indicating whether the movie has won
    an Oscar (`TRUE` or `FALSE`).

------------------------------------------------------------------------

### Lecture 1 Cheat Sheet

| **Topic** | **Key Points / Commands** |
|----|----|
| **RStudio** | Integrated Development Environment (IDE) for R. Main panes: Console, Source, Environment, Files/Plots/Packages/Help. |
| **Console** | Runs R code line by line. Good for quick tests. Code is not saved unless written in a script or R Markdown file. |
| **Terminal** | System command line (not R). Used for OS-level commands (e.g., `ls`, `dir`). We will rarely use it. |
| **RStudio Projects** | Organize files for one analysis. Automatically sets working directory. Always open work via the `.Rproj` file. |
| **Project Folder Structure** | Recommended folders: `data/` (datasets), `scripts/` (R scripts), `.Rmd` files for notes/analysis. |
| **Scripts (`.R`)** | Plain text files for writing and saving R code. Run selected lines with `Cmd/Ctrl + Enter`. |
| **Working Directory** | Check with `getwd()`. Should point to your project folder. Enables relative paths like `"data/file.csv"`. |
| **R Markdown (`.Rmd`)** | Combines text, code, and output in one reproducible document. Used for notes, assignments, and reports. |
| **Running vs Knitting** | Run chunks to execute code interactively. Knit rebuilds the entire document from top to bottom in a clean session. |
| **Code Chunks** | R code lives inside chunks: `{r} code` . Output appears below the chunk. |
| **R Packages** | Extend R functionality. Install once with `install.packages()`, load every session with `library()`. |
| **Variable Assignment** | `<-` (preferred), `=` (allowed), `->` (rare). R is case-sensitive. |
| **Comments** | Use `#` for comments. R only supports single-line comments. |
| **Reserved Keywords** | Cannot be used as variable names (e.g., `if`, `for`, `TRUE`, `FALSE`, `NA`, `NULL`, `Inf`). |
| **Basic Data Types** | Numeric, Character, Logical, Factor. Check with `typeof()`. |
| **Dates** | `Date`, `POSIXct`, `POSIXlt`. Use `as.Date()`, `Sys.Date()`, `Sys.time()`. |
| **Lubridate** | Easier date handling: `ymd()`, `mdy()`, `year()`, `month()`, `day()`, `+ days()`, `+ months()`. |
| **Basic Arithmetic** | `+`, `-`, `*`, `/`, `^`. Works on numbers and vectors. |
| **Vectors** | One-dimensional objects with same data type. Create with `c()`. |
| **Vector Indexing** | Use `[]`. Select (`x[1:3]`), exclude (`x[-2]`), multiple indices (`x[c(1,3)]`). |
| **Vector Functions** | `length()`, sequences with `:`, recycling in vector arithmetic. |
| **Type Coercion** | Combining types converts to one type: Character \> Numeric \> Logical. |
| **Data Frames** | Table-like structure with columns of equal length. Create with `data.frame()`. |
| **Inspecting Data Frames** | `head()`, `tail()`, `str()`, `summary()`, `dim()`, `nrow()`, `ncol()`. |
| **Accessing Data** | Columns: `df$col`, `df[, "col"]`. Rows: `df[row, ]`. Elements: `df[row, col]`. |
| **Adding/Removing Data** | Add columns with `$`. Add rows with `rbind()`. Remove with `NULL` or negative indexing. |
| **Filtering & Subsetting** | Use logical conditions: `df[df$Age > 25, ]`. Select columns by name or index. |
| **Sorting Data** | `order(df$col)` for ascending, `order(-df$col)` for descending. |
| **Basic Aggregations** | `mean()`, `max()`, `min()`, `sum()`, `sd()` on vectors or data frame columns. |
