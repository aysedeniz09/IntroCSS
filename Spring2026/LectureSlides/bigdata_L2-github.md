Big Data: Data Collection and Wrangling
================
Dr. Ayse D. Lokmanoglu
Lecture 2, (B) Jan 28, (A) Feb 2

## Lecture 2 Table of Contents

| Section | Topic                           |
|---------|---------------------------------|
| 1       | Data Import                     |
| 1.1     | Understanding File Paths        |
| 1.2     | Reading CSV Files with readr    |
| 1.3     | Reading Excel Files with readxl |
| 1.4     | Loading via RStudio Files Pane  |
| 1.5     | Column Specifications           |
| 2       | Tidy Data Principles            |
| 2.1     | What is Tidy Data?              |
| 2.2     | Tibbles                         |
| 2.3     | The Pipe Operator               |
| 3       | DPLYR                           |
| 3.1     | Common dplyr Functions Overview |
| 3.2     | `filter()`                      |
| 3.3     | `select()`                      |
| 3.4     | `mutate()`                      |
| 3.5     | `summarize()`                   |
| 3.6     | `group_by()`                    |
| 3.7     | `arrange()`                     |
| 3.8     | `rename()`                      |
| 4       | Data Reshaping                  |
| 4.1     | `pivot_longer()`                |
| 4.2     | `pivot_wider()`                 |
| 4.3     | `separate()`                    |
| 4.4     | `unite()`                       |
| 5       | Handling Missing Values         |
| 5.1     | `drop_na()`                     |
| 5.2     | `fill()`                        |
| 5.3     | `replace_na()`                  |
| 6       | Expanding Tables                |
| 6.1     | `expand()`                      |
| 6.2     | `complete()`                    |
| 7       | Joins in Tidyverse              |
| 7.1     | `left_join()`                   |
| 7.2     | `right_join()`                  |
| 7.3     | `inner_join()`                  |
| 7.4     | `full_join()`                   |
| 7.5     | `anti_join()`                   |
| 8       | Regular Expressions             |
| 8.1     | Introduction to Regex           |
| 8.2     | Basic Pattern Matching          |
| 8.3     | stringr Functions               |
| 8.4     | Common Regex Patterns           |
| 8.5     | Practical Examples              |

------------------------------------------------------------------------

## 1. Data Import

One of the first steps of any project is importing data into R. Data is
often stored in tabular formats like CSV files, Excel spreadsheets, or
databases.

``` r
library(tidyverse)
library(readr)
library(readxl)
library(stringr)
```

------------------------------------------------------------------------

### 1.1 Understanding File Paths

In Lecture 1, we set up our project folder structure:

``` text
EMS747_Project/
  EMS747_Project.Rproj
  data/
  scripts/
  bigdata_L2_github.Rmd
```

When you open your project (by clicking the `.Rproj` file), R
automatically sets your **working directory** to the project folder.
This means you can use **relative paths** to access files.

#### Relative Paths vs Absolute Paths

| Type | Description | Example |
|----|----|----|
| **Absolute Path** | Full path from the root of your computer | `"/Users/ayse/Documents/EMS747_Project/data/file.csv"` |
| **Relative Path** | Path relative to your working directory | `"data/file.csv"` |

<mark>Always use relative paths in your projects!</mark> They make your
code portable and reproducible.

#### Understanding `../` (Parent Directory)

The `../` means “go up one folder level” (to the parent directory).

**Example project structure:**

``` text
EMS747_Project/
  data/
    Starbucks_User_Data.csv
  scripts/
    my_analysis.R          <- If you're working here
  bigdata_L2_github.Rmd    <- Or working here
```

- If your script is in the **main project folder**: use
  `"data/file.csv"`
- If your script is in the **scripts folder**: use `"../data/file.csv"`
  (go up one level, then into data)

``` r
# From the main project folder
starbucks_user_data <- read_csv("data/Starbucks_User_Data.csv")

# From the scripts folder (need to go up one level first)
starbucks_user_data <- read_csv("../data/Starbucks_User_Data.csv")
```

**TRY: Check your working directory**

``` r
getwd()  # This should show your project folder path
```

    ## [1] "/Users/alokman/Library/CloudStorage/GoogleDrive-alokman@bu.edu/My Drive/Teaching/S26_EMS747/ClassSlides"

------------------------------------------------------------------------

### 1.2 Reading CSV Files with readr

The `readr` package provides fast and friendly functions for reading
rectangular data.

| Function       | Description                                      |
|----------------|--------------------------------------------------|
| `read_csv()`   | Read comma delimited files                       |
| `read_csv2()`  | Read semicolon delimited files (European format) |
| `read_tsv()`   | Read tab delimited files                         |
| `read_delim()` | Read files with any delimiter                    |

**TRY: Load data from a URL**

``` r
# Load the data from the URL
url <- "https://raw.githubusercontent.com/aysedeniz09/Social_Media_Listening/refs/heads/main/MSC_social_media_list_data/Starbucks_User_Data.csv"
starbucks_user_data <- read_csv(url)

head(starbucks_user_data)
```

    ## # A tibble: 6 × 16
    ##   author_id conversation_id created_at          hashtag lang  like_count mention
    ##       <dbl>           <dbl> <dttm>              <chr>   <chr>      <dbl> <chr>  
    ## 1     30973         1.61e18 2022-12-27 15:43:16 <NA>    en            10 <NA>   
    ## 2     30973         1.60e18 2022-11-29 05:23:55 <NA>    en             9 Mo_sha…
    ## 3     30973         1.59e18 2022-11-28 20:14:09 <NA>    en             2 Mixxed…
    ## 4     30973         1.60e18 2022-11-28 12:51:28 <NA>    en             0 BihhKa…
    ## 5     30973         1.60e18 2022-11-27 15:14:26 <NA>    en             0 BihhKa…
    ## 6     30973         1.60e18 2022-11-24 17:47:24 <NA>    en             1 therea…
    ## # ℹ 9 more variables: quote_count <dbl>, referenced_status_id <dbl>,
    ## #   referenced_user_id <dbl>, reply_count <dbl>, retweet_count <dbl>,
    ## #   row_id <dbl>, status_id <dbl>, text <chr>, type <chr>

**Load from your computer**

``` r
# From the main project folder (data is a subfolder)
starbucks_user_data <- read_csv("data/Starbucks_User_Data.csv")

# From a scripts folder (need to go up one level first)
starbucks_user_data <- read_csv("../data/Starbucks_User_Data.csv")
```

------------------------------------------------------------------------

#### Useful read_csv() Arguments

| Argument | Description | Example |
|----|----|----|
| `col_names` | Use first row as names or provide your own | `col_names = FALSE` or `col_names = c("x", "y", "z")` |
| `skip` | Number of lines to skip before reading | `skip = 1` |
| `n_max` | Maximum number of rows to read | `n_max = 100` |
| `na` | Character vector of strings to interpret as NA | `na = c("", "NA", "NULL")` |

``` r
# Skip header row and provide custom column names
read_csv("data/file.csv", col_names = c("x", "y", "z"), skip = 1)

# Read only first 100 rows
read_csv("data/file.csv", n_max = 100)

# Treat "NULL" as missing values
read_csv("data/file.csv", na = c("", "NA", "NULL"))
```

------------------------------------------------------------------------

### 1.3 Reading Excel Files with readxl

The `readxl` package reads both `.xls` and `.xlsx` files.

``` r
# Install if needed
install.packages("readxl")
```

``` r
library(readxl)

# Read an Excel file
data <- read_excel("../data/Starbucks_User_Data.xlsx")

# Read a specific sheet by name or position
data <- read_excel("../data/Starbucks_User_Data.xlsx", sheet = "Sheet2")
data <- read_excel("../data/Starbucks_User_Data.xlsx", sheet = 2)

# Get all sheet names
excel_sheets("../data/Starbucks_User_Data.xlsx")

# Read a specific range of cells
data <- read_excel("../data/Starbucks_User_Data.xlsx", range = "B1:D10")
```

------------------------------------------------------------------------

### 1.4 Loading via RStudio Files Pane

You can also import data using RStudio’s point-and-click interface:

1.  Click on the **Files** pane
2.  Navigate to your data file
3.  Click **Import Dataset**
4.  Configure import options
5.  Click **Import**

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/import_data.png?raw=true)
![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/import_data2.png?raw=true)

------------------------------------------------------------------------

### 1.5 Column Specifications

Column specifications define what data type each column will be imported
as. By default, `readr` guesses column types based on the first 1000
rows.

**Column Types:**

| Type      | Function          | Abbreviation |
|-----------|-------------------|--------------|
| Logical   | `col_logical()`   | “l”          |
| Integer   | `col_integer()`   | “i”          |
| Double    | `col_double()`    | “d”          |
| Character | `col_character()` | “c”          |
| Factor    | `col_factor()`    | “f”          |
| Date      | `col_date()`      | “D”          |
| DateTime  | `col_datetime()`  | “T”          |
| Skip      | `col_skip()`      | “-” or “\_”  |

``` r
# Set specific column types
read_csv("file.csv", 
         col_types = list(
           x = col_double(),
           y = col_character(),
           z = col_date()
         ))

# Use abbreviation string
read_csv("file.csv", col_types = "dcD")

# Select specific columns to import
read_csv("file.csv", col_select = c(name, age, score))
```

------------------------------------------------------------------------

#### Hint: Built-in Datasets

R comes with many built-in datasets for practice:

``` r
# See all available datasets
data()

# Load a built-in dataset
data("mtcars")
head(mtcars)
```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

------------------------------------------------------------------------

## 2. Tidy Data Principles

### 2.1 What is Tidy Data?

Tidy data is a consistent way to organize tabular data. A dataset is
**tidy** if:

1.  Each **variable** is in its own **column**
2.  Each **observation** (case) is in its own **row**
3.  Each **value** is in its own **cell**

![](https://github.com/aysedeniz09/Intro_Comp_Social_Science/blob/main/images/tidy_data.jpg?raw=true)

*Image from: Hassan, F. (2023, March 21). Tidy Data in Python. Medium.*

**Why Tidy Data?**

- Simplifies data manipulation and visualization
- Works seamlessly with tidyverse packages (dplyr, ggplot2, tidyr)
- Makes data analysis more reproducible

[Tidy Cheat
Sheet](https://raw.githubusercontent.com/rstudio/cheatsheets/main/tidyr.pdf)

------------------------------------------------------------------------

### 2.2 Tibbles

**Tibbles** are a modern reimagining of data frames provided by the
`tibble` package. They have improved behaviors:

- Better printing (shows only first 10 rows and columns that fit on
  screen)
- No partial matching when subsetting columns
- Never convert strings to factors automatically
- Subset with `[]` for a tibble, `[[]]` or `$` for a vector

``` r
library(tibble)

# Create a tibble by columns
my_tibble <- tibble(
  x = 1:3,
  y = c("a", "b", "c"),
  z = c(TRUE, FALSE, TRUE)
)
my_tibble
```

    ## # A tibble: 3 × 3
    ##       x y     z    
    ##   <int> <chr> <lgl>
    ## 1     1 a     TRUE 
    ## 2     2 b     FALSE
    ## 3     3 c     TRUE

``` r
# Create a tibble by rows (useful for small datasets)
my_tibble2 <- tribble(
  ~x, ~y, ~z,
  1, "a", TRUE,
  2, "b", FALSE,
  3, "c", TRUE
)
my_tibble2
```

    ## # A tibble: 3 × 3
    ##       x y     z    
    ##   <dbl> <chr> <lgl>
    ## 1     1 a     TRUE 
    ## 2     2 b     FALSE
    ## 3     3 c     TRUE

``` r
# Convert data frame to tibble
as_tibble(mtcars)
```

    ## # A tibble: 32 × 11
    ##      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
    ##    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
    ##  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4
    ##  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4
    ##  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
    ##  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
    ##  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
    ##  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
    ##  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
    ##  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2
    ##  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
    ## 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
    ## # ℹ 22 more rows

``` r
# Check if something is a tibble
is_tibble(my_tibble)
```

    ## [1] TRUE

``` r
is_tibble(mtcars)
```

    ## [1] FALSE

------------------------------------------------------------------------

### 2.3 The Pipe Operator

The **pipe** operator `|>` (or `%>%` from magrittr) allows you to chain
operations together, making code more readable.

**Shortcut:** - Mac: **Cmd + Shift + M** - Windows: **Ctrl + Shift + M**

``` r
# Without pipe (nested functions - hard to read)
head(arrange(filter(mtcars, mpg > 20), desc(hp)), 3)
```

    ##                mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Lotus Europa  30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Mazda RX4     21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4

``` r
# With pipe (sequential - easy to read)
mtcars |> 
  filter(mpg > 20) |> 
  arrange(desc(hp)) |> 
  head(3)
```

    ##                mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Lotus Europa  30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Mazda RX4     21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4

The pipe takes the output of the left side and passes it as the first
argument to the function on the right side.

------------------------------------------------------------------------

## 3. DPLYR

The `dplyr` package provides a powerful toolkit for data manipulation
with intuitive “verb” functions.

``` r
library(dplyr)
```

**Create a sample dataset:**

``` r
df <- data.frame(
  Movie_Title = c(
    "YOLO", "Successor", "Pegasus 2", "Deadpool & Wolverine", "Moana 2", 
    "The Hidden Blade", "Avatar: The Spirit Returns"
  ),
  Release_Date = c(
    "January 2024", "February 2024", "March 2024", "July 2024", 
    "November 2024", "April 2024", "December 2024"
  ),
  China_Box_Office_Gross = c(
    479597304, 469612890, 466930272, 450000000, 350000000, 320000000, 550000000
  ),
  US_Box_Office_Gross = c(
    310000000, 280000000, 290000000, 438000000, 221000000, 75000000, 600000000
  ),
  Total_Worldwide_Gross = c(
    479597304, 469612890, 466930272, 850000000, 421000000, 400000000, 1300000000
  )
)

head(df)
```

    ##            Movie_Title  Release_Date China_Box_Office_Gross US_Box_Office_Gross
    ## 1                 YOLO  January 2024              479597304            3.10e+08
    ## 2            Successor February 2024              469612890            2.80e+08
    ## 3            Pegasus 2    March 2024              466930272            2.90e+08
    ## 4 Deadpool & Wolverine     July 2024              450000000            4.38e+08
    ## 5              Moana 2 November 2024              350000000            2.21e+08
    ## 6     The Hidden Blade    April 2024              320000000            7.50e+07
    ##   Total_Worldwide_Gross
    ## 1             479597304
    ## 2             469612890
    ## 3             466930272
    ## 4             850000000
    ## 5             421000000
    ## 6             400000000

------------------------------------------------------------------------

### 3.1 Common dplyr Functions

| Function      | Description                     |
|---------------|---------------------------------|
| `filter()`    | Select rows based on conditions |
| `select()`    | Choose specific columns         |
| `mutate()`    | Create or transform columns     |
| `summarize()` | Compute summary statistics      |
| `group_by()`  | Group data by variables         |
| `arrange()`   | Sort rows                       |
| `rename()`    | Rename columns                  |

------------------------------------------------------------------------

### 3.2 `filter()`

Select rows based on specific conditions.

``` r
# Filter movies with China gross > 400 million
df |> 
  filter(China_Box_Office_Gross > 400000000)
```

    ##                  Movie_Title  Release_Date China_Box_Office_Gross
    ## 1                       YOLO  January 2024              479597304
    ## 2                  Successor February 2024              469612890
    ## 3                  Pegasus 2    March 2024              466930272
    ## 4       Deadpool & Wolverine     July 2024              450000000
    ## 5 Avatar: The Spirit Returns December 2024              550000000
    ##   US_Box_Office_Gross Total_Worldwide_Gross
    ## 1            3.10e+08             479597304
    ## 2            2.80e+08             469612890
    ## 3            2.90e+08             466930272
    ## 4            4.38e+08             850000000
    ## 5            6.00e+08            1300000000

``` r
# Multiple conditions with AND (&)
mtcars |> 
  filter(mpg > 20 & cyl == 6)
```

    ##                 mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4      21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1

``` r
# Multiple conditions with OR (|)
mtcars |> 
  filter(mpg > 25 | hp > 200)
```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8

------------------------------------------------------------------------

### 3.3 `select()`

Choose specific columns from a dataset.

``` r
# Select specific columns by name
df |> 
  select(Movie_Title, Total_Worldwide_Gross)
```

    ##                  Movie_Title Total_Worldwide_Gross
    ## 1                       YOLO             479597304
    ## 2                  Successor             469612890
    ## 3                  Pegasus 2             466930272
    ## 4       Deadpool & Wolverine             850000000
    ## 5                    Moana 2             421000000
    ## 6           The Hidden Blade             400000000
    ## 7 Avatar: The Spirit Returns            1300000000

``` r
# Select a range of columns
df |> 
  select(Movie_Title:US_Box_Office_Gross)
```

    ##                  Movie_Title  Release_Date China_Box_Office_Gross
    ## 1                       YOLO  January 2024              479597304
    ## 2                  Successor February 2024              469612890
    ## 3                  Pegasus 2    March 2024              466930272
    ## 4       Deadpool & Wolverine     July 2024              450000000
    ## 5                    Moana 2 November 2024              350000000
    ## 6           The Hidden Blade    April 2024              320000000
    ## 7 Avatar: The Spirit Returns December 2024              550000000
    ##   US_Box_Office_Gross
    ## 1            3.10e+08
    ## 2            2.80e+08
    ## 3            2.90e+08
    ## 4            4.38e+08
    ## 5            2.21e+08
    ## 6            7.50e+07
    ## 7            6.00e+08

``` r
# Exclude columns with minus sign
df |> 
  select(-Release_Date)
```

    ##                  Movie_Title China_Box_Office_Gross US_Box_Office_Gross
    ## 1                       YOLO              479597304            3.10e+08
    ## 2                  Successor              469612890            2.80e+08
    ## 3                  Pegasus 2              466930272            2.90e+08
    ## 4       Deadpool & Wolverine              450000000            4.38e+08
    ## 5                    Moana 2              350000000            2.21e+08
    ## 6           The Hidden Blade              320000000            7.50e+07
    ## 7 Avatar: The Spirit Returns              550000000            6.00e+08
    ##   Total_Worldwide_Gross
    ## 1             479597304
    ## 2             469612890
    ## 3             466930272
    ## 4             850000000
    ## 5             421000000
    ## 6             400000000
    ## 7            1300000000

**Helper functions for select():**

| Helper             | Description               |
|--------------------|---------------------------|
| `starts_with("x")` | Columns starting with “x” |
| `ends_with("x")`   | Columns ending with “x”   |
| `contains("x")`    | Columns containing “x”    |
| `everything()`     | All columns               |

``` r
# Select columns containing "Gross"
df |> 
  select(Movie_Title, contains("Gross"))
```

    ##                  Movie_Title China_Box_Office_Gross US_Box_Office_Gross
    ## 1                       YOLO              479597304            3.10e+08
    ## 2                  Successor              469612890            2.80e+08
    ## 3                  Pegasus 2              466930272            2.90e+08
    ## 4       Deadpool & Wolverine              450000000            4.38e+08
    ## 5                    Moana 2              350000000            2.21e+08
    ## 6           The Hidden Blade              320000000            7.50e+07
    ## 7 Avatar: The Spirit Returns              550000000            6.00e+08
    ##   Total_Worldwide_Gross
    ## 1             479597304
    ## 2             469612890
    ## 3             466930272
    ## 4             850000000
    ## 5             421000000
    ## 6             400000000
    ## 7            1300000000

------------------------------------------------------------------------

### 3.4 `mutate()`

Create new columns or transform existing ones.

``` r
# Create a new column
df <- df |> 
  mutate(Profit = Total_Worldwide_Gross - US_Box_Office_Gross)

# Multiple new columns at once
df |> 
  mutate(
    Profit = Total_Worldwide_Gross - US_Box_Office_Gross,
    China_Pct = China_Box_Office_Gross / Total_Worldwide_Gross * 100
  ) |> 
  select(Movie_Title, Profit, China_Pct)
```

    ##                  Movie_Title    Profit China_Pct
    ## 1                       YOLO 169597304 100.00000
    ## 2                  Successor 189612890 100.00000
    ## 3                  Pegasus 2 176930272 100.00000
    ## 4       Deadpool & Wolverine 412000000  52.94118
    ## 5                    Moana 2 200000000  83.13539
    ## 6           The Hidden Blade 325000000  80.00000
    ## 7 Avatar: The Spirit Returns 700000000  42.30769

------------------------------------------------------------------------

### 3.5 `summarize()`

Compute summary statistics. Often used with `group_by()`.

``` r
# Overall summary
df |> 
  summarize(
    Total_China = sum(China_Box_Office_Gross),
    Avg_Worldwide = mean(Total_Worldwide_Gross),
    Count = n()
  )
```

    ##   Total_China Avg_Worldwide Count
    ## 1  3086140466     626734352     7

``` r
# Summary with mtcars
mtcars |> 
  summarize(
    mean_mpg = mean(mpg),
    sd_mpg = sd(mpg),
    median_hp = median(hp)
  )
```

    ##   mean_mpg   sd_mpg median_hp
    ## 1 20.09062 6.026948       123

------------------------------------------------------------------------

### 3.6 `group_by()`

Group data by one or more variables for grouped operations.

``` r
# Group by cylinders and summarize
mtcars |> 
  group_by(cyl) |> 
  summarize(
    mean_mpg = mean(mpg),
    count = n()
  )
```

    ## # A tibble: 3 × 3
    ##     cyl mean_mpg count
    ##   <dbl>    <dbl> <int>
    ## 1     4     26.7    11
    ## 2     6     19.7     7
    ## 3     8     15.1    14

``` r
# Group by multiple variables
mtcars |> 
  group_by(cyl, gear) |> 
  summarize(
    mean_mpg = mean(mpg),
    count = n(),
    .groups = "drop"  # Ungroup after summarizing
  )
```

    ## # A tibble: 8 × 4
    ##     cyl  gear mean_mpg count
    ##   <dbl> <dbl>    <dbl> <int>
    ## 1     4     3     21.5     1
    ## 2     4     4     26.9     8
    ## 3     4     5     28.2     2
    ## 4     6     3     19.8     2
    ## 5     6     4     19.8     4
    ## 6     6     5     19.7     1
    ## 7     8     3     15.0    12
    ## 8     8     5     15.4     2

------------------------------------------------------------------------

### 3.7 `arrange()`

Sort rows by one or more variables.

``` r
# Sort ascending (default)
df |> 
  arrange(Total_Worldwide_Gross)
```

    ##                  Movie_Title  Release_Date China_Box_Office_Gross
    ## 1           The Hidden Blade    April 2024              320000000
    ## 2                    Moana 2 November 2024              350000000
    ## 3                  Pegasus 2    March 2024              466930272
    ## 4                  Successor February 2024              469612890
    ## 5                       YOLO  January 2024              479597304
    ## 6       Deadpool & Wolverine     July 2024              450000000
    ## 7 Avatar: The Spirit Returns December 2024              550000000
    ##   US_Box_Office_Gross Total_Worldwide_Gross    Profit
    ## 1            7.50e+07             400000000 325000000
    ## 2            2.21e+08             421000000 200000000
    ## 3            2.90e+08             466930272 176930272
    ## 4            2.80e+08             469612890 189612890
    ## 5            3.10e+08             479597304 169597304
    ## 6            4.38e+08             850000000 412000000
    ## 7            6.00e+08            1300000000 700000000

``` r
# Sort descending
df |> 
  arrange(desc(Total_Worldwide_Gross))
```

    ##                  Movie_Title  Release_Date China_Box_Office_Gross
    ## 1 Avatar: The Spirit Returns December 2024              550000000
    ## 2       Deadpool & Wolverine     July 2024              450000000
    ## 3                       YOLO  January 2024              479597304
    ## 4                  Successor February 2024              469612890
    ## 5                  Pegasus 2    March 2024              466930272
    ## 6                    Moana 2 November 2024              350000000
    ## 7           The Hidden Blade    April 2024              320000000
    ##   US_Box_Office_Gross Total_Worldwide_Gross    Profit
    ## 1            6.00e+08            1300000000 700000000
    ## 2            4.38e+08             850000000 412000000
    ## 3            3.10e+08             479597304 169597304
    ## 4            2.80e+08             469612890 189612890
    ## 5            2.90e+08             466930272 176930272
    ## 6            2.21e+08             421000000 200000000
    ## 7            7.50e+07             400000000 325000000

``` r
# Sort by multiple columns
mtcars |> 
  arrange(cyl, desc(mpg)) |> 
  head()
```

    ##                 mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic    30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2

------------------------------------------------------------------------

### 3.8 `rename()`

Rename columns. Syntax: `rename(new_name = old_name)`

``` r
df_renamed <- df |> 
  rename(
    China_Gross = China_Box_Office_Gross,
    US_Gross = US_Box_Office_Gross,
    Worldwide_Gross = Total_Worldwide_Gross
  )

names(df_renamed)
```

    ## [1] "Movie_Title"     "Release_Date"    "China_Gross"     "US_Gross"       
    ## [5] "Worldwide_Gross" "Profit"

------------------------------------------------------------------------

#### <span style="color: purple;">Class Exercise: dplyr Practice</span>

Use the movies dataset and perform the following:

1.  `filter()`: Select movies with a total worldwide gross greater than
    \$500M.
2.  `select()`: Choose only Movie_Title and columns containing “Gross”.
3.  `mutate()`: Add a new column for US percentage of worldwide gross.
4.  `summarize()`: Compute the total and average gross for China.
5.  `group_by()` + `summarize()`: Calculate average gross by release
    month (hint: you’ll need to extract month first).
6.  `arrange()`: Sort movies by worldwide gross in descending order.

``` r
### Your workspace
```

------------------------------------------------------------------------

## 4. Data Reshaping

Data often needs to be reshaped between “wide” and “long” formats for
different analyses.

![](https://github.com/aysedeniz09/IntroCSS/blob/main/images/pivot_meme.jpg?raw=true)

![](https://github.com/aysedeniz09/IntroCSS/blob/main/images/pivot_long.png?raw=true)

------------------------------------------------------------------------

### 4.1 `pivot_longer()`

Transform data from **wide** to **long** format by collapsing multiple
columns into two: one for names and one for values.

**Key Arguments:** - `cols`: Columns to pivot - `names_to`: Name for the
new column holding original column names - `values_to`: Name for the new
column holding values

``` r
# Convert movie data to long format
long_df <- df |> 
  pivot_longer(
    cols = China_Box_Office_Gross:Total_Worldwide_Gross,
    names_to = "Box_Office_Type",
    values_to = "Gross"
  )

print(long_df)
```

    ## # A tibble: 21 × 5
    ##    Movie_Title          Release_Date     Profit Box_Office_Type            Gross
    ##    <chr>                <chr>             <dbl> <chr>                      <dbl>
    ##  1 YOLO                 January 2024  169597304 China_Box_Office_Gross 479597304
    ##  2 YOLO                 January 2024  169597304 US_Box_Office_Gross    310000000
    ##  3 YOLO                 January 2024  169597304 Total_Worldwide_Gross  479597304
    ##  4 Successor            February 2024 189612890 China_Box_Office_Gross 469612890
    ##  5 Successor            February 2024 189612890 US_Box_Office_Gross    280000000
    ##  6 Successor            February 2024 189612890 Total_Worldwide_Gross  469612890
    ##  7 Pegasus 2            March 2024    176930272 China_Box_Office_Gross 466930272
    ##  8 Pegasus 2            March 2024    176930272 US_Box_Office_Gross    290000000
    ##  9 Pegasus 2            March 2024    176930272 Total_Worldwide_Gross  466930272
    ## 10 Deadpool & Wolverine July 2024     412000000 China_Box_Office_Gross 450000000
    ## # ℹ 11 more rows

``` r
# Another example with mtcars
mtcars_long <- mtcars |> 
  rownames_to_column("car") |> 
  pivot_longer(
    cols = mpg:carb,
    names_to = "metric",
    values_to = "value"
  )

head(mtcars_long)
```

    ## # A tibble: 6 × 3
    ##   car       metric  value
    ##   <chr>     <chr>   <dbl>
    ## 1 Mazda RX4 mpg     21   
    ## 2 Mazda RX4 cyl      6   
    ## 3 Mazda RX4 disp   160   
    ## 4 Mazda RX4 hp     110   
    ## 5 Mazda RX4 drat     3.9 
    ## 6 Mazda RX4 wt       2.62

------------------------------------------------------------------------

### 4.2 `pivot_wider()`

Transform data from **long** to **wide** format by spreading values
across multiple columns.

**Key Arguments:** - `names_from`: Column whose values become new column
names - `values_from`: Column whose values fill the new columns

``` r
# Convert back to wide format
wide_df <- long_df |> 
  pivot_wider(
    names_from = Box_Office_Type,
    values_from = Gross
  )

print(wide_df)
```

    ## # A tibble: 7 × 6
    ##   Movie_Title     Release_Date Profit China_Box_Office_Gross US_Box_Office_Gross
    ##   <chr>           <chr>         <dbl>                  <dbl>               <dbl>
    ## 1 YOLO            January 2024 1.70e8              479597304           310000000
    ## 2 Successor       February 20… 1.90e8              469612890           280000000
    ## 3 Pegasus 2       March 2024   1.77e8              466930272           290000000
    ## 4 Deadpool & Wol… July 2024    4.12e8              450000000           438000000
    ## 5 Moana 2         November 20… 2   e8              350000000           221000000
    ## 6 The Hidden Bla… April 2024   3.25e8              320000000            75000000
    ## 7 Avatar: The Sp… December 20… 7   e8              550000000           600000000
    ## # ℹ 1 more variable: Total_Worldwide_Gross <dbl>

------------------------------------------------------------------------

#### Differences Between pivot_longer and pivot_wider

| Feature | `pivot_longer()` | `pivot_wider()` |
|----|----|----|
| **Direction** | Wide → Long | Long → Wide |
| **Purpose** | Consolidate columns | Spread values across columns |
| **Key Arguments** | `cols`, `names_to`, `values_to` | `names_from`, `values_from` |
| **Typical Use** | Tidying data for analysis | Summarizing for presentation |

------------------------------------------------------------------------

### 4.3 `separate()`

Split the contents of a single column into multiple columns.

``` r
# Separate Release_Date into Month and Year
df_separated <- df |> 
  separate(Release_Date, into = c("Month", "Year"), sep = " ")

print(df_separated)
```

    ##                  Movie_Title    Month Year China_Box_Office_Gross
    ## 1                       YOLO  January 2024              479597304
    ## 2                  Successor February 2024              469612890
    ## 3                  Pegasus 2    March 2024              466930272
    ## 4       Deadpool & Wolverine     July 2024              450000000
    ## 5                    Moana 2 November 2024              350000000
    ## 6           The Hidden Blade    April 2024              320000000
    ## 7 Avatar: The Spirit Returns December 2024              550000000
    ##   US_Box_Office_Gross Total_Worldwide_Gross    Profit
    ## 1            3.10e+08             479597304 169597304
    ## 2            2.80e+08             469612890 189612890
    ## 3            2.90e+08             466930272 176930272
    ## 4            4.38e+08             850000000 412000000
    ## 5            2.21e+08             421000000 200000000
    ## 6            7.50e+07             400000000 325000000
    ## 7            6.00e+08            1300000000 700000000

**Related functions:** - `separate_wider_delim()`: Separate by delimiter
into columns - `separate_wider_position()`: Separate by position into
columns - `separate_longer_delim()`: Separate into rows instead of
columns

------------------------------------------------------------------------

### 4.4 `unite()`

Combine multiple columns into a single column.

``` r
# Combine Month and Year back into Release_Date
df_united <- df_separated |> 
  unite("Release_Date", Month, Year, sep = " ")

print(df_united)
```

    ##                  Movie_Title  Release_Date China_Box_Office_Gross
    ## 1                       YOLO  January 2024              479597304
    ## 2                  Successor February 2024              469612890
    ## 3                  Pegasus 2    March 2024              466930272
    ## 4       Deadpool & Wolverine     July 2024              450000000
    ## 5                    Moana 2 November 2024              350000000
    ## 6           The Hidden Blade    April 2024              320000000
    ## 7 Avatar: The Spirit Returns December 2024              550000000
    ##   US_Box_Office_Gross Total_Worldwide_Gross    Profit
    ## 1            3.10e+08             479597304 169597304
    ## 2            2.80e+08             469612890 189612890
    ## 3            2.90e+08             466930272 176930272
    ## 4            4.38e+08             850000000 412000000
    ## 5            2.21e+08             421000000 200000000
    ## 6            7.50e+07             400000000 325000000
    ## 7            6.00e+08            1300000000 700000000

------------------------------------------------------------------------

## 5. Handling Missing Values

Missing values (`NA`) are common in real-world data. The `tidyr` package
provides functions to handle them.

``` r
# Create sample data with missing values
missing_df <- tibble(
  x1 = c("A", "B", "C", "D", "E"),
  x2 = c(1, NA, NA, 3, NA)
)
missing_df
```

    ## # A tibble: 5 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B        NA
    ## 3 C        NA
    ## 4 D         3
    ## 5 E        NA

------------------------------------------------------------------------

### 5.1 `drop_na()`

Remove rows containing `NA` values.

``` r
# Drop rows with NA in any column
missing_df |> 
  drop_na()
```

    ## # A tibble: 2 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 D         3

``` r
# Drop rows with NA only in specific columns
missing_df |> 
  drop_na(x2)
```

    ## # A tibble: 2 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 D         3

------------------------------------------------------------------------

### 5.2 `fill()`

Fill in `NA` values using the previous or next value.

``` r
# Fill down (default)
missing_df |> 
  fill(x2, .direction = "down")
```

    ## # A tibble: 5 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         1
    ## 3 C         1
    ## 4 D         3
    ## 5 E         3

``` r
# Fill up
missing_df |> 
  fill(x2, .direction = "up")
```

    ## # A tibble: 5 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         3
    ## 3 C         3
    ## 4 D         3
    ## 5 E        NA

``` r
# Fill in both directions (down first, then up)
missing_df |> 
  fill(x2, .direction = "downup")
```

    ## # A tibble: 5 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         1
    ## 3 C         1
    ## 4 D         3
    ## 5 E         3

------------------------------------------------------------------------

### 5.3 `replace_na()`

Replace `NA` values with a specified value.

``` r
# Replace NA with a specific value
missing_df |> 
  replace_na(list(x2 = 0))
```

    ## # A tibble: 5 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         0
    ## 3 C         0
    ## 4 D         3
    ## 5 E         0

``` r
# Replace NA with the mean (requires mutate)
missing_df |> 
  mutate(x2 = replace_na(x2, mean(x2, na.rm = TRUE)))
```

    ## # A tibble: 5 × 2
    ##   x1       x2
    ##   <chr> <dbl>
    ## 1 A         1
    ## 2 B         2
    ## 3 C         2
    ## 4 D         3
    ## 5 E         2

------------------------------------------------------------------------

## 6. Expanding Tables

Create new combinations of variables or identify implicit missing
values.

------------------------------------------------------------------------

### 6.1 `expand()`

Create a tibble with all possible combinations of specified variables.

``` r
# All combinations of cyl and gear
mtcars |> 
  expand(cyl, gear)
```

    ## # A tibble: 9 × 2
    ##     cyl  gear
    ##   <dbl> <dbl>
    ## 1     4     3
    ## 2     4     4
    ## 3     4     5
    ## 4     6     3
    ## 5     6     4
    ## 6     6     5
    ## 7     8     3
    ## 8     8     4
    ## 9     8     5

------------------------------------------------------------------------

### 6.2 `complete()`

Add missing combinations of values to a dataset, filling other variables
with `NA`.

``` r
# Sample data with implicit missing combinations
sales_df <- tibble(
  store = c("A", "A", "B"),
  product = c("X", "Y", "X"),
  sales = c(100, 150, 200)
)
sales_df
```

    ## # A tibble: 3 × 3
    ##   store product sales
    ##   <chr> <chr>   <dbl>
    ## 1 A     X         100
    ## 2 A     Y         150
    ## 3 B     X         200

``` r
# Complete with all combinations
sales_df |> 
  complete(store, product)
```

    ## # A tibble: 4 × 3
    ##   store product sales
    ##   <chr> <chr>   <dbl>
    ## 1 A     X         100
    ## 2 A     Y         150
    ## 3 B     X         200
    ## 4 B     Y          NA

``` r
# Complete and fill missing values with 0
sales_df |> 
  complete(store, product, fill = list(sales = 0))
```

    ## # A tibble: 4 × 3
    ##   store product sales
    ##   <chr> <chr>   <dbl>
    ## 1 A     X         100
    ## 2 A     Y         150
    ## 3 B     X         200
    ## 4 B     Y           0

------------------------------------------------------------------------

## 7. Joins in Tidyverse

[Joins](https://dplyr.tidyverse.org/reference/mutate-joins.html) combine
two datasets based on a common key (column).

| Join Type      | Description                                    |
|----------------|------------------------------------------------|
| `left_join()`  | Keep all rows from the **left** dataset        |
| `right_join()` | Keep all rows from the **right** dataset       |
| `inner_join()` | Keep only rows that match in **both** datasets |
| `full_join()`  | Keep all rows from **both** datasets           |
| `anti_join()`  | Keep rows from left that **don’t** match right |

![](https://raw.githubusercontent.com/aysedeniz09/IntroCSS/9c1569009e815b5939498acabbea278cb2e022aa/images/joins.svg)

------------------------------------------------------------------------

**Create datasets for joining:**

``` r
# Directors dataset
df_directors <- tibble(
  Movie_Title = c("YOLO", "Successor", "Deadpool & Wolverine", "Moana 2"),
  Director = c("Jia Ling", "Xu Zheng", "Shawn Levy", "David Derrick Jr.")
)

# Ratings dataset  
df_ratings <- tibble(
  Movie_Title = c("YOLO", "Pegasus 2", "Moana 2", "Wicked"),
  Rating = c(8.1, 7.5, 7.8, 8.0)
)
```

------------------------------------------------------------------------

### 7.1 `left_join()`

Keep all rows from the left dataset, add matching data from the right.

``` r
# Add directors to movies (keep all movies)
df |> 
  select(Movie_Title, Total_Worldwide_Gross) |> 
  left_join(df_directors, by = "Movie_Title")
```

    ##                  Movie_Title Total_Worldwide_Gross          Director
    ## 1                       YOLO             479597304          Jia Ling
    ## 2                  Successor             469612890          Xu Zheng
    ## 3                  Pegasus 2             466930272              <NA>
    ## 4       Deadpool & Wolverine             850000000        Shawn Levy
    ## 5                    Moana 2             421000000 David Derrick Jr.
    ## 6           The Hidden Blade             400000000              <NA>
    ## 7 Avatar: The Spirit Returns            1300000000              <NA>

------------------------------------------------------------------------

### 7.2 `right_join()`

Keep all rows from the right dataset, add matching data from the left.

``` r
# Keep all directors, add movie data
df |> 
  select(Movie_Title, Total_Worldwide_Gross) |> 
  right_join(df_directors, by = "Movie_Title")
```

    ##            Movie_Title Total_Worldwide_Gross          Director
    ## 1                 YOLO             479597304          Jia Ling
    ## 2            Successor             469612890          Xu Zheng
    ## 3 Deadpool & Wolverine             850000000        Shawn Levy
    ## 4              Moana 2             421000000 David Derrick Jr.

------------------------------------------------------------------------

### 7.3 `inner_join()`

Keep only rows that have matches in both datasets.

``` r
# Only movies that have both gross data AND ratings
df |> 
  select(Movie_Title, Total_Worldwide_Gross) |> 
  inner_join(df_ratings, by = "Movie_Title")
```

    ##   Movie_Title Total_Worldwide_Gross Rating
    ## 1        YOLO             479597304    8.1
    ## 2   Pegasus 2             466930272    7.5
    ## 3     Moana 2             421000000    7.8

------------------------------------------------------------------------

### 7.4 `full_join()`

Keep all rows from both datasets, filling with `NA` where there’s no
match.

``` r
# Combine all movies and ratings
df |> 
  select(Movie_Title, Total_Worldwide_Gross) |> 
  full_join(df_ratings, by = "Movie_Title")
```

    ##                  Movie_Title Total_Worldwide_Gross Rating
    ## 1                       YOLO             479597304    8.1
    ## 2                  Successor             469612890     NA
    ## 3                  Pegasus 2             466930272    7.5
    ## 4       Deadpool & Wolverine             850000000     NA
    ## 5                    Moana 2             421000000    7.8
    ## 6           The Hidden Blade             400000000     NA
    ## 7 Avatar: The Spirit Returns            1300000000     NA
    ## 8                     Wicked                    NA    8.0

------------------------------------------------------------------------

### 7.5 `anti_join()`

Return rows from the left dataset that do NOT have a match in the right.

``` r
# Movies WITHOUT directors
df |> 
  select(Movie_Title) |> 
  anti_join(df_directors, by = "Movie_Title")
```

    ##                  Movie_Title
    ## 1                  Pegasus 2
    ## 2           The Hidden Blade
    ## 3 Avatar: The Spirit Returns

``` r
# Movies WITHOUT ratings
df |> 
  select(Movie_Title) |> 
  anti_join(df_ratings, by = "Movie_Title")
```

    ##                  Movie_Title
    ## 1                  Successor
    ## 2       Deadpool & Wolverine
    ## 3           The Hidden Blade
    ## 4 Avatar: The Spirit Returns

------------------------------------------------------------------------

#### <span style="color: purple;">Class Exercise: Joins Practice</span>

Use the provided datasets (df, df_directors, df_ratings):

1.  `left_join()`: Merge directors into the main movie dataset.
2.  `inner_join()`: Find movies that have both director and rating
    information.
3.  `anti_join()`: Identify movies without ratings.
4.  `full_join()`: Create a comprehensive dataset with all movies,
    directors, and ratings.

``` r
### Your workspace
```

------------------------------------------------------------------------

## 8. Regular Expressions

Regular expressions (regex) are powerful patterns used to match, search,
and manipulate text. They are essential for data cleaning and text
processing.

We will use the [`stringr` package](https://stringr.tidyverse.org/),
which is part of the tidyverse.

``` r
library(stringr)
```

------------------------------------------------------------------------

### 8.1 Introduction to Regex

A regular expression is a sequence of characters that defines a search
pattern. Think of it as a sophisticated “find and replace” tool.

**Why use regex?**

- Clean messy text data (remove special characters, standardize formats)
- Extract specific patterns (emails, phone numbers, dates)
- Filter rows based on text patterns
- Transform text data

------------------------------------------------------------------------

### 8.2 Basic Pattern Matching

#### Literal Characters

The simplest regex matches exact text:

``` r
fruits <- c("apple", "banana", "pineapple", "grape", "grapefruit")

# Find fruits containing "apple"
str_detect(fruits, "apple")
```

    ## [1]  TRUE FALSE  TRUE FALSE FALSE

``` r
# Extract matches
str_subset(fruits, "apple")
```

    ## [1] "apple"     "pineapple"

------------------------------------------------------------------------

#### Special Characters (Metacharacters)

These characters have special meanings in regex:

| Character | Meaning | Example | Matches |
|----|----|----|----|
| `.` | Any single character | `"a.c"` | “abc”, “a1c”, “a c” |
| `^` | Start of string | `"^The"` | “The dog” but not “See The dog” |
| `$` | End of string | `"end$"` | “the end” but not “endless” |
| `*` | Zero or more of previous | `"ab*c"` | “ac”, “abc”, “abbc” |
| `+` | One or more of previous | `"ab+c"` | “abc”, “abbc” but not “ac” |
| `?` | Zero or one of previous | `"colou?r"` | “color”, “colour” |
| `\\` | Escape special character | `"\\."` | Literal period “.” |

``` r
text <- c("cat", "car", "card", "care", "scar")

# Match "ca" followed by any character
str_subset(text, "ca.")
```

    ## [1] "cat"  "car"  "card" "care" "scar"

``` r
# Match words starting with "ca"
str_subset(text, "^ca")
```

    ## [1] "cat"  "car"  "card" "care"

``` r
# Match words ending with "r"
str_subset(text, "r$")
```

    ## [1] "car"  "scar"

------------------------------------------------------------------------

#### Character Classes

Use square brackets `[]` to match any character in a set:

| Pattern  | Meaning                       | Example                     |
|----------|-------------------------------|-----------------------------|
| `[abc]`  | Match a, b, or c              | `"[aeiou]"` matches vowels  |
| `[a-z]`  | Match any lowercase letter    |                             |
| `[A-Z]`  | Match any uppercase letter    |                             |
| `[0-9]`  | Match any digit               | Same as `\\d`               |
| `[^abc]` | Match anything EXCEPT a, b, c | `[^0-9]` matches non-digits |

``` r
words <- c("hello", "HELLO", "Hello", "h3llo", "12345")

# Match words with lowercase letters
str_subset(words, "[a-z]")
```

    ## [1] "hello" "Hello" "h3llo"

``` r
# Match words with digits
str_subset(words, "[0-9]")
```

    ## [1] "h3llo" "12345"

``` r
# Match words starting with uppercase
str_subset(words, "^[A-Z]")
```

    ## [1] "HELLO" "Hello"

------------------------------------------------------------------------

#### Shorthand Character Classes

| Shorthand | Meaning                | Equivalent          |
|-----------|------------------------|---------------------|
| `\\d`     | Any digit              | `[0-9]`             |
| `\\D`     | Any non-digit          | `[^0-9]`            |
| `\\w`     | Any word character     | `[a-zA-Z0-9_]`      |
| `\\W`     | Any non-word character | `[^a-zA-Z0-9_]`     |
| `\\s`     | Any whitespace         | Space, tab, newline |
| `\\S`     | Any non-whitespace     |                     |

``` r
mixed <- c("abc123", "hello world", "test_case", "no-hyphens")

# Find strings with digits
str_subset(mixed, "\\d")
```

    ## [1] "abc123"

``` r
# Find strings with whitespace
str_subset(mixed, "\\s")
```

    ## [1] "hello world"

``` r
# Find strings with word characters only (no spaces or hyphens)
str_detect(mixed, "^\\w+$")
```

    ## [1]  TRUE FALSE  TRUE FALSE

------------------------------------------------------------------------

### 8.3 stringr Functions

The `stringr` package provides consistent, easy-to-use functions for
working with strings and regex.

| Function | Purpose | Example |
|----|----|----|
| `str_detect()` | Does pattern exist? (returns TRUE/FALSE) | `str_detect(x, "pattern")` |
| `str_subset()` | Return elements that match | `str_subset(x, "pattern")` |
| `str_extract()` | Extract first match | `str_extract(x, "pattern")` |
| `str_extract_all()` | Extract all matches | `str_extract_all(x, "pattern")` |
| `str_replace()` | Replace first match | `str_replace(x, "pattern", "replacement")` |
| `str_replace_all()` | Replace all matches | `str_replace_all(x, "pattern", "replacement")` |
| `str_match()` | Extract groups from first match | `str_match(x, "pattern")` |
| `str_count()` | Count matches | `str_count(x, "pattern")` |
| `str_split()` | Split string by pattern | `str_split(x, "pattern")` |

------------------------------------------------------------------------

#### `str_detect()` - Check for Pattern

Returns `TRUE` or `FALSE` for each element. Great for filtering with
`dplyr::filter()`.

``` r
emails <- c("user@gmail.com", "test@yahoo.com", "invalid-email", "admin@bu.edu")

# Check which are valid emails (simple check)
str_detect(emails, "@")
```

    ## [1]  TRUE  TRUE FALSE  TRUE

``` r
# Use with filter
data.frame(email = emails) |>
  filter(str_detect(email, "\\.edu$"))
```

    ##          email
    ## 1 admin@bu.edu

------------------------------------------------------------------------

#### `str_extract()` - Extract Matches

Pulls out the first matching pattern from each string.

``` r
sentences <- c("Call me at 555-1234", "My number is 555-5678", "No phone here")

# Extract phone numbers
str_extract(sentences, "\\d{3}-\\d{4}")
```

    ## [1] "555-1234" "555-5678" NA

``` r
# Extract first word
str_extract(sentences, "^\\w+")
```

    ## [1] "Call" "My"   "No"

------------------------------------------------------------------------

#### `str_replace()` and `str_replace_all()` - Replace Patterns

``` r
messy_text <- c("Hello   World", "Too    many   spaces", "Normal text")

# Replace multiple spaces with single space
str_replace_all(messy_text, "\\s+", " ")
```

    ## [1] "Hello World"     "Too many spaces" "Normal text"

``` r
# Remove all digits
str_replace_all("Phone: 555-1234", "\\d", "X")
```

    ## [1] "Phone: XXX-XXXX"

------------------------------------------------------------------------

#### `str_match()` - Extract Groups

Use parentheses `()` to create capture groups. `str_match()` returns a
matrix with the full match and each group.

``` r
dates <- c("2024-01-15", "2023-12-25", "2025-06-30")

# Extract year, month, day separately
str_match(dates, "(\\d{4})-(\\d{2})-(\\d{2})")
```

    ##      [,1]         [,2]   [,3] [,4]
    ## [1,] "2024-01-15" "2024" "01" "15"
    ## [2,] "2023-12-25" "2023" "12" "25"
    ## [3,] "2025-06-30" "2025" "06" "30"

------------------------------------------------------------------------

### 8.4 Common Regex Patterns

Here are some useful patterns for common data cleaning tasks:

| Task | Pattern | Example |
|----|----|----|
| Email | `[\\w.-]+@[\\w.-]+\\.\\w+` | <user@example.com> |
| Phone (US) | `\\d{3}[-.\\s]?\\d{3}[-.\\s]?\\d{4}` | 555-123-4567 |
| URL | `https?://[\\w./]+` | <https://example.com> |
| Twitter handle | `@\\w+` | @username |
| Hashtag | `#\\w+` | \#DataScience |
| Date (YYYY-MM-DD) | `\\d{4}-\\d{2}-\\d{2}` | 2024-01-15 |
| Time (HH:MM) | `\\d{2}:\\d{2}` | 14:30 |

------------------------------------------------------------------------

### 8.5 Practical Examples

#### Example 1: Cleaning Twitter Data

``` r
tweets <- c(
  "@user1 Check out this link https://t.co/abc123 #DataScience",
  "Hello @user2! Great post! #RStats #coding",
  "Just a regular tweet with no mentions"
)

# Extract mentions (@username)
str_extract_all(tweets, "@\\w+")
```

    ## [[1]]
    ## [1] "@user1"
    ## 
    ## [[2]]
    ## [1] "@user2"
    ## 
    ## [[3]]
    ## character(0)

``` r
# Extract hashtags
str_extract_all(tweets, "#\\w+")
```

    ## [[1]]
    ## [1] "#DataScience"
    ## 
    ## [[2]]
    ## [1] "#RStats" "#coding"
    ## 
    ## [[3]]
    ## character(0)

``` r
# Remove URLs
str_replace_all(tweets, "https?://\\S+", "[URL]")
```

    ## [1] "@user1 Check out this link [URL] #DataScience"
    ## [2] "Hello @user2! Great post! #RStats #coding"    
    ## [3] "Just a regular tweet with no mentions"

------------------------------------------------------------------------

#### Example 2: Extracting Information with dplyr

``` r
# Sample data
customer_data <- data.frame(
  info = c(
    "John Smith, Email: john@gmail.com, Phone: 555-1234",
    "Jane Doe, Email: jane@yahoo.com, Phone: 555-5678",
    "Bob Wilson, Email: bob@bu.edu, Phone: 555-9999"
  )
)

# Extract emails and phones into new columns
customer_data |>
  mutate(
    email = str_extract(info, "[\\w.-]+@[\\w.-]+\\.\\w+"),
    phone = str_extract(info, "\\d{3}-\\d{4}"),
    name = str_extract(info, "^[A-Za-z]+ [A-Za-z]+")
  )
```

    ##                                                 info          email    phone
    ## 1 John Smith, Email: john@gmail.com, Phone: 555-1234 john@gmail.com 555-1234
    ## 2   Jane Doe, Email: jane@yahoo.com, Phone: 555-5678 jane@yahoo.com 555-5678
    ## 3     Bob Wilson, Email: bob@bu.edu, Phone: 555-9999     bob@bu.edu 555-9999
    ##         name
    ## 1 John Smith
    ## 2   Jane Doe
    ## 3 Bob Wilson

------------------------------------------------------------------------

#### Example 3: Text Pattern Matching with Jane Austen

``` r
library(janeaustenr)

# Get all Jane Austen books
books <- austen_books()

# Find lines mentioning "Mr." followed by a name
books |>
  filter(str_detect(text, "Mr\\.\\s[A-Z][a-z]+")) |>
  mutate(mr_name = str_extract(text, "Mr\\.\\s[A-Z][a-z]+")) |>
  count(mr_name, sort = TRUE) |>
  head(10)
```

------------------------------------------------------------------------

#### <span style="color: purple;">Class Exercise: Regex Practice</span>

Using the Starbucks Twitter data:

1.  Extract all Twitter usernames (mentions starting with @) from the
    `text` column
2.  Count how many tweets contain hashtags
3.  Find tweets that mention “coffee” (case insensitive - hint: use
    `(?i)` or `str_to_lower()`)
4.  Extract any URLs from the tweets
5.  Create a new column with the text cleaned of URLs and mentions

``` r
### Your workspace
# Load the data if needed
url <- "https://raw.githubusercontent.com/aysedeniz09/Social_Media_Listening/refs/heads/main/MSC_social_media_list_data/Starbucks_User_Data.csv"
starbucks <- read_csv(url)

# 1. Extract mentions


# 2. Count hashtag tweets


# 3. Find coffee tweets


# 4. Extract URLs


# 5. Clean text
```

------------------------------------------------------------------------

## Lecture 2 Cheat Sheet

| **Topic** | **Key Points** |
|----|----|
| **File Paths** | Use relative paths (e.g., `"data/file.csv"`). Use `../` to go up one directory level. Always use projects to set working directory automatically. |
| **Data Import** | `read_csv()`, `read_excel()`, `read_delim()` for different file types. Use `col_types` to specify column types. |
| **Tibbles** | Modern data frames with better printing and subsetting. Create with `tibble()` or `tribble()`. Convert with `as_tibble()`. |
| **Pipe Operator** | `|>` or `%>%` chains operations together. Shortcut: Cmd/Ctrl + Shift + M. |
| **Tidy Data** | Each variable in a column, each observation in a row, each value in a cell. |
| **DPLYR Functions** | `filter()`: rows by condition; `select()`: columns; `mutate()`: create/transform; `summarize()`: aggregate; `group_by()`: group operations; `arrange()`: sort; `rename()`: rename columns. |
| **Data Reshaping** | `pivot_longer()`: wide → long; `pivot_wider()`: long → wide. |
| **Split/Combine** | `separate()`: split column into multiple; `unite()`: combine columns into one. |
| **Missing Values** | `drop_na()`: remove NA rows; `fill()`: fill NA with adjacent values; `replace_na()`: replace NA with specific value. |
| **Expand Tables** | `expand()`: all combinations; `complete()`: add missing combinations with NA. |
| **Joins** | `left_join()`: keep all left; `right_join()`: keep all right; `inner_join()`: only matches; `full_join()`: keep all; `anti_join()`: non-matches. |
| **Regex Basics** | `.` any char; `^` start; `$` end; `*` zero+; `+` one+; `?` zero/one; `[]` character class; `\\d` digit; `\\w` word char; `\\s` whitespace. |
| **stringr Functions** | `str_detect()`: check pattern; `str_extract()`: get match; `str_replace()`: replace match; `str_match()`: extract groups; `str_subset()`: filter by pattern. |
