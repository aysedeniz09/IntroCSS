Computational Research
================
Dr. Ayse D. Lokmanoglu
Lecture 3, (B) Feb 5, (A) Feb 10

## R Exercises

------------------------------------------------------------------------

## Keyword in Context (KWIC)

- Keyword in Context (KWIC) extracts and analyzes how specific keywords
  appear in text along with their surrounding context.
- Why Use KWIC?
  - Identify patterns in text data.
  - Analyze how keywords are used in specific contexts.
  - Useful for sentiment analysis, trend identification, and content
    understanding.

------------------------------------------------------------------------

#### Let’s practice

Dataset: Jane Austen Books We will use regular expression from last
class

``` r
install.packages("janeaustenr", "tidytext", "stringr")
```

``` r
library(janeaustenr)
library(dplyr)
library(tidytext)
library(stringr)
library(tidyverse)

# Combine all books into a single dataframe
original_books <- austen_books() |> 
  group_by(book) |> 
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, # cumulative sum
                                     regex("^chapter [\\divxlc]",
                                           ignore_case = TRUE)))) |> 
  ungroup()
head(original_books)
```

    ## # A tibble: 6 × 4
    ##   text                    book                linenumber chapter
    ##   <chr>                   <fct>                    <int>   <int>
    ## 1 "SENSE AND SENSIBILITY" Sense & Sensibility          1       0
    ## 2 ""                      Sense & Sensibility          2       0
    ## 3 "by Jane Austen"        Sense & Sensibility          3       0
    ## 4 ""                      Sense & Sensibility          4       0
    ## 5 "(1811)"                Sense & Sensibility          5       0
    ## 6 ""                      Sense & Sensibility          6       0

------------------------------------------------------------------------

### Extracting Keywords

Extract all text that has “family” in it.

``` r
filtered_text <- original_books |> 
  filter(str_detect(text, "family"))

head(filtered_text)
```

    ## # A tibble: 6 × 4
    ##   text                                                  book  linenumber chapter
    ##   <chr>                                                 <fct>      <int>   <int>
    ## 1 The family of Dashwood had long been settled in Suss… Sens…         13       1
    ## 2 into his house the family of his nephew Mr. Henry Da… Sens…         22       1
    ## 3 family; but he was affected by a recommendation of s… Sens…         79       1
    ## 4 any of her husband's family; but she had had no oppo… Sens…        116       1
    ## 5 large a sum was parted with.  If he should have a nu… Sens…        223       2
    ## 6 of her character, which half a year's residence in h… Sens…        398       3

------------------------------------------------------------------------

### Extract Surrounding Context

Let’s extract 10 characters before and after “family”

``` r
# Extract 10 characters before and after "family"
context <- original_books |>
  filter(str_detect(text, "family")) |>
  mutate(context = str_extract(text, ".{0,10}family.{0,10}"))

head(context$context)
```

    ## [1] "The family of Dashwo"       "house the family of his ne"
    ## [3] "family; but he w"           "husband's family; but she "
    ## [5] " numerous family, for"      "ce in her family afforded;"

------------------------------------------------------------------------

### Let’s practice with a real world example!

Download starbucks data from github

Using URL

``` r
library(readr)

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

1\. Let’s look at the column names, does it have a text column?

``` r
colnames(starbucks_user_data)
```

    ##  [1] "author_id"            "conversation_id"      "created_at"          
    ##  [4] "hashtag"              "lang"                 "like_count"          
    ##  [7] "mention"              "quote_count"          "referenced_status_id"
    ## [10] "referenced_user_id"   "reply_count"          "retweet_count"       
    ## [13] "row_id"               "status_id"            "text"                
    ## [16] "type"

------------------------------------------------------------------------

#### Let’s find a keyword we are interested in

How about coffee? You can play with different words - we will come to
this dataset again

``` r
filtered_text <- starbucks_user_data |> 
  filter(str_detect(text, "coffee"))

head(filtered_text$text)
```

    ## [1] "@_khaadijaa Holiday sugar cookies + coffee = 💚"                                                                                                                                                                                                                       
    ## [2] "@T_michelle001 Have you tried our Chestnut Praline Frappuccino® Blended Beverage? Festive flavors of caramelized chestnuts and spices blend with Frappuccino® Roast coffee, milk and ice, topped with whipped cream and spiced praline crumbs. https://t.co/jNvH68BSk4"
    ## [3] "@luckygirl2k1 Cheers to iced coffee breaks!"                                                                                                                                                                                                                           
    ## [4] "@dulce__vida You deserve a you + coffee moment! 💚"                                                                                                                                                                                                                    
    ## [5] "@vanillacoffeegf A delicious drink for a great day! 😋"                                                                                                                                                                                                                
    ## [6] "@hollowaydrewthe Hey Drew! Our cold brew is made with a custom blend of coffee beans cold steeped for 20+ hours to create a concentrate. We then add water and your choice of milk and other customizations to bring you the delicious cup that you love!"

------------------------------------------------------------------------

### Tokenizing Text with `unnest_tokens()`

- Tokenization is the process of breaking text into smaller units, such
  as words, sentences, or phrases.
- Helps in analyzing text data by standardizing and simplifying its
  structure.
- `unnest_tokens()` is a function from the [`tidytext`
  package](https://github.com/juliasilge/tidytext).
- Converts a column of text into individual tokens (e.g., words or
  sentences).
- Removes punctuation and converts text to lowercase by default.

`unnest_token()` syntax:

``` r
unnest_tokens(output, input, token = "words", ...)
```

- `output`: The name of the column for the tokens.
- `input`: The name of the column containing the text.
- `token`: The unit for tokenization (default is “`words`”).
  - Options: “`words`”, “`sentences`”, “`lines`”, “`n-grams`”.
- Additional arguments control behavior (e.g., removing stop words). (we
  will come to this later)

------------------------------------------------------------------------

### Unnest tokens in Jane Austen books

Now we have a word column for each word of the text!

``` r
tidy_books <- original_books |> 
  unnest_tokens(word, text)

head(tidy_books)
```

    ## # A tibble: 6 × 4
    ##   book                linenumber chapter word       
    ##   <fct>                    <int>   <int> <chr>      
    ## 1 Sense & Sensibility          1       0 sense      
    ## 2 Sense & Sensibility          1       0 and        
    ## 3 Sense & Sensibility          1       0 sensibility
    ## 4 Sense & Sensibility          3       0 by         
    ## 5 Sense & Sensibility          3       0 jane       
    ## 6 Sense & Sensibility          3       0 austen

------------------------------------------------------------------------

### Count Keyword Occurrences

Let’s count how many times “family” is said in Jane Austen Books

``` r
# Count the occurrences of "family"
keyword_count <- tidy_books |> 
  filter(word == "family") |>
  count(word)

print(keyword_count)
```

    ## # A tibble: 1 × 2
    ##   word       n
    ##   <chr>  <int>
    ## 1 family   578

We can also use <mark>regex</mark> from Lecture 1 to find words with
patterns

``` r
# Count the occurrences of "family"
mr_words <- original_books |> 
  filter(str_detect(text, "Mr\\.\\s\\w+")) |> 
  mutate(after_mr = str_extract(text, "Mr\\.\\s\\w+")) ### I created a new column that combined the word after mr. with mr

head(mr_words$after_mr)
```

    ## [1] "Mr. Henry"    "Mr. and"      "Mr. Henry"    "Mr. Dashwood" "Mr. Dashwood"
    ## [6] "Mr. John"

``` r
### To count

mr_words |> count(after_mr, sort = TRUE)
```

    ## # A tibble: 92 × 2
    ##    after_mr          n
    ##    <chr>         <int>
    ##  1 Mr. Darcy       254
    ##  2 Mr. Knightley   251
    ##  3 Mr. Elton       199
    ##  4 Mr. Crawford    171
    ##  5 Mr. Weston      147
    ##  6 Mr. Collins     137
    ##  7 Mr. Woodhouse   117
    ##  8 Mr. Rushworth   112
    ##  9 Mr. Bingley     100
    ## 10 Mr. Bennet       82
    ## # ℹ 82 more rows

------------------------------------------------------------------------

### Class Exercises:

Use the Starbucks Twitter dataset —-\> `starbucks_user_data`.

1.  Extract user names that start with @ —-\> mentions, find the most
    mentioned username.

2.  Find the minimum and maximum date from `created_at` column.

3.  Create a new `date` column with just Year-Month-Date using
    `lubridate` package.

4.  Extract years from the new `date` column

------------------------------------------------------------------------

## Matrix

A matrix is a two-dimensional data structure that stores elements of the
same data type (numeric, character, logical, etc.) arranged in rows and
columns. - Essentially, it’s like a table where all the values are of
the same kind.

Syntax: `matrix(data, nrow, ncol, byrow, dimnames)`

- `data`: Input vectors as data elements of the matrix

- `nrow`: The number of rows that are to be created

- `ncol`: The number of columns that are to be created

- `byrow`: This parameter is a logical argument. If it is true then the
  vector elements are arranged by row.

- `dimnames`: This parameter assigns a name to row and column

e.g.,

``` r
M = matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3, ncol = 3, byrow = TRUE) 
cat("The 3x3 matrix:\n") 
```

    ## The 3x3 matrix:

``` r
print(M)
```

    ##      [,1] [,2] [,3]
    ## [1,]    1    2    3
    ## [2,]    4    5    6
    ## [3,]    7    8    9

------------------------------------------------------------------------

## Term-Document Matrix (TDM)

A Term-Document Matrix (TDM) is a table where:

- Rows represent terms (words).

- Columns represent documents (e.g., books, reviews).

- Values indicate the frequency of terms in each document.

- Useful for:

  - Analyzing term frequency.

  - Comparing text documents.

  - Building text classification and clustering models.

e.g,

|      | words1 | words2 | words3 | words4 | words5 |
|------|--------|--------|--------|--------|--------|
| doc1 | 0      | 0      | 1      | 0      | 0      |
| doc2 | 2      | 0      | 1      | 1      | 0      |
| doc3 | 0      | 0      | 1      | 1      | 0      |
| doc4 | 0      | 0      | 1      | 1      | 1      |

------------------------------------------------------------------------

## Creating a Term-Document Matrix

``` r
# Create a Term-Document Matrix
tdm <- original_books |> 
  unnest_tokens(word, text) |> 
  count(book, word) |> 
  cast_dtm(document = book, term = word, value = n)

str(tdm)
```

    ## List of 6
    ##  $ i       : int [1:40379] 1 2 5 6 1 2 3 5 6 1 ...
    ##  $ j       : int [1:40379] 1 1 1 1 2 2 2 2 2 3 ...
    ##  $ v       : num [1:40379] 2 1 1 3 1 1 3 1 1 1 ...
    ##  $ nrow    : int 6
    ##  $ ncol    : int 14520
    ##  $ dimnames:List of 2
    ##   ..$ Docs : chr [1:6] "Sense & Sensibility" "Pride & Prejudice" "Mansfield Park" "Emma" ...
    ##   ..$ Terms: chr [1:14520] "1" "10" "11" "12" ...
    ##  - attr(*, "class")= chr [1:2] "DocumentTermMatrix" "simple_triplet_matrix"
    ##  - attr(*, "weighting")= chr [1:2] "term frequency" "tf"

------------------------------------------------------------------------

## Visualizing the TDM

Let’s visualize top words

``` r
top_words <- original_books |> 
  unnest_tokens(word, text) |> 
  count(book, word, sort = TRUE) |> 
  group_by(book) |> 
  slice_max(n, n = 10)

head(top_words)
```

    ## # A tibble: 6 × 3
    ## # Groups:   book [1]
    ##   book                word      n
    ##   <fct>               <chr> <int>
    ## 1 Sense & Sensibility to     4116
    ## 2 Sense & Sensibility the    4105
    ## 3 Sense & Sensibility of     3571
    ## 4 Sense & Sensibility and    3490
    ## 5 Sense & Sensibility her    2543
    ## 6 Sense & Sensibility a      2092

``` r
library(ggplot2)

ggplot(top_words, aes(x = reorder(word, n), y = n, fill = book)) +
  geom_col(show.legend = TRUE) +
  labs(
    title = "Top 10 Words in Each Book",
    x = "Word",
    y = "Frequency"
  ) +
  theme_minimal()
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

------------------------------------------------------------------------

## Stop words

Stopwords are commonly used words in a language (e.g., “the,” “and,”
“of”) that:

- Add little or no meaning to text analysis.

- Are often removed to focus on meaningful terms.

<mark>**We remove stopwords from text analysis**</mark>

- Stopwords can overshadow important terms in text analysis.

- Removing them improves:

  - Keyword extraction.

  - Sentiment analysis.

  - Topic modeling.

------------------------------------------------------------------------

## Let’s see stopwords

``` r
head(stop_words)
```

    ## # A tibble: 6 × 2
    ##   word      lexicon
    ##   <chr>     <chr>  
    ## 1 a         SMART  
    ## 2 a's       SMART  
    ## 3 able      SMART  
    ## 4 about     SMART  
    ## 5 above     SMART  
    ## 6 according SMART

We can also get in [other
languages](https://www.r-bloggers.com/2018/05/a-tidytext-analysis-of-3-chinese-classics/):

``` r
head(stopwords::stopwords("zh"))
```

    ## [1] "按"   "按照" "俺"   "们"   "阿"   "别"

------------------------------------------------------------------------

## Remove stopwords from our top words

``` r
cleaned_words <- original_books |> 
  unnest_tokens(word, text) |> 
  anti_join(stop_words, by = "word") |> ## removing stopwords
  count(word, sort = TRUE)

head(cleaned_words)
```

    ## # A tibble: 6 × 2
    ##   word      n
    ##   <chr> <int>
    ## 1 miss   1855
    ## 2 time   1337
    ## 3 fanny   862
    ## 4 dear    822
    ## 5 lady    817
    ## 6 sir     806

------------------------------------------------------------------------

## Let’s visualize again

``` r
top_words <- original_books |> 
  unnest_tokens(word, text) |> 
  anti_join(stop_words, by = "word") |> ## removing stopwords
  count(book, word, sort = TRUE) |> 
  group_by(book) |> 
  slice_max(n, n = 5)

ggplot(top_words, aes(x = reorder(word, n), y = n, fill = book)) +
  geom_col(show.legend = TRUE) +
  coord_flip() + # we flipped it to make it look better
  labs(
    title = "Top 10 Words in Each Book",
    x = "Word",
    y = "Frequency"
  ) +
  theme_minimal()
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-19-1.png)<!-- -->

------------------------------------------------------------------------

### TF-IDF (Term frequency (TF) - Inverse document frequency (IDF))

- The calculation of how relevant a word in a series or corpus is to a
  text. So is a statistical measure used to evaluate:
  - Term Frequency (TF): How often a term appears in a document.
  - Inverse Document Frequency (IDF): How unique or rare a term is
    across all documents.
- Highlights distinguishing words for specific documents or topics.
- Identifies unique terms in specific documents.
- Reduces the influence of common terms like stopwords that occur
  frequently across all documents.

------------------------------------------------------------------------

### TF-IDF Formula

1\. Term Frequency (TF): Measures how often a term *t* appears in a
document *d*.
$$\text{TF}(t, d) = \frac{\text{Number of occurrences of term } t \text{ in document } d}{\text{Total number of terms in document } d}$$

2\. Inverse Document Frequency (IDF): Measures how unique or rare a term
*t* is across all documents in the corpus.
$$\text{IDF}(t) = \text{log} \left( \frac{\text{Total number of documents}}{\text{Number of documents containing } t} \right)$$
e.g., Common words like “the” or “and” have a low IDF because they
appear in many documents. Rare words like “quantum” or “asymptote” have
a high IDF because they appear in fewer documents.

3\. TF-IDF Formula:
$$\text{TF-IDF}(t, d) = \text{TF}(t, d) \times \text{log} \left( \frac{\text{Total number of documents}}{\text{Number of documents containing } t} \right)$$

**High TF-IDF: Indicates terms that are important to the specific
document *d* but not common across the corpus.** **Low TF-IDF: Indicates
terms that are either not important to the document or common across the
corpus.**

We’ll use the [`tidytext`
package](https://cran.r-project.org/web/packages/tidytext/vignettes/tidytext.html)
to augment our Term-Document Matrix (TDM) with TF-IDF values.

------------------------------------------------------------------------

### Let’s practice with Jane Austen

``` r
library(tidytext)

# Create Term Frequency
tdm <- original_books |> 
  unnest_tokens(word, text) |> 
  count(book, word, sort = TRUE)

# Calculate TF-IDF
tdm_tfidf <- tdm |> 
  bind_tf_idf(word, book, n) |> 
  arrange(-n)

head(tdm_tfidf)
```

    ## # A tibble: 6 × 6
    ##   book           word      n     tf   idf tf_idf
    ##   <fct>          <chr> <int>  <dbl> <dbl>  <dbl>
    ## 1 Mansfield Park the    6206 0.0387     0      0
    ## 2 Mansfield Park to     5475 0.0341     0      0
    ## 3 Mansfield Park and    5438 0.0339     0      0
    ## 4 Emma           to     5239 0.0325     0      0
    ## 5 Emma           the    5201 0.0323     0      0
    ## 6 Emma           and    4896 0.0304     0      0

------------------------------------------------------------------------

### What Does TF-IDF Tell Us?

- Words with high TF-IDF scores:

  - Are frequent in a specific document.

  - Are rare across other documents.

- Words with low TF-IDF scores:

  - Are common across all documents.

So…. let’s remove stopwords and try again

------------------------------------------------------------------------

``` r
library(tidytext)

# Create Term Frequency
tdm <- original_books |> 
  unnest_tokens(word, text) |> 
  anti_join(stop_words, by = "word") |> ## removing stopwords
  count(book, word, sort = TRUE)

# Calculate TF-IDF
tdm_tfidf <- tdm |> 
  bind_tf_idf(word, book, n) |> 
  arrange(-n)

head(tdm_tfidf)
```

    ## # A tibble: 6 × 6
    ##   book                word          n     tf   idf tf_idf
    ##   <fct>               <chr>     <int>  <dbl> <dbl>  <dbl>
    ## 1 Mansfield Park      fanny       816 0.0170 0.693 0.0118
    ## 2 Emma                emma        786 0.0168 1.10  0.0185
    ## 3 Sense & Sensibility elinor      623 0.0171 1.79  0.0307
    ## 4 Emma                miss        599 0.0128 0     0     
    ## 5 Pride & Prejudice   elizabeth   597 0.0160 0.693 0.0111
    ## 6 Mansfield Park      crawford    493 0.0103 1.79  0.0184

------------------------------------------------------------------------

### Let’s visualize it

``` r
# Filter top terms per document
top_tfidf <- tdm_tfidf |> 
  group_by(book) |> 
  slice_max(tf_idf, n = 5)

# Visualize
library(ggplot2)
ggplot(top_tfidf, aes(x = reorder(word, tf_idf), y = tf_idf, fill = book)) +
  geom_col(show.legend = TRUE) +
  labs(
    title = "Top Words by TF-IDF Score",
    x = "Word",
    y = "TF-IDF"
  ) +
  coord_flip() +
  theme_minimal()
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-22-1.png)<!-- -->

------------------------------------------------------------------------

### Class Exercise

Use the Starbucks dataset (starbucks_user_data):

1.  Create a Term Frequency table.

2.  Augment it with TF-IDF scores.

3.  Identify:

    - a\. The top 5 unique terms for each user.

    - Which terms distinguish highly retweeted tweets.

4.  Visualize - Plot the top TF-IDF terms for tweets from Starbucks.

``` r
# Example solution starter code
library(dplyr)
library(ggplot2)
library(tidytext)

# Calculate TF-IDF
starbucks_tfidf <- starbucks_user_data |> 
  unnest_tokens(word, text) |> 
  anti_join(stop_words, by = "word") |> ## removing stopwords
  count(mention, word, sort = TRUE) |> 
  bind_tf_idf(word, mention, n)

# Select the top 5 mentions based on total term frequency
top_mentions <- starbucks_tfidf |> 
  group_by(mention) |> 
  summarize(total_n = sum(n)) |> 
  arrange(desc(total_n)) |> 
  slice_max(total_n, n = 5, with_ties = FALSE) |> 
  pull(mention)

# Filter data for top mentions and calculate top words
top_tfidf_starbucks <- starbucks_tfidf |> 
  filter(mention %in% top_mentions) |> 
  group_by(mention) |> 
  slice_max(tf_idf, n = 5, with_ties = FALSE) |>  # Use with_ties = FALSE to avoid duplicates
  ungroup()

# Visualize top words for top 5 mentions
ggplot(top_tfidf_starbucks, aes(x = reorder(word, tf_idf), y = tf_idf, fill = mention)) +
  geom_col(show.legend = TRUE) +
  labs(
    title = "Top Words by TF-IDF for Top 5 Mentions in Starbucks Data",
    x = "Word",
    y = "TF-IDF"
  ) +
  coord_flip() +
  theme_minimal()
```

------------------------------------------------------------------------

## Colors and GGplot

| Function | Purpose | Plot Type |
|----|----|----|
| `scale_fill_manual()` | Manually set colors for the **fill aesthetic** | Bar, Tile |
| `scale_color_manual()` | Manually set colors for the **color aesthetic** | Scatter, Line |
| `scale_fill_brewer()` | Use a **ColorBrewer** palette for fills | Bar, Tile |
| `scale_color_brewer()` | Use a **ColorBrewer** palette for colors | Scatter, Line |
| `scale_fill_gradient()` | Create a continuous gradient for fills | Tile |
| `scale_color_gradient()` | Create a continuous gradient for colors | Scatter, Line |
| `scale_fill_gradient2()` | Create a diverging gradient for fills | Tile |
| `scale_color_gradient2()` | Create a diverging gradient for colors | Scatter, Line |
| `scale_fill_viridis_d()` | Use Viridis discrete color palette for fills | Bar, Tile |
| `scale_color_viridis_d()` | Use Viridis discrete color palette for colors | Scatter, Line |
| `scale_fill_viridis_c()` | Use Viridis continuous color palette for fills | Tile |
| `scale_color_viridis_c()` | Use Viridis continuous color palette for colors | Scatter, Line |

------------------------------------------------------------------------

## Customizing colors and other fun packages to use for ggplot and wordclouds

R has fun color packages:

- [RColorBrewer](https://r-graph-gallery.com/38-rcolorbrewers-palettes.html)
  `library(RColorBrewer)`

- [Viridis](https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html)
  `library(viridis)`

- [wesanderson](https://github.com/karthik/wesanderson)
  `install.packages("wesanderson")`

``` r
library(wesanderson)
names(wes_palettes)
```

    ##  [1] "BottleRocket1"     "BottleRocket2"     "Rushmore1"        
    ##  [4] "Rushmore"          "Royal1"            "Royal2"           
    ##  [7] "Zissou1"           "Zissou1Continuous" "Darjeeling1"      
    ## [10] "Darjeeling2"       "Chevalier1"        "FantasticFox1"    
    ## [13] "Moonrise1"         "Moonrise2"         "Moonrise3"        
    ## [16] "Cavalcanti1"       "GrandBudapest1"    "GrandBudapest2"   
    ## [19] "IsleofDogs1"       "IsleofDogs2"       "FrenchDispatch"   
    ## [22] "AsteroidCity1"     "AsteroidCity2"     "AsteroidCity3"

- [natparkpalettes](https://github.com/kevinsblake/NatParksPalettes)
  `install.packages("NatParksPalettes")`

``` r
library(NatParksPalettes)
names(NatParksPalettes)
```

    ##  [1] "Acadia"      "Arches"      "Arches2"     "Banff"       "BryceCanyon"
    ##  [6] "CapitolReef" "Charmonix"   "CraterLake"  "Cuyahoga"    "DeathValley"
    ## [11] "Denali"      "Everglades"  "Glacier"     "GrandCanyon" "Halekala"   
    ## [16] "IguazuFalls" "KingsCanyon" "LakeNakuru"  "Olympic"     "Redwood"    
    ## [21] "RockyMtn"    "Saguaro"     "SmokyMtns"   "SouthDowns"  "Torres"     
    ## [26] "Triglav"     "WindCave"    "Volcanoes"   "Yellowstone" "Yosemite"

------------------------------------------------------------------------

## `scale_fill_manual()`

``` r
ggplot(data = mtcars, aes(x = factor(cyl), fill = factor(gear))) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("red", "blue", "green")) +
  labs(title = "Custom Colors Example (fill)")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-26-1.png)<!-- -->

------------------------------------------------------------------------

## `scale_fill_manual()` using `NatParksPalettes`

``` r
ggplot(data = mtcars, aes(x = factor(cyl), fill = factor(gear))) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = natparks.pals("Yellowstone", n = 3, type = "discrete")) +
  labs(title = "Custom Color with National Park (fill)")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

------------------------------------------------------------------------

## `scale_color_manual()`

``` r
ggplot(data = mtcars, aes(x = wt, y = mpg, color = factor(gear))) +
  geom_point(size = 4) +
  scale_color_manual(values = c("purple", "orange", "cyan")) +
  labs(title = "Custom Color Example (color)")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-28-1.png)<!-- -->

------------------------------------------------------------------------

## `scale_color_manual()` using `wesanderson` palette

``` r
# Scatter plot using Wes Anderson palette
ggplot(data = mtcars, aes(x = wt, y = mpg, color = factor(gear))) +
  geom_point(size = 4) +
  scale_color_manual(values = wes_palette("Zissou1", n = 3, type = "continuous")) +
  labs(title = "Custom Colors with Wes Anderson (color)")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-29-1.png)<!-- -->

------------------------------------------------------------------------

## `scale_fill_brewer()`

``` r
ggplot(data = mtcars, aes(x = factor(cyl), fill = factor(gear))) +
  geom_bar(position = "dodge") +
  scale_fill_brewer(palette = "Set3") +
  labs(title = "ColorBrewer Palette Example (fill)")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-30-1.png)<!-- -->

------------------------------------------------------------------------

## `scale_fill_gradient()`

``` r
ggplot(data = mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point(size = 4) +
  scale_color_gradient(low = "yellow", high = "red") +
  labs(
    title = "Continuous Gradient Example (fill)",
    x = "Weight",
    y = "Miles Per Gallon"
  )
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-31-1.png)<!-- -->

------------------------------------------------------------------------

## `scale_color_gradient()`

``` r
# Continuous gradient for color
ggplot(data = mtcars, aes(x = wt, y = mpg, color = hp)) +
  geom_point(size = 4) +
  scale_color_gradient(low = "blue", high = "green") +
  labs(title = "Continuous Gradient Example (color)")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-32-1.png)<!-- -->

------------------------------------------------------------------------

## Diverging Gradients `scale_fill_gradient2()` and `scale_color_gradient2()`

``` r
# Diverging gradient for fill
ggplot(data = mtcars, aes(x = wt, y = mpg, fill = hp)) +
  geom_point(size = 4) +
  scale_color_gradient2(low = "blue", mid = "white", high = "red", midpoint = 150) +
  labs(title = "Diverging Gradient Example (color)")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-33-1.png)<!-- -->

------------------------------------------------------------------------

### Now let’s test it back on our top words

``` r
# Plot with Wes Anderson color palette
ggplot(top_words, aes(x = reorder(word, n), y = n, fill = book)) +
  geom_col(show.legend = TRUE) +
  scale_fill_manual(values = wes_palette("Zissou1", n = length(unique(top_words$book)), type = "continuous")) +
  labs(
    title = "Top 10 Words in Each Book",
    x = "Word",
    y = "Frequency",
    fill = "Book"
  ) +
  coord_flip() +
  theme_minimal()
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-34-1.png)<!-- -->

------------------------------------------------------------------------

## Word Clouds

A word cloud is a visualization of text data where:

- Words are displayed in varying sizes.

- The size of each word corresponds to its frequency or importance in
  the dataset.

- WC’s provide provides an at-a-glance understanding of the most
  frequent terms in a corpus.

- WC’s Useful for identifying key themes or topics in text data.

- WC’s Easy to share and interpret in presentations or reports.

We need the [`wordcloud2`
package](https://github.com/Lchiffon/wordcloud2),
`install.packages("wordcloud2")`

``` r
library(wordcloud2)
```

------------------------------------------------------------------------

Let’s try with Jane Austen dataset

``` r
# Example dataset: Jane Austen books
word_freq <- original_books |>
  unnest_tokens(word, text) |>
  count(word, sort = TRUE)
```

``` r
# Generate the word cloud
wordcloud2(data = word_freq, size = 0.5)
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-37-1.png)<!-- -->

------------------------------------------------------------------------

## let’s redo it with removing stopwords

``` r
# Example dataset: Jane Austen books
word_freq <- original_books |>
  unnest_tokens(word, text) |>
  anti_join(stop_words, by = "word") |> ## removing stopwords
  count(word, sort = TRUE)

# Generate the word cloud
wordcloud2(data = word_freq, size = 0.5)
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-38-1.png)<!-- -->

------------------------------------------------------------------------

## Customize word clouds

| Customization | Functionality | Example Code |
|----|----|----|
| **Set Maximum Words** | Limit the number of words displayed in the word cloud. | `max.words = 50` |
| **Change Color Palette** | Use a predefined or custom color palette for the word cloud. | `colors = brewer.pal(8, "Set3")` |
| **Scale Word Size** | Adjust the range of font sizes used in the word cloud. | `scale = c(4, 0.5)` |
| **Filter Stop Words** | Remove common stop words (e.g., “the”, “and”) from the dataset. | `anti_join(stop_words)` |
| **Set Rotation** | Rotate some words to create a dynamic effect. | `rot.per = 0.3` |
| **Define Shape** | Fit the word cloud into specific shapes (e.g., circle, square). | `wordcloud2` package |

------------------------------------------------------------------------

## WC: Change Color Palettes

``` r
wordcloud2(data = word_freq, size = 0.5, color = "random-light")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-39-1.png)<!-- -->

``` r
# Use dark random colors
# wordcloud2(data = word_freq, size = 0.5, color = "random-dark")

library(RColorBrewer)

# Custom color palette
# custom_colors <- brewer.pal(8, "Set3")
# wordcloud2(data = word_freq, size = 0.5, color = custom_colors)
```

------------------------------------------------------------------------

## WC: Scale Word Sizes

Adjust the range of font sizes `size` for words.

``` r
wordcloud2(data = word_freq, size = 1) # Larger words
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-40-1.png)<!-- -->

``` r
wordcloud2(data = word_freq, size = 0.3) # Smaller words
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-41-1.png)<!-- -->

------------------------------------------------------------------------

## WC: Rotate Words

Add rotation `minRotation`, `maxRotation` or `rotateRatio` for a dynamic
visual effect.

``` r
wordcloud2(data = word_freq, size = 0.5, minRotation = -pi/4, maxRotation = pi/4, rotateRatio = 0.3)
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-42-1.png)<!-- -->

------------------------------------------------------------------------

## WC: Custom Background

``` r
wordcloud2(data = word_freq, size = 0.5, color = "random-light", backgroundColor = "black")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-43-1.png)<!-- -->

------------------------------------------------------------------------

## WC: Add Shapes

``` r
# Circle shape
# wordcloud2(data = word_freq, size = 0.5, shape = "circle")

# Star shape
wordcloud2(data = word_freq, size = 0.5, shape = "star")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-44-1.png)<!-- -->

``` r
# Triangle shape

yellow_palette <- c("#FFFF00", "#FFD700", "#FFEC8B", "#FFFACD", "#FFF68F")

# Create the word cloud
wordcloud2(
  data = word_freq,
  size = 0.2,
  shape = "triangle",
  backgroundColor = "#FF1493",
  color = yellow_palette
)
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-45-1.png)<!-- -->

------------------------------------------------------------------------

## WC: Chinese version

``` r
## Sys.setlocale("LC_CTYPE","eng")
wordcloud2(demoFreqC, size = 2, fontFamily = "微软雅黑",
           color = "random-light", backgroundColor = "grey")
```

![](bigdata_Lecture3_files/figure-gfm/unnamed-chunk-46-1.png)<!-- -->

------------------------------------------------------------------------

## How to save word clouds

``` r
# Load required libraries
library(wordcloud2)
library(webshot)
webshot::install_phantomjs()
library(htmlwidgets)

# Create a word cloud
my_graph <- wordcloud2(word_freq, size = 1.5)

# Save as HTML
saveWidget(my_graph, "tmp.html", selfcontained = F)

# Save as PDF
webshot("tmp.html", "fig_1.pdf", delay = 5, vwidth = 480, vheight = 480)

# Save as PNG
webshot("tmp.html", "fig_1.png", delay = 5, vwidth = 480, vheight = 480)
```

------------------------------------------------------------------------

### Class Exercise

1.  Load the Billboard dataset `head(billboard)`, which contains
    historical chart data for popular songs.
2.  Extract the `track` column, which contains song titles.
3.  Tokenize the song titles into individual words and count word
    frequencies.
4.  Generate a basic word cloud to visualize the most commonly used
    words in Billboard song titles.
5.  Filter out common stop words.
6.  Generate a refined word cloud after removing stop words and discuss
    the differences from the original version.
7.  Adjust the font size scale to emphasize frequently occurring words.
8.  Change the colors to use a predefined color palette instead of
    random colors.
9.  Modify the background color for better contrast and readability.
10. Add word rotation to create a dynamic visual effect.
11. Modify the shape of the word cloud to `circle`, or `star` to make it
    visually engaging.

#### Bonus

12. Filter the Billboard dataset by decade (e.g., songs from the 1990s
    vs. 2000s).
13. Generate separate word clouds for different time periods using
    `date.entered` column and extracting year using `lubridate`’s
    `year()` and compare the most frequent words in song titles.

------------------------------------------------------------------------

### Lecture 3 Cheat Sheet

| **Task** | **Description** | **Code Example** |
|----|----|----|
| Tokenizing Text | Splitting text into smaller units (words, sentences, etc.) | `unnest_tokens(output, input, token = 'words')` |
| Remove Stopwords | Removing common words that add little meaning (e.g., ‘the’, ‘and’) | `anti_join(stop_words, by = 'word')` |
| Calculate Term Frequency | Counting occurrences of words in a dataset | `count(column_name, sort = TRUE)` |
| TF-IDF | Measuring word importance across documents | `bind_tf_idf(word, document, n)` |
| Top Words by TF-IDF | Extracting unique/distinguishing words in a document using TF-IDF | `slice_max(tf_idf, n = 5)` |
| Regex | Pattern matching for text | `filter(str_detect(text, 'pattern'))` |
| Plot Word Frequencies | Visualizing word counts with ggplot | `geom_col(show.legend = TRUE)` |
| Customize ggplot Colors | Manually set colors for fill or line aesthetics (e.g., scale_fill_manual, scale_color_manual) | `scale_fill_manual(values = c('red', 'blue', 'green'))` |
| Use ggplot Gradients | Create continuous or diverging gradients for fills and colors (e.g., scale_fill_gradient2, scale_color_gradient2) | `scale_fill_gradient2(low = 'blue', mid = 'white', high = 'red', midpoint = 0.5)` |
| Create Word Clouds | Visualizing text data with word sizes | `wordcloud2(data, size = 0.5)` |
| Save Plots | Save plots as PNG/PDF | `ggsave('filename.png', plot)` |
| Extract Context | Extracting characters before/after a keyword | `mutate(context = str_extract(text, '.{0,10}keyword.{0,10}'))` |
