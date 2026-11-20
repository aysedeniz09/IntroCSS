Why computational social science?
================
Dr. Ayse D. Lokmanoglu
Lecture 1, January 25, 2027

# R Exercises

## How today works

We go back and forth: I show you some code, then **you try it yourself
in the Activity** right after it. Every section has an Activity.

- These notes are on GitHub so you can read them any time.
- In class, work in the script **`bigdata_L1.R`** (download it from the
  Session 1 page on the course website). It has the same code as these
  notes, plus empty space under each Activity for your answers.
- Work with the people next to you. If you’re stuck, raise your hand.
  Being stuck is normal on day one.

<mark>Go slowly. Run every line yourself, even the ones I already ran.
Typing and running the code is how you learn it.</mark>

------------------------------------------------------------------------

## Lecture 1 Table of Contents

| Section | Topic                                   |
|---------|-----------------------------------------|
| 1       | A tour of RStudio                       |
| 1.1     | The Console                             |
| 1.2     | The Terminal                            |
| 1.3     | Scripts                                 |
| 2       | Projects and folders                    |
| 2.1     | RStudio Projects                        |
| 2.2     | Organize your project folder            |
| 2.3     | Your working directory                  |
| 3       | R Packages                              |
| 4       | R Basic Grammar                         |
| 4.1     | Storing things: assignment              |
| 4.2     | Case sensitivity                        |
| 4.3     | Comments                                |
| 4.4     | Names you can and can’t use             |
| 5       | Data Types                              |
| 5.1     | Numeric, Character, Logical, Factor     |
| 5.2     | Asking TRUE/FALSE questions             |
| 6       | Basic Arithmetic                        |
| 7       | Vectors                                 |
| 7.1     | Creating vectors                        |
| 7.2     | Getting items out: indexing             |
| 7.3     | Vector functions                        |
| 7.4     | Sequences                               |
| 7.5     | Combining vectors and type coercion     |
| 7.6     | Vector arithmetic and recycling         |
| 8       | Data Frames: base R and tidy            |
| 8.1     | Creating a data frame                   |
| 8.2     | Looking at a data frame                 |
| 8.3     | Base R vs. tidy: the same task two ways |
| 8.4     | The pipe `\|>`                          |
| 9       | Your first real dataset                 |
| 9.1     | Loading a CSV file                      |
| 9.2     | Meet the data                           |
| 9.3     | Your first questions                    |
| 10      | Put it together                         |

------------------------------------------------------------------------

## 1. A tour of RStudio

RStudio is an **integrated development environment (IDE)** for R, a
programming language widely used for data analysis, statistical
modeling, and visualization.

RStudio has four main panes:

| Pane                                               | What it does                                             |
|----------------------------------------------------|----------------------------------------------------------|
| **Source** (top left)                              | Where your scripts open. You write code here.            |
| **Console** (bottom left)                          | Where R runs code and shows you the answer.              |
| **Environment** (top right)                        | Everything you’ve stored so far.                         |
| **Files / Plots / Packages / Help** (bottom right) | Your folders, your plots, your packages, and help pages. |

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rconsole.jpg?raw=true)

------------------------------------------------------------------------

### 1.1 The Console

The Console is where you directly interact with R. You can type R
commands, hit Enter, and see the immediate results.

Key Features:

- Executes code line-by-line.
- Useful for quick calculations or testing small snippets of code.
- Does not save commands. Once you close RStudio, the history of
  commands in the Console is gone unless explicitly saved.

***TRY: write `2 + 2` in the console and press Enter.***

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rconsole2.png?raw=true)

What does `[1]` mean in the answer? It means “here is the first item of
the answer.” Ignore it for now. It will make sense in Section 7.

------------------------------------------------------------------------

### 1.2 The Terminal

The Terminal is separate from the Console and provides access to your
computer’s command-line interface (CLI).

- The Console is for **R**.
- The Terminal is for **your computer** (for example, Git or managing
  files).

<mark>We will not use Terminal most of the time</mark>

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rterminal.png?raw=true)

------------------------------------------------------------------------

### 1.3 Scripts

A script is a text file where you write and save R code for future use.

- Scripts let you document your work, making it reproducible and
  shareable.
- You can save time by re-running pre-written code instead of typing
  commands repeatedly.

How to Create and Use a Script:

- Click on <span class="inline-button">**File → New File → R
  Script**</span>.
- Write R code in the script editor. E.g.

``` r
x <- 5
y <- 10
z <- x + y
print(z)
```

    ## [1] 15

- Put your cursor on a line (or highlight several lines) and press
  <span class="inline-button">**Ctrl+Enter**</span> (Windows/Linux) or
  <span class="inline-button">**Cmd+Enter**</span> (Mac) to run it in
  the Console.
- Save your script often: <span class="inline-button">**File →
  Save**</span>.

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/R_Script_1.png?raw=true)

**Two helpful tricks:**

- If the Console shows a `+` instead of `>`, R thinks your code isn’t
  finished (usually a missing `)` or `"`). Click in the Console and
  press **Esc**.
- Lines that start with `#` are comments. R skips them. More on this in
  Section 4.3.

------------------------------------------------------------------------

#### Activity 1

1.  Find the four panes in your RStudio. Which one is the Console?
2.  In the **Console**, calculate `2 + 2`, then `10 / 4`.
3.  Open a new R Script. Type `3 * 5` in it and run it with Ctrl+Enter /
    Cmd+Enter. Where did the answer show up?
4.  Save the script as `practice.R`. Where did RStudio save it?

``` r
# Your code here
```

------------------------------------------------------------------------

## 2. Projects and folders

### 2.1 RStudio Projects

An RStudio Project is a way to organize your work by grouping files,
data, and scripts for a specific task or analysis.

Why Use Projects?

- Keeps your workspace clean and focused.
- Automatically sets the working directory to the project folder.
- Ensures reproducibility by keeping everything needed for a project in
  one place.

How to Create a Project:

1.  Click on <span class="inline-button">**File → New
    Project….**</span>.
2.  Choose **New Directory → New Project**.
3.  Give it a clear name (example: EMS747_Project)
4.  Choose a location you can easily find again (like your Desktop or
    Documents)

<mark>When you create a project, RStudio makes a file ending in
`.Rproj`. Always open your work by clicking that `.Rproj` file.</mark>

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/Rproject.jpg?raw=true)

------------------------------------------------------------------------

### 2.2 Organize your project folder

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
  bigdata_L1.R
```

------------------------------------------------------------------------

### 2.3 Your working directory

The **working directory** is the folder R is looking at right now. When
your project is open, it should be your project folder. Check it:

``` r
getwd()
```

In words: “**get** the **w**orking **d**irectory.”

You should see a path ending in your project folder name.

#### Why this matters

At the end of today (Section 9), we load a dataset from your `data/`
folder using a short path like:

``` r
read_csv("data/my_file.csv")
```

This only works if R is looking at your project folder.

------------------------------------------------------------------------

#### Activity 2

1.  Create a project called **EMS747_Class_Exercises**. Notice the
    `.Rproj` file RStudio makes.
2.  Inside it, make two folders: `data` and `scripts`.
3.  Download `bigdata_L1.R` from the Session 1 page on the course
    website, move it into your project folder, and open it from the
    Files pane.
4.  Run `getwd()`. Does the path end in **EMS747_Class_Exercises**?
5.  Close RStudio. Reopen your project by double-clicking the `.Rproj`
    file. Run `getwd()` again. Is it the same?

``` r
# Your code here
```

------------------------------------------------------------------------

## 3. R Packages

- Packages are collections of R functions, data, and compiled code.
- They extend what base R can do.
- Someone else wrote them, so you don’t have to.

Think of it like a book:

- `install.packages()` **buys the book** and puts it on your shelf. You
  do this **once** per computer.
- `library()` **takes the book off the shelf** so you can use it. You do
  this **every time** you open R.

In this class we use the **tidyverse**. It’s a bundle of packages that
work well together, including [`dplyr`](https://dplyr.tidyverse.org/),
[`tidyr`](https://tidyr.tidyverse.org/),
[`readr`](https://readr.tidyverse.org/),
[`stringr`](https://stringr.tidyverse.org/),
[`ggplot2`](https://ggplot2.tidyverse.org/), and
[`lubridate`](https://lubridate.tidyverse.org/).

**Installation** (once):

``` r
install.packages("tidyverse")
```

**Loading** (every time):

``` r
library(tidyverse)
```

Notice: the name is in quotes in `install.packages("tidyverse")` but not
in `library(tidyverse)`.

When you load it, R prints a list of the packages it turned on. That’s a
message, not an error.

Check the package documentation with `?`

``` r
?dplyr
```

***N.B. Packages only need to be installed once but must be loaded in
each session `library()`. Keep packages updated with
`update.packages()`***

------------------------------------------------------------------------

#### Activity 3

1.  Install the tidyverse (this can take a few minutes, that’s normal).
2.  Load it with `library()`. What does R print?
3.  Run `?dplyr`. Where did the help page open?
4.  Run `library(tidyvers)` (misspelled on purpose). What error do you
    get? What does it mean?

``` r
# Your code here
```

------------------------------------------------------------------------

## 4. R: Basic Grammar

### 4.1 Storing things: assignment

Doing math is nice, but the answers disappear. To **keep** something, we
give it a name. This is called **assignment**.

``` r
apple <- 5
apple
```

    ## [1] 5

In words: “**apple gets 5**.”

What just happened?

- R made a box, wrote “apple” on the label, and put the number 5 inside
  it.
- The **left side** (`apple`) is a name you make up.
- The **arrow** `<-` means “store whatever is on the right into the name
  on the left.” Type it as `<` followed by `-`. Shortcut: **Alt + -**
  (Windows) or **Option + -** (Mac).
- Storing is quiet. Nothing prints until you type the name.
- Look at your **Environment** pane: `apple` is there now.

There are three ways to assign:

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

If you store something new under a name that already exists, the old
value is **replaced**. R does not warn you.

``` r
apple <- 10
apple
```

    ## [1] 10

You can use stored values in math, and store the result in a new box:

``` r
banana <- 3
fruit_total <- apple + banana
fruit_total
```

    ## [1] 13

In words: “fruit_total gets apple plus banana.”

------------------------------------------------------------------------

### 4.2 R is case-sensitive

``` r
x <- 2

print(X)
```

    ## Error in eval(expr, envir, enclos): object 'X' not found

It gave an error, why?

Cause R is <mark> case sensitive </mark>. `x` and `X` are two different
names.

``` r
print(x)
```

    ## [1] 2

<mark>“object ‘X’ not found” is the most common error you will see.
Check your spelling and capital letters first.</mark>

------------------------------------------------------------------------

#### Activity 4.1

1.  Create a box called `coffees` that stores 2, and a box called `teas`
    that stores 3.
2.  Create `drinks` that stores `coffees + teas`. Print it.
3.  Now change `teas` to 10. Print `drinks` again. Did it change? Why
    not? Write the line that would update it.
4.  Store the name of your favorite drink in a box called `fav_drink`
    (text goes in quotes). Then type `Fav_drink`. What happens, and why?

``` r
# Your code here
```

------------------------------------------------------------------------

### 4.3 Comments

Comments are notes in the code that R ignores. Use `#` to write
comments.

- R only has single line comments, so if you want multiple lines you
  need to repeat the `#` for each line.
- A comment can go on its own line or at the end of a line of code.

``` r
variable_2 <- "Leftward Assignment" ## this is the most common used by R coders
# Other's work as well
```

------------------------------------------------------------------------

### 4.4 Names you can and can’t use

**Rules for names:**

- Start with a letter: `candy1` works, `1candy` does not.
- No spaces. Use underscores: `fruit_total`, not `fruit total`.
- Be descriptive: `study_hours` is better than `sh`.

**Reserved keywords:** these words already mean something to R, so you
cannot use them as names.

| Words              | Description                             |
|--------------------|-----------------------------------------|
| if, else           | Used for conditional execution of code. |
| for, while, repeat | Loops.                                  |
| function           | Defines a function.                     |
| TRUE, FALSE        | Logical values (yes/no).                |
| NULL               | The absence of a value.                 |
| NA                 | Missing data (“Not Available”).         |
| Inf                | Infinity (e.g., division by zero).      |
| NaN                | “Not a Number” (e.g., `0 / 0`).         |

------------------------------------------------------------------------

#### Activity 4.2

1.  Above your code from Activity 4.1, add a comment that says what the
    code does.
2.  Which of these names work? **Guess first**, then try storing the
    number 1 in each one.
    - `my_score`
    - `2nd_score`
    - `my score`
    - `TRUE`
    - `score2`
3.  Run `ls()`. It lists every box you’ve stored. Compare it to your
    Environment pane.

``` r
# Your code here
```

------------------------------------------------------------------------

## 5. Data Types

### 5.1 Numeric, Character, Logical, Factor

Every value in R has a **type**.

- Numeric: Numbers
  - e.g., `3.14`, `42`
- Character: Text or strings, **always in quotes**
  - e.g., `"Hello"`, `"R"`
- Logical: yes/no values
  - `TRUE`, `FALSE`
- Factor: Categorical data
  - e.g., `"Masters"`, `"PhD"` (we’ll use these later in the semester)

You can use `typeof()` to see what type of data it is

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

**What does `typeof()` do?** It asks R: “how are you storing this value
inside the computer?” Every value has exactly one storage type.

**Question? What is double?**

R has two ways to store numbers:

| `typeof()` says | What it is                   | Example            | How you make it        |
|-----------------|------------------------------|--------------------|------------------------|
| `"double"`      | Any number, decimals allowed | `25`, `3.14`, `-2` | Just type the number   |
| `"integer"`     | Whole numbers only           | `25L`, `1:5`       | Add an `L`, or use `:` |

- **“Double” is short for “double precision.”** R stores each number
  with about 15-16 digits of accuracy. The name comes from computer
  history: it uses twice the memory of an older “single precision”
  format. You don’t need to know more than that.
- **Every number you type is a double**, even a whole number like `25`.
  That’s why `typeof(age)` above says `"double"`, not `"integer"`.
- **Integers show up on their own** when you make a sequence with `:`
  (Section 7.4). Don’t be surprised when you see `"integer"` there.
- **For your work, both just mean “number.”** Math works the same on
  both. To ask “is this a number?”, use `is.numeric()`:

``` r
typeof(25)       # a number you type: double
```

    ## [1] "double"

``` r
typeof(25L)      # the L makes it an integer
```

    ## [1] "integer"

``` r
typeof(1:5)      # a sequence made with : is integer
```

    ## [1] "integer"

``` r
is.numeric(25)   # is it a number? yes
```

    ## [1] TRUE

``` r
is.numeric(1:5)  # is it a number? yes
```

    ## [1] TRUE

**You will see these types again, shortened.** When you print a tibble
or use `glimpse()` (Sections 8 and 9), R labels each column with a short
version of its type:

| `typeof()`    | Short label in a tibble | Means          |
|---------------|-------------------------|----------------|
| `"double"`    | `<dbl>`                 | number         |
| `"integer"`   | `<int>`                 | whole number   |
| `"character"` | `<chr>`                 | text           |
| `"logical"`   | `<lgl>`                 | `TRUE`/`FALSE` |

So when you see `<dbl>` next to a column, it means “this column is
numbers.”

**Quotes matter.** `5` is a number. `"5"` is text that happens to look
like a number. You can’t do math with text:

``` r
"5" + 1   # this gives an error ON PURPOSE
```

    ## Error in "5" + 1: non-numeric argument to binary operator

``` r
5 + 1
```

    ## [1] 6

------------------------------------------------------------------------

#### Activity 5.1

1.  Check the type of `"Boston"`, `84.2`, and `FALSE`. **Guess first.**
2.  Check the type of `"84.2"`. Why is it different from `84.2`?
3.  **Guess first:** what does `typeof(10)` give? And `typeof(10L)`? And
    `typeof(1:10)`? Run them to check.
4.  Is `10L` a number? Check with `is.numeric()`.
5.  Fix the error: `"10" + 5`

``` r
# Your code here
```

------------------------------------------------------------------------

### 5.2 Asking TRUE/FALSE questions

R answers yes/no questions with `TRUE` or `FALSE`. We’ll use this **all
semester** to keep only the rows we want.

| Symbol    | Question                            |
|-----------|-------------------------------------|
| `==`      | is equal to?                        |
| `!=`      | is not equal to?                    |
| `>` `<`   | is greater / less than?             |
| `>=` `<=` | is greater / less than or equal to? |

``` r
age > 18           # "is age greater than 18?"
```

    ## [1] TRUE

``` r
age == 30          # "is age equal to 30?"
```

    ## [1] FALSE

``` r
age != 30          # "is age NOT equal to 30?"
```

    ## [1] TRUE

``` r
"Boston" == "boston"   # capital letters count!
```

    ## [1] FALSE

<mark>`<-` STORES. `==` ASKS.</mark> `age <- 30` puts 30 in the box.
`age == 30` asks “is there a 30 in the box?”

One handy trick: R treats `TRUE` as 1 and `FALSE` as 0. Remember this,
it comes back in Section 7.

``` r
TRUE + TRUE + FALSE
```

    ## [1] 2

------------------------------------------------------------------------

#### Activity 5.2

1.  **Guess first** whether each is `TRUE` or `FALSE`. Then run them.
    - `10 > 3`
    - `5 == 5.0`
    - `"tea" == "Tea"`
    - `7 != 7`
    - `76.7 >= 80`
2.  Store your age in a box called `my_age`. Write a question that asks
    “is my_age at least 21?”
3.  What does `TRUE + TRUE + TRUE + FALSE` give you? Why?

``` r
# Your code here
```

------------------------------------------------------------------------

## 6. Basic Arithmetic

Operators in R:

| Operator | Meaning                |
|----------|------------------------|
| `+`      | Addition               |
| `-`      | Subtraction            |
| `*`      | Multiplication         |
| `/`      | Division               |
| `^`      | Exponentiation (power) |

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

R follows the usual math order: powers first, then `*` and `/`, then `+`
and `-`. Use parentheses to be safe:

``` r
2 + 3 * 4     # 3 * 4 first, then + 2
```

    ## [1] 14

``` r
(2 + 3) * 4   # 2 + 3 first, then * 4
```

    ## [1] 20

------------------------------------------------------------------------

#### Activity 6

1.  How many minutes are in a week? (7 days x 24 hours x 60 minutes)
2.  Store the number of hours you sleep per night in `sleep`. How many
    hours do you sleep in a year?
3.  **Guess first**, then run: `10 - 2 * 3` and `(10 - 2) * 3`.

``` r
# Your code here
```

------------------------------------------------------------------------

## 7. Vectors

A **vector** is a list of values of the **same type**, stored under one
name. Almost everything in R is built from vectors. Every column in a
dataset is a vector.

------------------------------------------------------------------------

### 7.1 Creating Vectors

- Creating Vectors: Use the `c()` function. `c` stands for **combine**.

**TRY**

``` r
numbers <- c(1, 2, 3, 4, 5)  # Numeric vector
names <- c("Alice", "Bob", "Charlie")  # Character vector
is_student <- c(TRUE, FALSE, TRUE)  # Logical vector
```

In words: “numbers gets the combination of 1, 2, 3, 4, and 5.”

**TRY what types they are**

``` r
typeof(numbers)
```

    ## [1] "double"

``` r
typeof(names)
```

    ## [1] "character"

``` r
typeof(is_student)
```

    ## [1] "logical"

Vectors can hold text too:

``` r
fruits <- c("Banana", "Mango", "Strawberry", "Grapes")  # ADD YOUR FAVORITES!
fruits
```

    ## [1] "Banana"     "Mango"      "Strawberry" "Grapes"

------------------------------------------------------------------------

### 7.2 Getting items out: indexing

You can access an element in a vector with square brackets `[]`.
`fruits[3]` means “the 3rd item of fruits.”

``` r
fruits[3]  # Third item
```

    ## [1] "Strawberry"

``` r
fruits[c(1, 4)]  # First and fourth items
```

    ## [1] "Banana" "Grapes"

``` r
fruits[2:3]  # Items 2 through 3
```

    ## [1] "Mango"      "Strawberry"

``` r
fruits[-2]  # Everything EXCEPT the second item
```

    ## [1] "Banana"     "Strawberry" "Grapes"

Now `[1]` in your answers makes sense: it tells you the position of the
first item on that line.

Practice:

- How do you select only items 1, 3, and 5?
- How do you exclude items 2 and 4?

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

Why is there an `NA` above? `fruits` only has 4 items, so there is no
item 5. R gives `NA`, which means “missing.”

------------------------------------------------------------------------

#### Activity 7.1

1.  Create a vector called `hobbies` with 4 of your hobbies.
2.  Get the first item. Then the first two items.
3.  Get everything except the last item.
4.  Create a vector called `my_numbers` with 5 numbers. What type is it?

``` r
# Your code here
```

------------------------------------------------------------------------

### 7.3 Vector functions

**Functions** are R’s built-in tools. The pattern is always:

``` r
function_name(what_you_give_it)
```

``` r
study_hours <- c(2, 5, 3, 8, 4)

length(study_hours)   # how many items
```

    ## [1] 5

``` r
mean(study_hours)     # average
```

    ## [1] 4.4

``` r
max(study_hours)      # biggest
```

    ## [1] 8

``` r
min(study_hours)      # smallest
```

    ## [1] 2

``` r
sum(study_hours)      # add them all up
```

    ## [1] 22

Some functions take more than one input, separated by commas. `round()`
takes a number and how many decimal places you want:

``` r
round(mean(study_hours), 1)
```

    ## [1] 4.4

Read nested functions from the **inside out**: “take the mean of
study_hours, then round it to 1 decimal.”

**Asking a question of a whole vector** gives one `TRUE`/`FALSE` per
item:

``` r
study_hours > 4
```

    ## [1] FALSE  TRUE FALSE  TRUE FALSE

Because `TRUE` = 1 and `FALSE` = 0 (Section 5.2), `sum()` **counts** the
TRUEs and `mean()` gives the **proportion**:

``` r
sum(study_hours > 4)    # how many days were more than 4 hours?
```

    ## [1] 2

``` r
mean(study_hours > 4)   # what proportion of days?
```

    ## [1] 0.4

Some functions don’t work on every type:

``` r
# Vector properties
length(fruits)       # Number of elements
```

    ## [1] 4

``` r
fruits * 2           # Produces an ERROR
```

    ## Error in fruits * 2: non-numeric argument to binary operator

Why does `fruits * 2` produce an error?

------------------------------------------------------------------------

### 7.4 Vector Sequences

We can create sequences with `:`. In words, `11:20` means “every whole
number from 11 to 20.”

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

#### Activity 7.2

Here are the hours of sleep one student got each night for a week:

``` r
sleep <- c(7, 6.5, 5, 8, 7.5, 9, 6)
```

1.  Store the `sleep` vector.
2.  What is the average? Round it to 1 decimal.
3.  What were the most and least hours of sleep?
4.  How many nights did they sleep less than 7 hours? (Hint: `sum()`)
5.  What was the sleep on night 3? On nights 6 and 7?
6.  Make a vector of the numbers 1 to 100 using `:`. What is their sum?

``` r
# Your code here
```

------------------------------------------------------------------------

### 7.5 Combining Vectors & Type Coercion

Combine vectors of different types:

``` r
numbers <- 1:5
text <- "Hello"
combo <- c(numbers, text)
combo
```

    ## [1] "1"     "2"     "3"     "4"     "5"     "Hello"

Notice the quotes: every number became text!

Type Coercion:

- A vector can only hold **one** type, so R converts everything to the
  same type.
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

------------------------------------------------------------------------

### 7.6 Vector Arithmetic & Recycling

We can also do arithmetic with vectors! R does it item by item:

``` r
c(1, 2, 3) + c(10, 20, 30)
```

    ## [1] 11 22 33

In words: 1 + 10, 2 + 20, 3 + 30.

What will happen if we use vectors of different sizes?

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

  - `(20 + 25), (21 + 26), (22 + 27), (23 + 28), (24 + 29), (20 + 30)` =
    45, 47, 49, 51, 53, 50

R gives you a **warning** when this happens. Recycling is usually a
mistake, so check your lengths!

------------------------------------------------------------------------

#### Activity 7.3

1.  Combine `c(1, 2, 3)` with `c("One", "Two", "Three")`. What type is
    the result? Why?
2.  What happens if you combine `c(1, 2, 3)` with `TRUE`? What did
    `TRUE` become?
3.  Here are prices in dollars: `prices <- c(4.5, 3, 6.25)`. Convert
    them to cents by multiplying the whole vector by 100.
4.  **Guess first**: what does `c(1, 2, 3, 4) + c(10, 20)` give? Run it.

``` r
# Your code here
```

------------------------------------------------------------------------

## 8. Data Frames: base R and tidy

A **data frame** is a table where each **column** is a variable (a
vector) and each **row** is an observation. Think of it as a
spreadsheet.

- Each column can be a different type (numeric, character, logical).
- <mark>Every column must have the same length!!</mark>

### 8.1 Create a data frame

There are two ways to make one. Base R uses `data.frame()`:

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

The tidyverse uses `tibble()`. It works the same way:

``` r
people <- tibble(
  Name = c("Ayse", "Jessy", "Chris"),
  Age = c(25, 30, 35),
  Professor = c(TRUE, FALSE, TRUE)
)

people
```

    ## # A tibble: 3 x 3
    ##   Name    Age Professor
    ##   <chr> <dbl> <lgl>    
    ## 1 Ayse     25 TRUE     
    ## 2 Jessy    30 FALSE    
    ## 3 Chris    35 TRUE

A **tibble** is a tidyverse data frame. It prints more neatly: it tells
you the size (`3 x 3`) and the type of each column (`<chr>`, `<dbl>`,
`<lgl>`). <mark>In this class we use tibbles.</mark>

**Vectors in a data frame must have the same length:**

``` r
# Mismatched lengths will fail
tibble(
  Name = c("Ayse", "Jessy", "Chris"),
  Age = c(25, 30)   # only 2 ages for 3 names
)
```

    ## Error in `tibble()`:
    ## ! Tibble columns must have compatible sizes.
    ## * Size 3: Existing data.
    ## * Size 2: Column `Age`.
    ## i Only values of size one are recycled.

You can stack two tibbles with the same columns using `bind_rows()`:

``` r
new_people <- tibble(
  Name = c("Donpeng"),
  Age = c(28),
  Professor = c(FALSE)
)

all_people <- bind_rows(people, new_people)
all_people
```

    ## # A tibble: 4 x 3
    ##   Name      Age Professor
    ##   <chr>   <dbl> <lgl>    
    ## 1 Ayse       25 TRUE     
    ## 2 Jessy      30 FALSE    
    ## 3 Chris      35 TRUE     
    ## 4 Donpeng    28 FALSE

In words: “all_people gets people with new_people stacked underneath.”

------------------------------------------------------------------------

#### Activity 8.1

1.  Create a tibble called `us_df` with two columns:
    - `city = c("Boston", "Chicago", "Seattle")`
    - `population = c(700000, 2700000, 750000)`
2.  Create a tibble called `asia_df`:
    - `city = c("Beijing", "Shanghai", "Taipei", "Kaohsiung")`
    - `population = c(21540000, 24280000, 2640000, 2775000)`
3.  Combine them into one tibble called `all_cities` with `bind_rows()`.
    How many rows does it have?
4.  Make a tibble of 3 of your own favorite cities and their estimated
    populations.

``` r
# Your code here
```

------------------------------------------------------------------------

### 8.2 Looking at a data frame

The first tools to use on **any** new dataset. R has a built-in dataset
of cars called `mtcars`, so let’s practice on it:

| Function           | What it tells you                                       |
|--------------------|---------------------------------------------------------|
| `head()`           | The first 6 rows                                        |
| `tail()`           | The last 6 rows                                         |
| `nrow()`, `ncol()` | Number of rows, number of columns                       |
| `names()`          | The column names                                        |
| `glimpse()`        | Every column, its type, and the first few values (tidy) |
| `summary()`        | Quick statistics for every column                       |
| `View()`           | Opens it like a spreadsheet (capital V!)                |

``` r
head(mtcars)    # First 6 rows
```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

``` r
nrow(mtcars)    # Number of rows
```

    ## [1] 32

``` r
ncol(mtcars)    # Number of columns
```

    ## [1] 11

``` r
names(mtcars)   # Column names
```

    ##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
    ## [11] "carb"

``` r
glimpse(mtcars)
```

    ## Rows: 32
    ## Columns: 11
    ## $ mpg  <dbl> 21.0, 21.0, 22.8, 21.4, 18.7, 18.1, 14.3, 24.4, 22.8, 19.2, 17.8,~
    ## $ cyl  <dbl> 6, 6, 4, 6, 8, 6, 8, 4, 4, 6, 6, 8, 8, 8, 8, 8, 8, 4, 4, 4, 4, 8,~
    ## $ disp <dbl> 160.0, 160.0, 108.0, 258.0, 360.0, 225.0, 360.0, 146.7, 140.8, 16~
    ## $ hp   <dbl> 110, 110, 93, 110, 175, 105, 245, 62, 95, 123, 123, 180, 180, 180~
    ## $ drat <dbl> 3.90, 3.90, 3.85, 3.08, 3.15, 2.76, 3.21, 3.69, 3.92, 3.92, 3.92,~
    ## $ wt   <dbl> 2.620, 2.875, 2.320, 3.215, 3.440, 3.460, 3.570, 3.190, 3.150, 3.~
    ## $ qsec <dbl> 16.46, 17.02, 18.61, 19.44, 17.02, 20.22, 15.84, 20.00, 22.90, 18~
    ## $ vs   <dbl> 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,~
    ## $ am   <dbl> 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0,~
    ## $ gear <dbl> 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 4, 4, 4, 3, 3,~
    ## $ carb <dbl> 4, 4, 1, 1, 2, 1, 4, 2, 2, 4, 4, 3, 3, 3, 4, 4, 4, 1, 2, 1, 1, 2,~

`glimpse()` is the tidyverse version of base R’s `str()`. Both show the
structure; `glimpse()` is easier to read.

``` r
summary(people)
```

    ##      Name                Age       Professor      
    ##  Length:3           Min.   :25.0   Mode :logical  
    ##  Class :character   1st Qu.:27.5   FALSE:1        
    ##  Mode  :character   Median :30.0   TRUE :2        
    ##                     Mean   :30.0                  
    ##                     3rd Qu.:32.5                  
    ##                     Max.   :35.0

------------------------------------------------------------------------

#### Activity 8.2

1.  How many rows and columns does `mtcars` have?
2.  Use `glimpse()` on `all_cities` from Activity 8.1. What type is each
    column?
3.  Run `View(mtcars)`. Click a column name to sort it. Which car has
    the highest `mpg`?
4.  Run `summary(all_cities)`. What is the largest population?

``` r
# Your code here
```

------------------------------------------------------------------------

### 8.3 Base R vs. tidy: the same task two ways

<mark>**Reminder:** R has two “dialects.” **Base R** is what comes with
R. The **tidyverse** is a set of packages with a cleaner, more readable
style. You will see **both** online, in old code, and from ChatGPT. In
this class we write **tidy** code, but you should be able to recognize
base R when you see it.</mark>

Here is the same task in both dialects. Look for the patterns:

| Task                | Base R                           | Tidy                                            |
|---------------------|----------------------------------|-------------------------------------------------|
| Get one column      | `df$Age`                         | `people \|> pull(Age)`                          |
| Pick columns        | `df[, c("Name", "Age")]`         | `people \|> select(Name, Age)`                  |
| Keep rows           | `df[df$Age > 25, ]`              | `people \|> filter(Age > 25)`                   |
| Sort                | `df[order(df$Age), ]`            | `people \|> arrange(Age)`                       |
| Sort, biggest first | `df[order(-df$Age), ]`           | `people \|> arrange(desc(Age))`                 |
| Add a column        | `df$Grad <- c(2021, 2026, 2019)` | `people \|> mutate(Grad = c(2021, 2026, 2019))` |
| Average of a column | `mean(df$Age)`                   | `people \|> summarise(mean_age = mean(Age))`    |

**Keep rows where Age is over 25:**

``` r
# Base R
df[df$Age > 25, ]
```

    ##    Name Age Professor
    ## 2 Jessy  30     FALSE
    ## 3 Chris  35      TRUE

``` r
# Tidy
people |>
  filter(Age > 25)
```

    ## # A tibble: 2 x 3
    ##   Name    Age Professor
    ##   <chr> <dbl> <lgl>    
    ## 1 Jessy    30 FALSE    
    ## 2 Chris    35 TRUE

In words (tidy): “start with people, **and then** keep the rows where
Age is greater than 25.”

Remember `>` from Section 5.2? `filter()` keeps every row where the
question is `TRUE`.

**Pick columns:**

``` r
# Base R
df[, c("Name", "Age")]
```

    ##    Name Age
    ## 1  Ayse  25
    ## 2 Jessy  30
    ## 3 Chris  35

``` r
# Tidy
people |>
  select(Name, Age)
```

    ## # A tibble: 3 x 2
    ##   Name    Age
    ##   <chr> <dbl>
    ## 1 Ayse     25
    ## 2 Jessy    30
    ## 3 Chris    35

**Sort by Age, oldest first:**

``` r
# Base R
df[order(-df$Age), ]
```

    ##    Name Age Professor
    ## 3 Chris  35      TRUE
    ## 2 Jessy  30     FALSE
    ## 1  Ayse  25      TRUE

``` r
# Tidy
people |>
  arrange(desc(Age))
```

    ## # A tibble: 3 x 3
    ##   Name    Age Professor
    ##   <chr> <dbl> <lgl>    
    ## 1 Chris    35 TRUE     
    ## 2 Jessy    30 FALSE    
    ## 3 Ayse     25 TRUE

**Add a column:**

``` r
people <- people |>
  mutate(Graduation = c(2021, 2026, 2019))

people
```

    ## # A tibble: 3 x 4
    ##   Name    Age Professor Graduation
    ##   <chr> <dbl> <lgl>          <dbl>
    ## 1 Ayse     25 TRUE            2021
    ## 2 Jessy    30 FALSE           2026
    ## 3 Chris    35 TRUE            2019

In words: “people gets people, **and then** a new column called
Graduation.” Without `people <-` at the start, the new column would
print but not be saved.

**Average age:**

``` r
# Base R
mean(df$Age)
```

    ## [1] 30

``` r
# Tidy
people |>
  summarise(mean_age = mean(Age))
```

    ## # A tibble: 1 x 1
    ##   mean_age
    ##      <dbl>
    ## 1       30

<mark>You don’t need to memorize these verbs today.</mark> Next class we
learn `filter()`, `select()`, `mutate()`, `arrange()`, and `summarise()`
one at a time, slowly, with real data.

------------------------------------------------------------------------

#### Activity 8.3

Use the `people` tibble.

1.  Keep only the professors (hint: `filter(Professor == TRUE)`).
2.  Select only the `Name` column.
3.  Sort by `Name` in alphabetical order (hint: `arrange()`).
4.  **Read the base R:** what does `df[df$Age < 30, ]` do? Write the
    tidy version.

``` r
# Your code here
```

------------------------------------------------------------------------

### 8.4 The pipe `|>`

The `|>` symbol is called the **pipe**. Read it as **“and then.”** It
takes what’s on the left and hands it to the function on the right.

The pipe lets you chain steps, top to bottom, like a recipe:

``` r
people |>
  filter(Age > 25) |>
  arrange(desc(Age))
```

    ## # A tibble: 2 x 4
    ##   Name    Age Professor Graduation
    ##   <chr> <dbl> <lgl>          <dbl>
    ## 1 Chris    35 TRUE            2019
    ## 2 Jessy    30 FALSE           2026

In words: “start with people, **and then** keep the rows where Age is
over 25, **and then** sort by Age, oldest first.”

Without the pipe, you would have to read it inside out:

``` r
arrange(filter(people, Age > 25), desc(Age))
```

    ## # A tibble: 2 x 4
    ##   Name    Age Professor Graduation
    ##   <chr> <dbl> <lgl>          <dbl>
    ## 1 Chris    35 TRUE            2019
    ## 2 Jessy    30 FALSE           2026

Same answer, much harder to read.

**Shortcut:** Mac: **Cmd + Shift + M**, Windows: **Ctrl + Shift + M**

<mark>To make the shortcut type `|>`: Tools → Global Options → Code →
check **“Use native pipe operator, \|\>”**.</mark> Online you will also
see `%>%`. It’s an older pipe that does almost the same thing.

------------------------------------------------------------------------

#### Activity 8.4

1.  Turn on the native pipe in RStudio (Tools → Global Options → Code).
    Test the shortcut.
2.  Using `all_cities` from Activity 8.1, write a pipe that keeps cities
    with a population over 1,000,000 **and then** sorts them from
    biggest to smallest.
3.  Say your pipe out loud to your neighbor using “and then.”

``` r
# Your code here
```

------------------------------------------------------------------------

## 9. Your first real dataset

Typing data by hand doesn’t scale. Real data comes in files, usually
**CSV** files (comma-separated values: a spreadsheet saved as plain
text).

### 9.1 Loading a CSV file

The tidyverse reads CSV files with `read_csv()`. Our first dataset
describes 2,000 students: how they spend their day, their GPA, and their
stress level.

``` r
students <- read_csv("https://media.githubusercontent.com/media/aysedeniz09/IntroCSS/refs/heads/main/data/student_lifestyle_dataset.csv")
```

In words: “**students gets** the result of reading this CSV file.” Same
`<-` as `apple <- 5`, but now the box holds a whole table.

When it loads, R prints a short report of the columns it found. That’s a
message, not an error.

**Loading from your computer.** Most of the time your data is a file in
your `data/` folder (Section 2.2). Because your project is open, a short
path works:

``` r
students <- read_csv("data/student_lifestyle_dataset.csv")
```

<mark>Base R reads CSV files with `read.csv()` (with a dot). You will
see it online. In this class we use `read_csv()` (with an underscore),
which gives you a tibble.</mark>

------------------------------------------------------------------------

### 9.2 Meet the data

Use the tools from Section 8.2 on any new dataset:

``` r
glimpse(students)
```

    ## Rows: 2,000
    ## Columns: 12
    ## $ Student_ID                      <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,~
    ## $ Study_Hours_Per_Day             <dbl> 6.9, 5.3, 5.1, 6.5, 8.1, 6.0, 8.0, 8.4~
    ## $ Extracurricular_Hours_Per_Day   <dbl> 3.8, 3.5, 3.9, 2.1, 0.6, 2.1, 0.7, 1.8~
    ## $ Sleep_Hours_Per_Day             <dbl> 8.7, 8.0, 9.2, 7.2, 6.5, 8.0, 5.3, 5.6~
    ## $ Social_Hours_Per_Day            <dbl> 2.8, 4.2, 1.2, 1.7, 2.2, 0.3, 5.7, 3.0~
    ## $ Physical_Activity_Hours_Per_Day <dbl> 1.8, 3.0, 4.6, 6.5, 6.6, 7.6, 4.3, 5.2~
    ## $ GPA                             <dbl> 2.99, 2.75, 2.67, 2.88, 3.51, 2.85, 3.~
    ## $ Stress_Level                    <chr> "Moderate", "Low", "Low", "Moderate", ~
    ## $ college                         <chr> "Education", "Humanities", "Arts & Sci~
    ## $ GPA_Level                       <chr> "MediumGPA", "LowGPA", "LowGPA", "LowG~
    ## $ Stress_Level2                   <chr> "LowModerate", "LowModerate", "LowMode~
    ## $ books_read                      <dbl> 4, 7, 4, 8, 9, 2, 5, 8, 5, 5, 9, 5, 6,~

Each **row** is one student. In research terms, a student is the **unit
of analysis**. Each **column** is a **variable**.

**What do the columns mean?** Always read the data dictionary.

| Column                            | What it means                             |
|-----------------------------------|-------------------------------------------|
| `Student_ID`                      | A number for each student                 |
| `Study_Hours_Per_Day`             | Hours spent studying per day              |
| `Extracurricular_Hours_Per_Day`   | Hours on clubs and activities per day     |
| `Sleep_Hours_Per_Day`             | Hours of sleep per day                    |
| `Social_Hours_Per_Day`            | Hours spent socializing per day           |
| `Physical_Activity_Hours_Per_Day` | Hours of exercise per day                 |
| `GPA`                             | Grade point average                       |
| `Stress_Level`                    | `"Low"`, `"Moderate"`, or `"High"`        |
| `college`                         | The student’s college                     |
| `GPA_Level`                       | `"LowGPA"`, `"MediumGPA"`, or `"HighGPA"` |
| `Stress_Level2`                   | `"LowModerate"` or `"High"`               |
| `books_read`                      | Number of books read                      |

<mark>Copy column names from `names(students)`. The capital letters and
underscores must match exactly (Section 4.2).</mark>

``` r
names(students)
```

    ##  [1] "Student_ID"                      "Study_Hours_Per_Day"            
    ##  [3] "Extracurricular_Hours_Per_Day"   "Sleep_Hours_Per_Day"            
    ##  [5] "Social_Hours_Per_Day"            "Physical_Activity_Hours_Per_Day"
    ##  [7] "GPA"                             "Stress_Level"                   
    ##  [9] "college"                         "GPA_Level"                      
    ## [11] "Stress_Level2"                   "books_read"

------------------------------------------------------------------------

### 9.3 Your first questions

Now use the tidy verbs from Section 8.3 on real data.

**How many students sleep less than 6 hours a night?**

``` r
students |>
  filter(Sleep_Hours_Per_Day < 6) |>
  nrow()
```

    ## [1] 402

In words: “start with students, **and then** keep the rows where sleep
is less than 6, **and then** count the rows.” 402 of the 2,000 students
sleep less than 6 hours.

**Who studies the most?**

``` r
students |>
  arrange(desc(Study_Hours_Per_Day)) |>
  select(Student_ID, Study_Hours_Per_Day, GPA) |>
  head(5)
```

    ## # A tibble: 5 x 3
    ##   Student_ID Study_Hours_Per_Day   GPA
    ##        <dbl>               <dbl> <dbl>
    ## 1        101                  10  3.41
    ## 2        279                  10  3.56
    ## 3        308                  10  3.26
    ## 4        312                  10  3.44
    ## 5        364                  10  3.43

In words: “start with students, **and then** sort by study hours,
biggest first, **and then** keep three columns, **and then** show the
first 5 rows.”

**What does a typical student look like?**

``` r
students |>
  summarise(
    mean_gpa = mean(GPA),
    mean_sleep = mean(Sleep_Hours_Per_Day),
    mean_study = mean(Study_Hours_Per_Day)
  )
```

    ## # A tibble: 1 x 3
    ##   mean_gpa mean_sleep mean_study
    ##      <dbl>      <dbl>      <dbl>
    ## 1     3.12       7.50       7.48

On average, students have a GPA of 3.12, sleep 7.5 hours, and study 7.5
hours a day.

Next class we go further: comparing groups (for example, colleges) with
`group_by()` and `count()`.

------------------------------------------------------------------------

#### Activity 9

1.  Load the student data into a box called `students`.
2.  How many students and how many columns are there? What type is
    `GPA`? What type is `college`?
3.  How many students have a `Stress_Level` of `"High"`? (Hint: text
    goes in quotes.)
4.  What is the average `Social_Hours_Per_Day`? Round it to 1 decimal.
5.  Show the 5 students who read the most books, with only their
    `Student_ID`, `books_read`, and `GPA`.
6.  **Read the base R:** what does `students[students$GPA > 3.5, ]` do?
    Write the tidy version.

``` r
# Your code here
```

------------------------------------------------------------------------

## 10. Put it together

#### Class Exercise

1.  **Create a tibble** of 5 of your favorite movies called `movies`,
    with columns for `Title`, `Year`, and `Rating` (out of 10).
2.  **Look at it** with `glimpse()`. What type is each column?
3.  **Filter rows:** show only movies released after 2010.
4.  **Add a new column:** `Oscar`, saying whether each movie won an
    Oscar (`TRUE` or `FALSE`). Save it back into `movies`.
5.  **Sort:** show the movies from highest to lowest rating.
6.  **Use a pipe** to do steps 3 and 5 together: movies after 2010,
    highest rated first.
7.  **Base R check:** write step 3 in base R. Does it give the same
    answer?
8.  What is the average rating of your movies? Round it to 1 decimal.

``` r
# Your code here
```

------------------------------------------------------------------------

### Before Next Class

<mark>**Assignment 1 (due Feb 1):** make a GitHub account and install
Git. Follow Step 4 of the [installation
guide](https://aysedeniz09.github.io/IntroCSS/install.html), then submit
your GitHub username and a screenshot of `git --version` on
Blackboard.</mark>

------------------------------------------------------------------------

### Lecture 1 Cheat Sheet

| **Topic**             | **Key Points / Commands**                                                                                                                                         |
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **RStudio**           | Four panes: Source (write code), Console (runs code), Environment (what you’ve stored), Files/Plots/Packages/Help.                                                |
| **Run code**          | Ctrl+Enter (Windows) / Cmd+Enter (Mac). Stuck on `+`? Press Esc in the Console.                                                                                   |
| **RStudio Projects**  | Always open your work via the `.Rproj` file. Folders: `data/`, `scripts/`.                                                                                        |
| **Working Directory** | Check with `getwd()`. Should point to your project folder.                                                                                                        |
| **Packages**          | Install once: `install.packages("tidyverse")`. Load every time: `library(tidyverse)`.                                                                             |
| **Assignment**        | `apple <- 5` “apple gets 5”. Replacing a name overwrites it silently.                                                                                             |
| **Case-sensitive**    | `x` and `X` are different. “object not found” → check spelling and capitals.                                                                                      |
| **Comments**          | `#` R ignores the rest of the line.                                                                                                                               |
| **Data Types**        | Numeric, Character (in quotes), Logical (`TRUE`/`FALSE`), Factor. Check with `typeof()`. Numbers are `"double"` (or `"integer"`); `is.numeric()` checks for both. |
| **Tibble labels**     | `<dbl>` number, `<int>` whole number, `<chr>` text, `<lgl>` TRUE/FALSE.                                                                                           |
| **Questions**         | `==` `!=` `>` `<` `>=` `<=` give `TRUE`/`FALSE`. `<-` stores, `==` asks.                                                                                          |
| **Arithmetic**        | `+`, `-`, `*`, `/`, `^`. Use parentheses.                                                                                                                         |
| **Vectors**           | `c(1, 2, 3)` “combine”. One type only.                                                                                                                            |
| **Indexing**          | `x[2]`, `x[c(1, 3)]`, `x[2:3]`, `x[-2]` (all but 2nd). Missing item → `NA`.                                                                                       |
| **Vector functions**  | `length()`, `mean()`, `max()`, `min()`, `sum()`, `round(x, 1)`.                                                                                                   |
| **Counting**          | `sum(x > 4)` how many; `mean(x > 4)` what proportion.                                                                                                             |
| **Sequences**         | `1:10`                                                                                                                                                            |
| **Type Coercion**     | Mixing types converts all: Character \> Numeric \> Logical.                                                                                                       |
| **Recycling**         | Different lengths → shorter vector repeats (with a warning).                                                                                                      |
| **Tibbles**           | `tibble(col1 = c(...), col2 = c(...))`. Stack with `bind_rows()`.                                                                                                 |
| **Look at data**      | `head()`, `nrow()`, `ncol()`, `names()`, `glimpse()`, `summary()`, `View()`.                                                                                      |
| **Load a CSV**        | `students <- read_csv("data/file.csv")` or a URL.                                                                                                                 |
| **Pipe**              | `\|>` = “and then”. Shortcut: Cmd/Ctrl + Shift + M.                                                                                                               |

**Base R vs. tidy**

| Task              | Base R                   | Tidy (we use this)                       |
|-------------------|--------------------------|------------------------------------------|
| One column        | `df$Age`                 | `df \|> pull(Age)`                       |
| Pick columns      | `df[, c("Name", "Age")]` | `df \|> select(Name, Age)`               |
| Keep rows         | `df[df$Age > 25, ]`      | `df \|> filter(Age > 25)`                |
| Sort              | `df[order(-df$Age), ]`   | `df \|> arrange(desc(Age))`              |
| Add a column      | `df$new <- ...`          | `df \|> mutate(new = ...)`               |
| Summarize         | `mean(df$Age)`           | `df \|> summarise(mean_age = mean(Age))` |
| Look at structure | `str(df)`                | `glimpse(df)`                            |
