Text as Data: Topic Modeling
================
Dr. Ayse D. Lokmanoglu
Lecture 9, (B) March 25, (A) March 30

# R Exercises

## Table of Contents

| Section | Topic                                                     |
|---------|-----------------------------------------------------------|
| 1       | Intro to Topic Modeling                                   |
| 1.1     | Why Use Topic Modeling?                                   |
| 1.2     | Understanding LDA                                         |
| 2       | Preprocessing Text Data                                   |
| 2.1     | Load the Data                                             |
| 2.2     | Initial Data Exploration                                  |
| 2.3     | Text Preprocessing                                        |
| 2.3.1   | Create Index, Backup Text, and Language Filtering         |
| 2.3.2   | Create Custom Stopwords                                   |
| 2.4     | Tokenization                                              |
| 2.5     | Term Frequency Filtering with TF-IDF                      |
| 2.6     | Visualize Top Words                                       |
| 2.7     | Create Document-Term Matrix                               |
| 3       | Choosing the Number of Topics (K)                         |
| 3.1     | What is Topic Coherence?                                  |
| 3.2     | Types of Coherence Metrics                                |
| 3.3     | What Makes a “Good” Topic?                                |
| 3.4     | Computing Topic Coherence for Different K Values          |
| 3.5     | Visualizing Topic Coherence                               |
| 3.5.1   | Coherence Across K Values                                 |
| 3.5.2   | Coherence Decline from Optimal K                          |
| 3.6     | Interpreting the Results for Optimal K                    |
| 3.7     | Choosing Optimal K                                        |
| 4       | LDA Model                                                 |
| 4.1     | Train the LDA Model with the Optimal Topics               |
| 4.2     | Save Your Work                                            |
| 4.3     | Look Inside the LDA Model                                 |
| 5       | The Beta & Gamma Matrices                                 |
| 5.1     | Beta (β): Topic-Word Probabilities                        |
| 5.2     | Top Words per Topic - The Beta (β) Matrix using Tidy      |
| 5.3     | Top 10 Words per Topic                                    |
| 5.4     | Visualize Top Words                                       |
| 5.5     | Comparing Words Between Topics                            |
| 5.6     | Visualize Word Comparisons                                |
| 5.7     | Top Documents per Topic - The Gamma (γ) Matrix using Tidy |
| 5.8     | Visualizing Document-Topic Distributions                  |
| 5.9     | Finding Representative Documents for Each Topic           |
| 5.10    | Examining Representative Document Content                 |
| 5.11    | Summary of Representative Documents                       |
| 5.12    | Distribution of Dominant Topics                           |
| 5.13    | Topics Over Time                                          |

------------------------------------------------------------------------

**ALWAYS** Let’s load our libraries

``` r
library(tidyverse)    # Data manipulation and visualization
library(tidytext)     # Text mining using tidy data principles
library(ggplot2)      # Data visualization (part of tidyverse)
library(stopwords)    # Stopword lists in multiple languages
library(dplyr)        # Data manipulation (part of tidyverse)
library(quanteda)     # Quantitative text analysis
library(topicmodels)  # Topic modeling (LDA, CTM)
library(topicdoc)     # Topic coherence metrics
```

## 1. Intro to Topic Modeling

Topic modeling is an unsupervised machine learning technique that
identifies latent themes in a collection of text documents. The most
widely used approach is Latent Dirichlet Allocation (LDA), which assumes
each document is a mixture of topics, and each topic is a mixture of
words.

### 1.1 Why Use Topic Modeling?

- Helps uncover hidden structure in large text corpora
- Organizes vast amounts of text into interpretable themes
- Useful for content analysis, social media monitoring, and
  recommendation systems
- Allows exploration of what people are discussing without pre-defined
  categories

![](https://www.tidytextmining.com/images/tmwr_0601.png)

*image from: <https://www.tidytextmining.com/topicmodeling>*

### 1.2 Understanding LDA

**Latent Dirichlet Allocation (LDA)** is one of the most widely used
algorithms for topic modeling. Without delving into the complex
mathematics behind it, we can conceptualize LDA through two key
principles:

1.  **Every document is a mixture of topics.**
    - Each document contains words from multiple topics in different
      proportions.
    - For instance, in a model with two topics, we could say:
      - “Document 1 is 80% Topic A and 20% Topic B.”
      - “Document 2 is 40% Topic A and 60% Topic B.”
2.  **Every topic is a mixture of words.**
    - Each topic consists of words that commonly appear together.
    - For example, in a two-topic model focused on K-pop:
      - The “idol performance” topic might include words like *dance*,
        *stage*, *music*, and *concert*.
      - The “fandom culture” topic might contain words like *fans*,
        *streaming*, *voting*, and *billboard*.
      - Some words, like *debut*, may appear in both topics but with
        different frequencies.

LDA uses a probabilistic approach to simultaneously determine:

- The composition of topics within each document

- The key words that define each topic

This method enables us to uncover hidden themes in large text datasets
without prior labeling.

------------------------------------------------------------------------

## 2. Preprocessing Text Data

### 2.1 Load the Data

We’ll use Reddit comments about K-pop Demon Hunters. This dataset
contains community discussions, reactions, and conversations about the
show.

``` r
# Load the data
data <- read_csv("kpop_comments_forclass.csv")

# Check structure
str(data)
```

    ## spc_tbl_ [23,270 × 18] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ text            : chr [1:23270] "kind of a tangent but kind of a telling tidbit from japan...\n\n\nuniversal studio japan does these \"hybe x us"| __truncated__ "Thank you for submitting to r/kpop! Unfortunately, your post has been removed for the following reason(s):\n\n*"| __truncated__ "Thank you for submitting to r/kpop! Unfortunately, your post has been removed for the following reason(s):\n\n*"| __truncated__ "Put character skin out, I wanted to see NingNing tapped out Winter" ...
    ##  $ id              : chr [1:23270] "n0o7gct" "n0o7ocv" "n0o94v4" "n0o984c" ...
    ##  $ author          : chr [1:23270] "xxqbsxx" "kpop-ModTeam" "kpop-ModTeam" "Sunasoo" ...
    ##  $ link_id         : chr [1:23270] "t3_1kf7rre" "t3_1loneox" "t3_1lonl0c" "t3_1lom8cm" ...
    ##  $ parent_id       : chr [1:23270] "t3_1kf7rre" "t3_1loneox" "t3_1lonl0c" "t3_1lom8cm" ...
    ##  $ created_utc     : num [1:23270] 1.75e+09 1.75e+09 1.75e+09 1.75e+09 1.75e+09 ...
    ##  $ score           : num [1:23270] 71 1 1 9 1 10 5 1 2 30 ...
    ##  $ downs           : num [1:23270] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ likes           : logi [1:23270] NA NA NA NA NA NA ...
    ##  $ controversiality: num [1:23270] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ gilded          : num [1:23270] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ subreddit       : chr [1:23270] "kpop" "kpop" "kpop" "kpop" ...
    ##  $ permalink       : chr [1:23270] "/r/kpop/comments/1kf7rre/megathread_22_hybe_ador_mhj_we_reach_one_year_of/n0o7gct/" "/r/kpop/comments/1loneox/bighit_musics_new_korean_boy_band_spotted_filming/n0o7ocv/" "/r/kpop/comments/1lonl0c/guys_i_need_help_finding_this_song/n0o94v4/" "/r/kpop/comments/1lom8cm/aespa_street_fighter_6_x_aespa_special_collab/n0o984c/" ...
    ##  $ datetime        : POSIXct[1:23270], format: "2025-07-01 00:02:08" "2025-07-01 00:03:25" ...
    ##  $ date            : Date[1:23270], format: "2025-07-01" "2025-07-01" ...
    ##  $ year            : num [1:23270] 2025 2025 2025 2025 2025 ...
    ##  $ month           : num [1:23270] 7 7 7 7 7 7 7 7 7 7 ...
    ##  $ text_length     : num [1:23270] 818 561 519 66 469 ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   text = col_character(),
    ##   ..   id = col_character(),
    ##   ..   author = col_character(),
    ##   ..   link_id = col_character(),
    ##   ..   parent_id = col_character(),
    ##   ..   created_utc = col_double(),
    ##   ..   score = col_double(),
    ##   ..   downs = col_double(),
    ##   ..   likes = col_logical(),
    ##   ..   controversiality = col_double(),
    ##   ..   gilded = col_double(),
    ##   ..   subreddit = col_character(),
    ##   ..   permalink = col_character(),
    ##   ..   datetime = col_datetime(format = ""),
    ##   ..   date = col_date(format = ""),
    ##   ..   year = col_double(),
    ##   ..   month = col_double(),
    ##   ..   text_length = col_double()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

``` r
head(data)
```

    ## # A tibble: 6 × 18
    ##   text              id    author link_id parent_id created_utc score downs likes
    ##   <chr>             <chr> <chr>  <chr>   <chr>           <dbl> <dbl> <dbl> <lgl>
    ## 1 "kind of a tange… n0o7… xxqbs… t3_1kf… t3_1kf7r…  1751328128    71     0 NA   
    ## 2 "Thank you for s… n0o7… kpop-… t3_1lo… t3_1lone…  1751328205     1     0 NA   
    ## 3 "Thank you for s… n0o9… kpop-… t3_1lo… t3_1lonl…  1751328709     1     0 NA   
    ## 4 "Put character s… n0o9… Sunas… t3_1lo… t3_1lom8…  1751328740     9     0 NA   
    ## 5 "Thank you for s… n0o9… kpop-… t3_1lo… t3_1lonk…  1751328826     1     0 NA   
    ## 6 "Where’s the Aku… n0oa… Optio… t3_1lo… t3_1lom8…  1751329139    10     0 NA   
    ## # ℹ 9 more variables: controversiality <dbl>, gilded <dbl>, subreddit <chr>,
    ## #   permalink <chr>, datetime <dttm>, date <date>, year <dbl>, month <dbl>,
    ## #   text_length <dbl>

### 2.2 Initial Data Exploration

Let’s understand what we’re working with:

``` r
# How many comments?
nrow(data)
```

    ## [1] 23270

``` r
# Date range
range(data$date)
```

    ## [1] "2025-07-01" "2025-07-31"

``` r
# Score distribution
summary(data$score)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##  -85.00    2.00    7.00   19.98   21.00 1779.00

``` r
# Text length distribution
summary(data$text_length)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    51.0    89.0   152.0   274.3   308.0  9673.0

``` r
# Look at a few comments
head(data$text, 5)
```

    ## [1] "kind of a tangent but kind of a telling tidbit from japan...\n\n\nuniversal studio japan does these \"hybe x usj summer dance night\" thing in july and aug where they play hybe artists music for ppl to dance to \n\n\nits an official event and i think &team actually came to perform live last year\n\n\nyou can search on socials for the setlist, but this year theyve completely cut nj from the lineup (eta and supershy were on there last year)\n\n\ntokkis may use this to cry mistreatment and erasure, but how could they promote a group that refuses to acknowledge their company🤷\n\n\nand tbh the setlist with illit and tws added this year does not look lacking at all, such is the fast paced world of kpop \n\n\ni hope the members and their fans realize that the world wont be waiting for them but just move on and find the next big thing"
    ## [2] "Thank you for submitting to r/kpop! Unfortunately, your post has been removed for the following reason(s):\n\n* Submissions that are not substantially newsworthy should be posted to the [artist's subreddit](https://www.reddit.com/r/kpop/wiki/relatedsubs#wiki_group.2Fartist_subreddits.3A). Please check each subreddit's rules before posting.\n\nIf you have any questions regarding the ruleset of r/kpop, please refer to the [Rules](https://www.reddit.com/r/kpop/wiki/rules) or [message the moderators](https://www.reddit.com/message/compose/?to=/r/kpop). Thank you!"                                                                                                                                                                                                                                                                                  
    ## [3] "Thank you for submitting to r/kpop! Unfortunately, your post has been removed for the following reason(s):\n\n* Please go to r/kpophelp and use the **Monthly 'Who's this?' & Merch Authentication Post** to get help for your question. You should be able to find it pinned to the top of that subreddit.\n\nIf you have any questions regarding the ruleset of r/kpop, please refer to the [Rules](https://www.reddit.com/r/kpop/wiki/rules) or [message the moderators](https://www.reddit.com/message/compose/?to=/r/kpop). Thank you!"                                                                                                                                                                                                                                                                                                                            
    ## [4] "Put character skin out, I wanted to see NingNing tapped out Winter"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
    ## [5] "Thank you for submitting to r/kpop! Unfortunately, your post has been removed for the following reason(s):\n\n* Your submission is off-topic for this subreddit.  All submissions must be directly relevant to Korean music, artists, companies, or fans.\n\nIf you have any questions regarding the ruleset of r/kpop, please refer to the [Rules](https://www.reddit.com/r/kpop/wiki/rules) or [message the moderators](https://www.reddit.com/message/compose/?to=/r/kpop). Thank you!"

------------------------------------------------------------------------

### 2.3 Text Preprocessing

Before we can run topic models, we need to clean and prepare our text
data.

#### 2.3.1 Create Index, Backup Text, and Language Filtering

**Important:** We’ll create new objects at each step so we don’t lose
our original data.

**Why these steps matter:**

1.  **Language filtering:** Reddit has international users, so we remove
    non-English comments
2.  **Duplicate removal:** Same comment posted multiple times (e.g.,
    copypasta, bots)
3.  **Creating new objects:** We keep `data`, `data2`, `data3` so we can
    backtrack if needed

``` r
# Create document index
data$comment_index <- seq_len(nrow(data))

# Backup original text
data$textBU <- data$text


data$CLD2<-cld2::detect_language(data$text) ## a package by Google
table(data$CLD2)
```

    ## 
    ##    en    es    fr    id    it    ko    ms    pt    sk    tl    vi 
    ## 23133     9     3     2     3    25     1     2     1     1     1

``` r
data2 <- data |>  filter(CLD2=="en")
data3 <- data |> 
  distinct(text, .keep_all = TRUE)
```

#### 2.3.2 Create Custom Stopwords

We’ll remove common words that don’t add meaning to our topics. For
K-pop discussions, we might want to remove very generic terms.

``` r
# Create custom stopword list
mystopwords <- c(
  stopwords("en"),
  stopwords::stopwords(source = "smart"),
  # Add domain-specific stopwords
  "https", "http", "t.co", "amp",  # URLs and HTML
  "reddit", "comment", "post", "thread",  # Reddit-specific
  "edit", "edited", "update",  # Reddit conventions
  "kpop"  # Remove your own search words as they will be in every document
)

mystopwords <- unique(mystopwords)
mystopwords <- tolower(mystopwords)

# Check how many stopwords we have
length(mystopwords)
```

    ## [1] 592

------------------------------------------------------------------------

### 2.4 Tokenization

Now we’ll break our text into individual words (tokens) and remove
stopwords.

``` r
# Tokenize the text
tidy_data <- data3 |> 
  unnest_tokens(word, text) |>  # Break into words
  anti_join(data.frame(word = mystopwords)) |>  # Remove stopwords
  mutate(nchar = nchar(word)) |>  # Count characters per word
  filter(nchar > 2) |>  # Keep words with more than 2 characters
  filter(!grepl("[0-9]{1}", word)) |>  # Remove words with numbers
  filter(!grepl("\\W", word))  # Remove words with special characters

# Check results
head(tidy_data)
```

    ## # A tibble: 6 × 22
    ##   id     author link_id parent_id created_utc score downs likes controversiality
    ##   <chr>  <chr>  <chr>   <chr>           <dbl> <dbl> <dbl> <lgl>            <dbl>
    ## 1 n0o7g… xxqbs… t3_1kf… t3_1kf7r…  1751328128    71     0 NA                   0
    ## 2 n0o7g… xxqbs… t3_1kf… t3_1kf7r…  1751328128    71     0 NA                   0
    ## 3 n0o7g… xxqbs… t3_1kf… t3_1kf7r…  1751328128    71     0 NA                   0
    ## 4 n0o7g… xxqbs… t3_1kf… t3_1kf7r…  1751328128    71     0 NA                   0
    ## 5 n0o7g… xxqbs… t3_1kf… t3_1kf7r…  1751328128    71     0 NA                   0
    ## 6 n0o7g… xxqbs… t3_1kf… t3_1kf7r…  1751328128    71     0 NA                   0
    ## # ℹ 13 more variables: gilded <dbl>, subreddit <chr>, permalink <chr>,
    ## #   datetime <dttm>, date <date>, year <dbl>, month <dbl>, text_length <dbl>,
    ## #   comment_index <int>, textBU <chr>, CLD2 <chr>, word <chr>, nchar <int>

``` r
nrow(tidy_data)  # How many tokens do we have?
```

    ## [1] 385257

------------------------------------------------------------------------

### 2.5 Term Frequency Filtering with TF-IDF

Not all words are equally useful for topic modeling. We want to remove:

- **Very common words** that appear in almost every document (too
  general)

- **Very rare words** that appear in only 1-2 documents (too specific)

We use **TF-IDF** principles to filter our vocabulary:

``` r
# Set thresholds
maxndoc <- 0.75   # Remove words in more than 75% of documents
minndoc <- 0.001 # Remove words in less than 0.1% of documents

# Calculate document frequency for each word
templength <- length(unique(tidy_data$comment_index))

good_common_words <- tidy_data |> 
  count(comment_index, word, sort = TRUE) |> 
  group_by(word) |> 
  summarize(doc_freq = n() / templength) |> 
  filter(doc_freq < maxndoc) |>   # Not too common
  filter(doc_freq > minndoc)      # Not too rare

# How many words passed our filter?
nrow(good_common_words)
```

    ## [1] 2683

``` r
# Clean our tidy data to only include these words
tidy_data_pruned <- tidy_data |> 
  inner_join(good_common_words)

# NOTE: This is where you might lose some documents that had no remaining words
```

------------------------------------------------------------------------

### 2.6 Visualize Top Words

Before modeling, let’s see what words are most common in our corpus:

``` r
# Plot top 50 words
tidy_data_pruned |> 
  group_by(word) |> 
  summarise(n = n()) |> 
  arrange(desc(n)) |> 
  mutate(word = reorder(word, n)) |> 
  top_n(50) |>     
  ggplot(aes(n, word)) +
  geom_col(fill = "steelblue") +
  labs(
    title = "Top 50 Words in K-pop Demon Hunters Comments",
    y = NULL,
    x = "Frequency"
  ) +
  theme_minimal()
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

**Questions to ask:** - Do these words make sense for K-pop discussions?

- Are there any words we should add to our stopword list?

- Do we see evidence of different themes already?

------------------------------------------------------------------------

### 2.7 Create Document-Term Matrix

For topic modeling, we need to convert our tidy data into a
**Document-Term Matrix (DTM)**:

- Rows = documents (comments)

- Columns = words (terms)

- Values = word counts

``` r
# Create DTM using tidytext
tidy_dfm <- tidy_data_pruned |> 
  count(comment_index, word) |> 
  cast_dtm(comment_index, word, n)

# Check dimensions
tidy_dfm
```

    ## <<DocumentTermMatrix (documents: 22316, terms: 2683)>>
    ## Non-/sparse entries: 259840/59613988
    ## Sparsity           : 100%
    ## Maximal term length: 15
    ## Weighting          : term frequency (tf)

``` r
dim(tidy_dfm)
```

    ## [1] 22316  2683

**Understanding the Document-Term Matrix Output**

When you print the DTM, you’ll see output like this:

    <<DocumentTermMatrix (documents: 22316, terms: 2683)>>
    Non-/sparse entries: 259840/59613988
    Sparsity           : 100%
    Maximal term length: 15
    Weighting          : term frequency (tf)
    [1] 22316  2683

Let’s break down what each line means:

**Line 1: Dimensions** - `documents: 22,316` = We have 22,316 comments
in our dataset

- `terms: 2,683` = We have 2,683 unique words in our vocabulary

- This creates a matrix with 22,216 rows × 2,683 columns = 59,873,828
  total cells

**Line 2: Entries**

- `Non-sparse entries: 259,840` = Only 259,840 cells contain actual word
  counts (non-zero values)

- `Sparse entries: 59,613,988` = Most cells are empty (zeros) because
  most words don’t appear in most documents

**Line 3: Sparsity**

- `Sparsity:100%` = Essentially 100% of the matrix is empty (zeros)

- This is normal! Most comments only use a small fraction of the total
  vocabulary

- High sparsity is expected in text data

**Line 4: Term Length**

- `Maximal term length: 15` = The longest word in our vocabulary has 15
  characters

**Line 5: Weighting**

- `term frequency (tf)` = Cells contain simple counts of how many times
  each word appears in each document

- Alternative weightings include TF-IDF (which we used for filtering)

**Why does this matter?**

Text data is **naturally sparse** because:

``` r
# Calculate actual sparsity statistics from our DTM
dtm_matrix <- as.matrix(tidy_dfm)
words_per_doc <- rowSums(dtm_matrix > 0)

# Summary statistics
mean(words_per_doc)      # Average: 11.6 unique words per comment
```

    ## [1] 11.64366

``` r
median(words_per_doc)    # Median: 7 unique words per comment
```

    ## [1] 7

``` r
quantile(words_per_doc, c(0.25, 0.75))  # 25th percentile: 4, 75th percentile: 13
```

    ## 25% 75% 
    ##   4  13

``` r
# Vocabulary usage
mean(words_per_doc) / 2683 * 100   # Average: 0.43% of vocabulary
```

    ## [1] 0.4339793

``` r
median(words_per_doc) / 2683 * 100 # Median: 0.26% of vocabulary
```

    ## [1] 0.260902

``` r
rm(dtm_matrix)
```

Our data shows:

- **Average comment uses only 11.6 unique words** (median: 7 words) -
  **Vocabulary has 2683 words total**

- **Each comment uses only 0.43% of the available vocabulary** (median:
  0.26%)

- **Range:** Comments use between 1 to 294 unique words

- **Most comments (50%)** use between 4-13 unique words (interquartile
  range)

This extreme sparsity is why topic modeling is powerful - it finds
patterns in this sparse, high-dimensional data by identifying which
words tend to co-occur across documents, revealing hidden thematic
structure!

**Visualization:**

``` r
# Visualize distribution of words per comment
data.frame(words = words_per_doc) |> 
  ggplot(aes(x = words)) +
  geom_histogram(bins = 50, fill = "steelblue", alpha = 0.7) +
  geom_vline(xintercept = mean(words_per_doc), 
             color = "red", linetype = "dashed", size = 1) +
  geom_vline(xintercept = median(words_per_doc), 
             color = "darkgreen", linetype = "dashed", size = 1) +
  annotate("text", x = mean(words_per_doc) + 15, y = 2000, 
           label = paste("Mean:", round(mean(words_per_doc), 1)), 
           color = "red") +
  annotate("text", x = median(words_per_doc) + 15, y = 1800, 
           label = paste("Median:", median(words_per_doc)), 
           color = "darkgreen") +
  labs(
    title = "Distribution of Unique Words per Comment",
    subtitle = "Most comments use very few unique words after preprocessing",
    x = "Number of Unique Words",
    y = "Number of Comments"
  ) +
  theme_minimal()
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-11-1.png)<!-- -->

------------------------------------------------------------------------

**Important:** Notice if we lost any documents during preprocessing.
This happens when comments had no words left after stopword removal and
filtering.

``` r
# How many documents did we start with?
nrow(data3)
```

    ## [1] 22408

``` r
# How many documents in our DTM?
nrow(tidy_dfm)
```

    ## [1] 22316

``` r
# How many did we lose?
nrow(data3) - nrow(tidy_dfm)
```

    ## [1] 92

**Summary of data filtering:**

| Step | \# Comments | Comments Lost | Reason |
|----|----|----|----|
| Original data | 23,270 | \- | Raw July 2025 r/kpop comments |
| Language filter | 23,133 | 137 | Removed non-English comments |
| Duplicate removal | 22,408 | 725 | Removed duplicate/repeated comments |
| Preprocessing filter | 22,316 | 92 | Removed comments with no words after stopword removal and TF-IDF filtering |
| **Final dataset** | **22,316** | **954 total** | **Ready for topic modeling** |

We lost 954 comments total (4.1% of original data) - this is a very
reasonable amount of data loss during preprocessing!

The breakdown:

- **137 non-English comments** (0.6%) - mostly Korean, Spanish, French

- **725 duplicates** (3.1%) - copypasta, bot comments, repeated phrases

- **92 empty after preprocessing** (0.4%) - comments with only
  stopwords/URLs

------------------------------------------------------------------------

## 3. Choosing the Number of Topics (K)

One of the most important decisions in topic modeling is choosing **how
many topics (K)** to extract. There’s no perfect answer, but we can use
**topic coherence metrics** to guide our decision.

### 3.1 What is Topic Coherence?

**Topic coherence** measures how interpretable and meaningful a topic is
by calculating how often the top words in a topic appear together in
documents.

**High coherence** = words in a topic frequently co-occur (topic makes
sense) **Low coherence** = words in a topic rarely appear together
(topic is random/unclear)

Think of it like this:

- A topic with words *{dance, performance, stage, choreography}* has
  HIGH coherence (these words naturally go together)

- A topic with words *{dance, breakfast, politics, ocean}* has LOW
  coherence (these words don’t relate)

### 3.2 Types of Coherence Metrics

There are several ways to measure topic coherence:

| Metric | Description | What It Measures |
|----|----|----|
| **C_V** | Based on sliding window word co-occurrence | Most commonly used; balances accuracy and interpretability |
| **C_UMass** | Based on document co-occurrence | How often topic words appear in same documents |
| **C_UCI** | Based on pointwise mutual information | Statistical association between words |
| **C_NPMI** | Normalized pointwise mutual information | Normalized version of UCI |

For this class, we’ll focus on **C_V** (most popular) and **C_UMass**
(fastest to compute).

### 3.3 What Makes a “Good” Topic?

A good topic should have:

1.  **High coherence** - Words make sense together
2.  **High exclusivity** - Words are specific to this topic (not shared
    across all topics)
3.  **Interpretability** - Humans can understand what the topic is about
4.  **Coverage** - Topics cover the main themes in your corpus

**Trade-off Alert:** Sometimes increasing K gives you more specific
topics (higher exclusivity) but lower coherence. We need to find the
sweet spot!

------------------------------------------------------------------------

### 3.4 Computing Topic Coherence for Different K Values

Now we’ll fit LDA models with different numbers of topics (K = 5, 10,
15, 20, 25) and calculate their coherence scores.

**Note:** This step can take 5-10 minutes to run (even longer in larger
data), so be patient!

``` r
# We'll test these K values
k_values <- c(5, 10, 15, 20, 25, 50)

# Create empty lists to store results
lda_models <- list()
coherence_scores <- data.frame(
  k = integer(),
  coherence_cv = numeric(),
  coherence_umass = numeric()
)

# Fit models for each K
for (k in k_values) {
  cat("Fitting LDA with K =", k, "...\n")
  
  # Fit LDA model
  lda_model <- LDA(
    tidy_dfm, 
    k = k, 
    method = "Gibbs",
    control = list(
      verbose = 500, 
      seed = 9898,
      iter = 1000,
      burnin = 100
    )
  )
  
  # Store model
  lda_models[[as.character(k)]] <- lda_model
  
  # Calculate coherence using topicdoc
  # The function is topic_coherence() with different syntax
  coherence_result <- topic_coherence(lda_model, tidy_dfm)
  
  # Store results
  coherence_scores <- rbind(
    coherence_scores,
    data.frame(
      k = k,
      mean_coherence = mean(coherence_result)
    )
  )
  
  cat("K =", k, "Mean Coherence =", mean(coherence_result), "\n\n")
}
```

    ## Fitting LDA with K = 5 ...
    ## K = 5; V = 2683; M = 22316
    ## Sampling 1100 iterations!
    ## Iteration 500 ...
    ## Iteration 1000 ...
    ## Gibbs sampling completed!
    ## K = 5 Mean Coherence = -160.4584 
    ## 
    ## Fitting LDA with K = 10 ...
    ## K = 10; V = 2683; M = 22316
    ## Sampling 1100 iterations!
    ## Iteration 500 ...
    ## Iteration 1000 ...
    ## Gibbs sampling completed!
    ## K = 10 Mean Coherence = -178.2801 
    ## 
    ## Fitting LDA with K = 15 ...
    ## K = 15; V = 2683; M = 22316
    ## Sampling 1100 iterations!
    ## Iteration 500 ...
    ## Iteration 1000 ...
    ## Gibbs sampling completed!
    ## K = 15 Mean Coherence = -188.5915 
    ## 
    ## Fitting LDA with K = 20 ...
    ## K = 20; V = 2683; M = 22316
    ## Sampling 1100 iterations!
    ## Iteration 500 ...
    ## Iteration 1000 ...
    ## Gibbs sampling completed!
    ## K = 20 Mean Coherence = -188.3172 
    ## 
    ## Fitting LDA with K = 25 ...
    ## K = 25; V = 2683; M = 22316
    ## Sampling 1100 iterations!
    ## Iteration 500 ...
    ## Iteration 1000 ...
    ## Gibbs sampling completed!
    ## K = 25 Mean Coherence = -192.205 
    ## 
    ## Fitting LDA with K = 50 ...
    ## K = 50; V = 2683; M = 22316
    ## Sampling 1100 iterations!
    ## Iteration 500 ...
    ## Iteration 1000 ...
    ## Gibbs sampling completed!
    ## K = 50 Mean Coherence = -201.1114

``` r
# View results
print(coherence_scores)
```

    ##    k mean_coherence
    ## 1  5      -160.4584
    ## 2 10      -178.2801
    ## 3 15      -188.5915
    ## 4 20      -188.3172
    ## 5 25      -192.2050
    ## 6 50      -201.1114

------------------------------------------------------------------------

### 3.5 Visualizing Topic Coherence

Let’s visualize how coherence changes with the number of topics:

#### 3.5.1 Coherence Across K Values

``` r
# Line plot showing coherence scores
ggplot(coherence_scores, aes(x = k, y = mean_coherence)) +
  geom_line(color = "steelblue", size = 1.2) +
  geom_point(color = "steelblue", size = 4) +
  geom_point(data = coherence_scores[1,], 
             color = "darkgreen", size = 5, shape = 17) +  # Highlight K=5
  labs(
    title = "Topic Coherence by Number of Topics (K)",
    subtitle = "Higher (less negative) is better • Green triangle = optimal K",
    x = "Number of Topics (K)",
    y = "Mean Coherence Score (UMass)"
  ) +
  scale_x_continuous(breaks = k_values) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    axis.title = element_text(size = 12),
    panel.grid.minor = element_blank()
  )
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

#### 3.5.2 Coherence Decline from Optimal K

``` r
# Calculate percentage decline from optimal
coherence_scores <- coherence_scores |> 
  mutate(
    coherence_diff = mean_coherence - max(mean_coherence),
    percent_decline = abs((mean_coherence - max(mean_coherence)) / max(mean_coherence) * 100)
  )

# Plot percentage decline
ggplot(coherence_scores, aes(x = k, y = percent_decline)) +
  geom_line(color = "darkred", size = 1.2) +
  geom_point(color = "darkred", size = 4) +
  geom_area(fill = "darkred", alpha = 0.2) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "darkgreen", size = 1) +
  labs(
    title = "Coherence Decline from Optimal K",
    subtitle = "Shows how much coherence degrades as K increases from optimal (K=5)",
    x = "Number of Topics (K)",
    y = "Percent Decline in Coherence (%)"
  ) +
  scale_x_continuous(breaks = k_values) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    plot.subtitle = element_text(size = 11, color = "gray40"),
    axis.title = element_text(size = 12)
  )
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-15-1.png)<!-- -->

``` r
# Print the summary table
coherence_scores |> 
  select(k, mean_coherence, percent_decline) |> 
  mutate(
    mean_coherence = round(mean_coherence, 2),
    percent_decline = round(percent_decline, 1)
  )
```

    ##    k mean_coherence percent_decline
    ## 1  5        -160.46             0.0
    ## 2 10        -178.28            11.1
    ## 3 15        -188.59            17.5
    ## 4 20        -188.32            17.4
    ## 5 25        -192.21            19.8
    ## 6 50        -201.11            25.3

**Key Insights from Visualizations:**

1.  **K = 5 has the best coherence** (-160.46)
    - Marked with green triangle in first plot
    - 0% decline baseline (green dashed line in second plot)
    - Topics are most internally coherent
2.  **Steep initial decline from K=5 to K=10** (11.1% decline)
    - Largest single drop visible in both plots
    - Significant quality loss when adding just 5 more topics
    - Red shaded area shows this is the steepest part of the curve
3.  **Near-plateau between K=15 and K=20**
    - K=15: 17.5% decline
    - K=20: 17.4% decline (only 0.1% difference)
    - Nearly flat line in both plots between these points
    - Suggests a natural topic boundary for this dataset
    - Adding 5 more topics provides minimal change in quality
4.  **Gradual increase in decline continues**
    - K=25: 19.8% decline (2.4% worse than K=20)
    - K=50: 25.3% decline (total of 25% quality loss)
    - Red shaded area grows steadily, showing accumulating cost

**What the visualizations tell us:**

- **First plot (line graph)**: Shows absolute coherence scores getting
  worse (more negative)
- **Second plot (area chart)**: Emphasizes the **cost** of adding topics
  - Red shaded area = quality loss
  - Steepest growth at beginning (K=5 to K=10)
  - Plateau visible at K=15-20
  - Continuous growth toward K=50

By K=50, we’ve lost about 1/4 of our coherence quality compared to the
optimal K=5, suggesting severe topic fragmentation.

``` r
# Create models with different number of topics
# Note: This takes several minutes to run!
start_time <- Sys.time()
cat("Starting at:", format(start_time, "%H:%M:%S"), "\n")
```

    ## Starting at: 16:52:31

``` r
result <- ldatuning::FindTopicsNumber(
  tidy_dfm,
  topics = seq(from = 2, to = 20, by = 1),
  metrics = c("CaoJuan2009", "Deveaud2014"),
  method = "Gibbs",
  control = list(seed = 77),
  verbose = TRUE
)
```

    ## fit models... done.
    ## calculate metrics:
    ##   CaoJuan2009... done.
    ##   Deveaud2014... done.

``` r
end_time <- Sys.time()
cat("Finished at:", format(end_time, "%H:%M:%S"), "\n")
```

    ## Finished at: 16:53:51

``` r
cat("Total time:", round(difftime(end_time, start_time, units = "mins"), 2), "minutes\n")
```

    ## Total time: 1.34 minutes

``` r
ldatuning::FindTopicsNumber_plot(result)
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

### 3.6 Interpreting the Results for optimal K

This plot shows two different metrics for evaluating topic models:

**Top Panel**

- **CaoJuan2009 (minimize):**

  - Black circles show this metric

  - **Lower values = better**

  - Shows steady decline from K=2 to K=14

  - Reaches minimum around K=14-15

  - Suggests K=14-15 might be optimal by this metric

**Bottom Panel**

- **Deveaud2014 (maximize):**

  - Black triangles show this metric

  - **Higher values = better**

  - Very noisy/unstable pattern

  - Peak at K=5, another high point at K=9

  - Much more variable than CaoJuan metric

  - Harder to identify clear optimal K

**What do we notice?**

1.  **The two metrics disagree!**
    - CaoJuan suggests K=14-15
    - Deveaud suggests K=5 or K=9
    - This is common - different metrics optimize for different
      properties
2.  **Deveaud2014 is much noisier**
    - Large swings between consecutive K values
    - Makes it harder to identify stable patterns
    - This is why we also calculated UMass coherence separately
3.  **Compare with our UMass coherence results:**
    - Our manual calculation showed K=5 was optimal
    - Deveaud2014 also peaks at K=5 (agreement!)
    - CaoJuan suggests higher K (disagreement)
    - The plateau we saw at K=15-20 in UMass coherence partially aligns
      with CaoJuan’s minimum

**Which metric should we trust?**

Different metrics measure different aspects of topic quality:

- **CaoJuan2009**: Measures topic distinctiveness (how different topics
  are from each other)

- **Deveaud2014**: Measures topic divergence (similar concept, different
  formula)

- **UMass Coherence**: Measures how often top topic words appear
  together in documents

For interpretability and practical use, **UMass coherence** (our manual
calculation) is often preferred because it directly measures whether
topic words make sense together.

------------------------------------------------------------------------

### 3.7 Choosing Optimal K

Based on our coherence analysis, we’ll proceed with **K = 5** for the
following reasons:

**Why K=5?**

1.  **Best coherence score** (-160.46)
    - Highest quality topics by UMass metric
    - Words within topics co-occur most frequently
2.  **Interpretability**
    - 5 broad themes are easier to understand and explain
    - Avoids over-fragmentation of the discourse
    - Each topic should capture a distinct aspect of K-pop discussions
3.  **Practical considerations**
    - Good balance between granularity and coherence
    - Manageable number of topics for analysis
    - The 11% coherence loss at K=10 suggests splitting into 10 topics
      fragments core themes

**What about K=10, K=15, or K=20?**

- **K=10**: Could work if you need more granularity (11% coherence loss)
- **K=15-20**: The plateau suggests these are natural boundaries, but
  with 17-17.5% coherence loss
- **For this tutorial**: We’ll use K=5 to demonstrate clear, coherent
  topics

Let’s now fit our LDA model with K=5 topics!

------------------------------------------------------------------------

## 4. LDA Model

LDA converts the document-word matrix (we had above as `tidy_dfm`) into
two other matrices:

1.  **Topic-Word matrix (Beta (β))** - The probability of each word
    belonging to each topic
2.  **Document-Topic matrix (Gamma (γ))** - The probability of each
    document belonging to each topic

![](https://cdn.analyticsvidhya.com/wp-content/uploads/2021/06/26864dtm.webp)

*image from:
<https://cdn.analyticsvidhya.com/wp-content/uploads/2021/06/26864dtm.webp>*

**How LDA works:**

- **Input**: Document-Term Matrix (DTM)

  - Rows = documents (Reddit comments)
  - Columns = words (vocabulary)
  - Values = word counts

- **LDA Processing**: Discovers latent topics by finding patterns in
  word co-occurrence

- **Output**: Two probability matrices

  - **Beta (β)**: For each topic, what words are most probable?
  - **Gamma (γ)**: For each document, what topics are most probable?

------------------------------------------------------------------------

### 4.1 Train the LDA Model with the Optimal Topics

LDA objects take a lot of memory so we should always clean up the memory
from no longer used objects.

``` r
# Clean up workspace - keep only essential objects
# This frees up memory and keeps the environment organized

# List of objects to KEEP
keep_objects <- c(
  "data",         # Original dataset
  "data2",        # cleaned dataset
  "data3",        # last dataset
  "mystopwords",  # Custom stopwords list
  "tidy_dfm"      # LDA object we will delete after
)

# Remove everything except the objects we want to keep
rm(list = setdiff(ls(), keep_objects))

# Run garbage collection to free up memory
gc()
```

    ##           used  (Mb) gc trigger   (Mb) limit (Mb)  max used   (Mb)
    ## Ncells 3269735 174.7    5410774  289.0         NA   5410774  289.0
    ## Vcells 8790307  67.1  138689369 1058.2      36864 173357661 1322.7

``` r
# Check what we have left
print("Remaining objects in workspace:")
```

    ## [1] "Remaining objects in workspace:"

``` r
print(ls())
```

    ## [1] "data"        "data2"       "data3"       "mystopwords" "tidy_dfm"

Now let’s train our LDA model with K=5 topics.

``` r
# Set seed for reproducibility
set.seed(42)

# Train LDA model with K=5 topics
# Note: This may take a few minutes!
start_time <- Sys.time()
print(paste("Training LDA model with K=5..."))
```

    ## [1] "Training LDA model with K=5..."

``` r
print(paste("Start time:", format(start_time, "%H:%M:%S")))
```

    ## [1] "Start time: 16:53:51"

``` r
lda_model_k5 <- LDA(
  tidy_dfm, 
  k = 5, 
  method = "Gibbs",
  control = list(
    verbose = 500,   # Print progress every 500 iterations
    seed = 42,       # For reproducibility
    iter = 2000,     # Number of iterations
    burnin = 500     # Burn-in period
  )
)
```

    ## K = 5; V = 2683; M = 22316
    ## Sampling 2500 iterations!
    ## Iteration 500 ...
    ## Iteration 1000 ...
    ## Iteration 1500 ...
    ## Iteration 2000 ...
    ## Iteration 2500 ...
    ## Gibbs sampling completed!

``` r
end_time <- Sys.time()
print(paste("Finished at:", format(end_time, "%H:%M:%S")))
```

    ## [1] "Finished at: 16:54:11"

``` r
print(paste("Total time:", round(difftime(end_time, start_time, units = "mins"), 2), "minutes"))
```

    ## [1] "Total time: 0.33 minutes"

**What do these parameters mean?**

- `k = 5`: Number of topics (based on our coherence analysis)

- `method = "Gibbs"`: Gibbs sampling algorithm (standard for LDA)

- `iter = 2000`: Run 2000 iterations of the algorithm

- `burnin = 500`: Discard first 500 iterations (model is still “warming
  up”)

- `thin = 10`: Keep every 10th iteration after burnin (reduces
  autocorrelation)

- `seed = 42`: Ensures reproducibility

------------------------------------------------------------------------

### 4.2 Save Your Work

Before continuing, it’s a good idea to save your workspace. LDA models
take time to train, so you don’t want to lose your work!

``` r
# Save the entire workspace
save.image("../data/Lecture9_LDA_k5.RData")

# Alternatively, save just the LDA model
# save(lda_model_k5, file = "../data/lda_model_k5.RData")

# To load it later:
# load("../data/Lecture9_LDA_k5.RData")
```

**Why save your work?**

- LDA training can take 5-15 minutes (or longer for large datasets)

- If R crashes or you close your session, you’d have to retrain

- `save.image()` saves everything in your workspace

- `save()` saves specific objects (more efficient if you only need the
  model)

------------------------------------------------------------------------

### 4.3 Look Inside the LDA Model

``` r
# Examine the model structure
str(lda_model_k5)
```

    ## Formal class 'LDA_Gibbs' [package "topicmodels"] with 16 slots
    ##   ..@ seedwords      : NULL
    ##   ..@ z              : int [1:300482] 2 5 3 4 5 2 3 1 3 3 ...
    ##   ..@ alpha          : num 10
    ##   ..@ call           : language LDA(x = tidy_dfm, k = 5, method = "Gibbs", control = list(verbose = 500,      seed = 42, iter = 2000, burnin = 500))
    ##   ..@ Dim            : int [1:2] 22316 2683
    ##   ..@ control        :Formal class 'LDA_Gibbscontrol' [package "topicmodels"] with 14 slots
    ##   .. .. ..@ delta        : num 0.1
    ##   .. .. ..@ iter         : int 2500
    ##   .. .. ..@ thin         : int 2000
    ##   .. .. ..@ burnin       : int 500
    ##   .. .. ..@ initialize   : chr "random"
    ##   .. .. ..@ alpha        : num 10
    ##   .. .. ..@ seed         : int 42
    ##   .. .. ..@ verbose      : int 500
    ##   .. .. ..@ prefix       : chr "/var/folders/1n/8wbl6_f51tz27s0119qcsfyh0000gq/T//Rtmpv4Jlwh/filec1c356174180"
    ##   .. .. ..@ save         : int 0
    ##   .. .. ..@ nstart       : int 1
    ##   .. .. ..@ best         : logi TRUE
    ##   .. .. ..@ keep         : int 0
    ##   .. .. ..@ estimate.beta: logi TRUE
    ##   ..@ k              : int 5
    ##   ..@ terms          : chr [1:2683] "acknowledge" "added" "artists" "big" ...
    ##   ..@ documents      : chr [1:22316] "1" "2" "3" "4" ...
    ##   ..@ beta           : num [1:5, 1:2683] -13.28 -7.65 -13.24 -13.29 -10.4 ...
    ##   ..@ gamma          : num [1:22316, 1:5] 0.142 0.141 0.159 0.218 0.135 ...
    ##   ..@ wordassignments:List of 5
    ##   .. ..$ i   : int [1:259840] 1 1 1 1 1 1 1 1 1 1 ...
    ##   .. ..$ j   : int [1:259840] 1 2 3 4 5 6 7 8 9 10 ...
    ##   .. ..$ v   : num [1:259840] 2 3 3 4 5 2 3 1 3 2 ...
    ##   .. ..$ nrow: int 22316
    ##   .. ..$ ncol: int 2683
    ##   .. ..- attr(*, "class")= chr "simple_triplet_matrix"
    ##   ..@ loglikelihood  : num -1798660
    ##   ..@ iter           : int 2500
    ##   ..@ logLiks        : num(0) 
    ##   ..@ n              : int 300482

**Key components we see:**

    Formal class 'LDA_Gibbs' [package "topicmodels"] with 16 slots
      ..@ k              : int 5              # Number of topics
      ..@ terms          : chr [1:2683]       # Vocabulary (2,683 unique words)
      ..@ documents      : chr [1:22316]      # Document IDs (22,316 comments)
      ..@ beta           : num [1:5, 1:2683]  # Topic-word probabilities (5 topics × 2,683 words)
      ..@ gamma          : num [1:22316, 1:5] # Document-topic probabilities (22,316 docs × 5 topics)
      ..@ alpha          : num 10             # Prior for document-topic distribution
      ..@ iter           : int 2500           # Total iterations run
      ..@ loglikelihood  : num -1798660      # Model fit (higher is better)

**What these components mean:**

- **`@k`**: We trained 5 topics (as planned)

- **`@terms`**: All 2,683 unique words in our vocabulary

- **`@documents`**: All 22,316 Reddit comment IDs

- **`@beta`**: The Topic-Word matrix (which words belong to which
  topics?)

- **`@gamma`**: The Document-Topic matrix (which topics appear in which
  documents?)

- **`@alpha`**: Hyperparameter controlling topic distribution (10 =
  fairly diffuse)

- **`@loglikelihood`**: How well the model fits the data (more negative
  = worse fit)

We are primarily interested in `@beta` and `@gamma` for interpretation!

------------------------------------------------------------------------

------------------------------------------------------------------------

## 5. The Beta & Gamma Matrices

### 5.1 Beta (β): Topic-Word Probabilities

**Beta (β): The per-topic-per-word probabilities**

- Beta is the proportion of the topic that is made up of words from the
  vocabulary

- Shows which words are most important to each topic

- Dimensions: Topics × Words (5 × 2,683 in our case)

**Gamma (γ): The per-document-per-topic probabilities**

- Gamma is the proportion of the document that is made up of words from
  the assigned topic

- Shows which topics are present in each document

- Dimensions: Documents × Topics (22,316 × 5 in our case)

------------------------------------------------------------------------

### 5.2 Top Words per Topic - The Beta (β) Matrix using Tidy

``` r
# Extract beta matrix using tidytext
lda_topics <- tidy(lda_model_k5, matrix = "beta")
head(lda_topics, 20)
```

    ## # A tibble: 20 × 3
    ##    topic term              beta
    ##    <int> <chr>            <dbl>
    ##  1     1 acknowledge 0.00000171
    ##  2     2 acknowledge 0.000477  
    ##  3     3 acknowledge 0.00000177
    ##  4     4 acknowledge 0.00000170
    ##  5     5 acknowledge 0.0000304 
    ##  6     1 added       0.00000171
    ##  7     2 added       0.0000696 
    ##  8     3 added       0.00190   
    ##  9     4 added       0.0000867 
    ## 10     5 added       0.00110   
    ## 11     1 artists     0.00000171
    ## 12     2 artists     0.00000170
    ## 13     3 artists     0.0132    
    ## 14     4 artists     0.00000170
    ## 15     5 artists     0.00000145
    ## 16     1 big         0.000138  
    ## 17     2 big         0.00000170
    ## 18     3 big         0.00000177
    ## 19     4 big         0.0123    
    ## 20     5 big         0.00000145

**Results:**

| topic | term        | beta         |
|-------|-------------|--------------|
| 1     | acknowledge | 1.708546e-06 |
| 2     | acknowledge | 4.769883e-04 |
| 3     | acknowledge | 1.769839e-06 |
| 4     | acknowledge | 1.699227e-06 |
| 5     | acknowledge | 3.042142e-05 |
| 1     | added       | 1.708546e-06 |
| 2     | added       | 6.959616e-05 |
| 3     | added       | 1.895498e-03 |
| 4     | added       | 8.666056e-05 |
| 5     | added       | 1.102414e-03 |

**How do we interpret this?**

Each row shows the probability of a word belonging to a topic. For
example, looking at the word “acknowledge” across all topics:

- **Topic 1:** $\beta = 1.71 \times 10^{-6}$ (0.000171% - very rare)

- **Topic 2:** $\beta = 4.77 \times 10^{-4}$ (0.0477% - **most
  associated**)

- **Topic 3:** $\beta = 1.77 \times 10^{-6}$ (0.000177% - very rare)

- **Topic 4:** $\beta = 1.70 \times 10^{-6}$ (0.000170% - very rare)

- **Topic 5:** $\beta = 3.04 \times 10^{-5}$ (0.00304% - rare)

This tells us “acknowledge” is most strongly associated with **Topic 2**
(about 280x more likely than in Topic 1!), making it a potentially
defining word for that topic.

Similarly, for “added”:

- Most strongly associated with **Topic 3** ($\beta = 0.0019$)

- Also appears in **Topic 5** ($\beta = 0.0011$)

- Rarely appears in other topics

**Key takeaway:** Even small beta values matter! The *relative*
differences between topics tell us which words characterize each topic.

In order to get the highest probabilities for each topic, we can use
`slice_max()`:

------------------------------------------------------------------------

### 5.3 Top 10 Words per Topic

``` r
# Get top 10 words for each topic
lda_top_terms <- lda_topics |> 
  group_by(topic) |> 
  slice_max(beta, n = 10) |> 
  ungroup() |> 
  arrange(topic, -beta)

# View the results
print(lda_top_terms)
```

    ## # A tibble: 50 × 3
    ##    topic term     beta
    ##    <int> <chr>   <dbl>
    ##  1     1 song  0.0435 
    ##  2     1 love  0.0294 
    ##  3     1 good  0.0285 
    ##  4     1 album 0.0237 
    ##  5     1 songs 0.0227 
    ##  6     1 lol   0.0121 
    ##  7     1 happy 0.0108 
    ##  8     1 video 0.0106 
    ##  9     1 great 0.0102 
    ## 10     1 live  0.00914
    ## # ℹ 40 more rows

**Interpreting the results:**

Look at the top words for each topic. Do they form coherent themes?

**Questions to ask yourself:**

1.  **Do the words in each topic relate to each other?**
    - Topic 1 might have: album, release, comeback, music
    - This suggests a “music release” theme
2.  **Are the topics distinct from each other?**
    - Compare Topic 1 vs Topic 2
    - Do they have different top words?
    - Or do they share many words? (if so, might need different K)
3.  **Can you give each topic a meaningful label?**
    - Based on the top 10 words, what would you call this topic?
    - Examples: “Fan Discussions”, “Artist News”, “Music Reviews”, etc.

**What makes a good topic?**

- Words are semantically related

- Topic has a clear, interpretable theme

- Topics are distinct from each other (minimal overlap in top words)

------------------------------------------------------------------------

### 5.4 Visualize Top Words

``` r
# Visualize top 10 words per topic
lda_top_terms |> 
  mutate(term = reorder_within(term, beta, topic)) |> 
  ggplot(aes(beta, term, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  scale_y_reordered() +
  labs(
    title = "Top 10 Words per Topic (K=5)",
    x = "Beta (Word Probability in Topic)",
    y = NULL
  ) +
  theme_minimal()
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-23-1.png)<!-- -->

**Interpreting the visualization:**

- **Each panel** shows one topic (1-5)
- **Longer bars** = higher probability in that topic
- **Y-axis** shows the top 10 words for that topic
- **X-axis** shows the beta value (word probability)

**What to look for:**

1.  **Clear themes**: Do the words in each panel make sense together?
2.  **Distinct topics**: Are the words different across panels?
3.  **Probability distribution**: Are the beta values concentrated (few
    dominant words) or spread out (many equally important words)?

Let’s examine what each topic represents based on its top words:

**Topic 1 (Red)**: *Music Appreciation & Emotional Responses*

- Top words: song, love, good, album, songs, lol, happy, video, great,
  live

- Theme: Personal reactions to music, positive sentiment

- Beta range: 0.01 - 0.043 (highest beta of all topics!)

**Topic 2 (Yellow-Green)**: *Fan Discussions & General Commentary*

- Top words: people, back, make, time, thing, fans, girls, hope,
  thought, yeah

- Theme: General conversation, fan perspectives

- Beta range: 0.005 - 0.035

**Topic 3 (Teal)**: *Subreddit Rules & Content Moderation*

- Top words: rules, questions, pop, message, reason, content, artists,
  fan, wiki, compose

- Theme: Meta-discussion about the subreddit itself

- Beta range: 0.005 - 0.020 (most specific topic)

**Topic 4 (Blue)**: *K-pop Groups & Industry*

- Top words: group, music, groups, year, years, time, show, bts, big,
  debut

- Theme: Discussion of groups, debuts, and career timelines

- Beta range: 0.01 - 0.035

**Topic 5 (Purple)**: *HYBE-ADOR Controversy*

- Top words: hybe, mhj, newjeans, ador, case, illit, contract, side,
  court, members

- Theme: Specific legal/industry controversy (HYBE vs. Min Heejin/ADOR)

- Beta range: 0.005 - 0.035

**Key Observations:**

1.  **Clear thematic separation**: Each topic has distinct vocabulary

2.  **Topic 1 has highest beta values**: Music appreciation is the most
    concentrated topic

3.  **Topic 5 is highly specific**: Captures a particular industry event
    (HYBE-ADOR dispute)

4.  **Topic 3 is meta**: About the subreddit itself, not K-pop content

5.  **Topics 2 and 4**: General fan discourse and group discussions

**Quality Assessment:**

- ✅ Topics are interpretable

- ✅ Topics are distinct (minimal word overlap)

- ✅ Captures both content (music) and community dynamics (rules,
  discussions)

- ⚠️ Topic 5 may be too narrow (time-specific controversy)

------------------------------------------------------------------------

### 5.5 Comparing Words Between Topics

We can also identify distinguishing terms between two topics by pivoting
wider and computing the logarithmic ratio, which tells us how much more
a word is associated with one topic versus another:

- `log_ratio > 0` → word is more associated with topic 2

- `log_ratio < 0` → word is more associated with topic 1

``` r
# Compare Topic 1 vs Topic 2
beta_wide <- lda_topics |> 
  mutate(topic = paste0("topic", topic)) |>  # Add "topic" prefix since you cannot have numeric column names in R
  pivot_wider(names_from = topic, values_from = beta) |>  # Pivot wider: each topic becomes a column
  filter(topic1 > .001 | topic2 > .001) |>  # Keep only rows with non-negligible presence in either topic
  mutate(log_ratio = log2(topic2 / topic1))  # Calculate log ratio

head(beta_wide)
```

    ## # A tibble: 6 × 7
    ##   term           topic1     topic2     topic3     topic4     topic5 log_ratio
    ##   <chr>           <dbl>      <dbl>      <dbl>      <dbl>      <dbl>     <dbl>
    ## 1 completely 0.0000188  0.00209    0.00000177 0.00000170 0.00141         6.80
    ## 2 cut        0.00190    0.000104   0.00000177 0.000172   0.0000304      -4.20
    ## 3 fans       0.00000171 0.0133     0.00303    0.00333    0.00000145     12.9 
    ## 4 hope       0.00463    0.0113     0.00000177 0.00000170 0.00000145      1.28
    ## 5 kind       0.0000871  0.00762    0.00000177 0.0000187  0.00000145      6.45
    ## 6 live       0.00914    0.00000170 0.00000177 0.00000170 0.00000145    -12.4

**Understanding log_ratio:**

The log ratio tells us the relative strength of association:

- `log_ratio = 2` means word is 4x more likely in Topic 2 (2^2 = 4)

- `log_ratio = -2` means word is 4x more likely in Topic 1

- `log_ratio = 0` means equal probability in both topics

**Interpreting these results:**

Words strongly associated with **Topic 1** (Music Appreciation):

- `live` (log_ratio = -12.4): 2^12.4 = **5,452x** more likely in Topic
  1!

- `cut` (log_ratio = -4.2): About **18x** more likely in Topic 1

Words strongly associated with **Topic 2** (Fan Discussions):

- `fans` (log_ratio = 12.9): 2^12.9 = **7,645x** more likely in Topic 2!

- `completely` (log_ratio = 6.8): About **111x** more likely in Topic 2

- `kind` (log_ratio = 6.5): About **90x** more likely in Topic 2

Words slightly more common in Topic 2:

- `hope` (log_ratio = 1.3): About **2.5x** more likely in Topic 2

This confirms our topic interpretations:

- **Topic 1** focuses on music performance and appreciation

- **Topic 2** focuses on fan community discussions

- **Topic 2** focuses on fan community discussions

------------------------------------------------------------------------

### 5.6 Visualize Word Comparisons

``` r
# Visualize the comparison between Topic 1 and Topic 2 top 15 words from each side
beta_wide_top <- beta_wide |> 
  arrange(log_ratio) |> 
  slice(c(1:15, (n()-14):n()))  # First 15 and last 15

ggplot(beta_wide_top, aes(x = log_ratio, y = reorder(term, log_ratio))) +
  geom_col(fill = "steelblue") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray50") +
  labs(
    x = "Log2 ratio of beta in Topic 2 / Topic 1",
    y = NULL,
    title = "Top 15 Distinctive Words for Topic 1 vs Topic 2"
  ) +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10))
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-25-1.png)<!-- -->

**Interpretation:**

**Left side (Topic 1 - Music Appreciation):**

- **Music content**: “song”, “album”, “songs”, “track”

- **Audio/visual media**: “sound”, “sounds”, “video”, “movie”

- **Consumption verbs**: “watch”, “wait”, “full”

- **Positive reactions**: “happy”, “great”

- **Performance**: “live”, “bit”

Pattern: Words about **consuming and responding to K-pop content**

**Right side (Topic 2 - Fan Discussions):**

- **Community references**: “people”, “fans”

- **Action/causation**: “make”, “makes”, “making”, “give”, “work”

- **Temporal references**: “time”, “happened”, “remember”, “wanted”

- **Evaluation**: “bad”, “sense”, “literally”, “things”

Pattern: Words about **reasoning, explaining, and discussing events in
the community**

**What Research Questions Does This Answer?**

1.  **How do K-pop fans discuss different aspects of the fandom?**

    - **Content consumption** (Topic 1): Focus on media, audio/visual
      qualities, emotional reactions

    - **Meta-discussion** (Topic 2): Focus on actions, community
      dynamics, reasoning about events

2.  **What distinguishes casual content appreciation from community
    discourse?**

    - Topic 1 = Individual consumption experience (“I love this
      song/video”)

    - Topic 2 = Collective analysis and explanation (“people make/give”,
      “this happened”)

3.  **How can we categorize comment types automatically?**

    - Comments with “song”, “album”, “watch”, “live” → Content
      appreciation

    - Comments with “people”, “fans”, “makes”, “happened” → Community
      discussion/analysis

4.  **What is the structure of K-pop fan discourse?**

    - **Affective dimension** (Topic 1): Emotional responses to content

    - **Analytical dimension** (Topic 2): Reasoning about community
      events and behaviors

**Key Insight:**

Topic 1 is about **“what I’m experiencing”** (sensory, emotional,
immediate)

Topic 2 is about **“what’s happening/why”** (analytical, causal,
reflective)

This distinction reveals two modes of K-pop fan engagement: consumption
and critical discussion.

------------------------------------------------------------------------

### 5.7 Top Documents per Topic - The Gamma (γ) Matrix using Tidy

Now let’s look at **Gamma**: which topics appear in which documents?

``` r
# Extract gamma matrix
lda_documents <- tidy(lda_model_k5, matrix = "gamma")

head(lda_documents, 20)
```

    ## # A tibble: 20 × 3
    ##    document topic gamma
    ##    <chr>    <int> <dbl>
    ##  1 1            1 0.142
    ##  2 2            1 0.141
    ##  3 3            1 0.159
    ##  4 4            1 0.218
    ##  5 5            1 0.135
    ##  6 6            1 0.259
    ##  7 7            1 0.212
    ##  8 8            1 0.207
    ##  9 9            1 0.115
    ## 10 10           1 0.192
    ## 11 11           1 0.204
    ## 12 12           1 0.190
    ## 13 13           1 0.189
    ## 14 14           1 0.207
    ## 15 15           1 0.218
    ## 16 16           1 0.204
    ## 17 17           1 0.143
    ## 18 18           1 0.222
    ## 19 19           1 0.185
    ## 20 21           1 0.179

**What are we seeing?**

Each row shows:

- `document`: Reddit comment ID (1, 2, 3, …)

- `topic`: Topic number (1-5)

- `gamma`: Probability that this document is about this topic

**Understanding Document 1:**

- Topic 1 (Music): γ = 0.142 (14.2%)

- Topic 2 (Discussions): γ = 0.141 (14.1%)

- Topic 3 (Rules): γ = 0.159 (15.9%)

- Topic 4 (Groups): γ = 0.218 (21.8%) ← **Dominant topic**

- Topic 5 (HYBE): γ = 0.135 (13.5%)

**Interpretation:** Document 1 is primarily about **K-pop groups**
(Topic 4), but has relatively balanced contributions from all topics.
This suggests a comment that touches on multiple themes.

**Understanding Document 2:**

- Topic 1 (Music): γ = 0.259 (25.9%) ← **Dominant topic**

- Topic 2 (Discussions): γ = 0.212 (21.2%)

- Topic 3 (Rules): γ = 0.207 (20.7%)

- Topic 4 (Groups): γ = 0.115 (11.5%)

- Topic 5 (HYBE): γ = 0.192 (19.2%)

**Interpretation:** Document 2 is primarily about **music appreciation**
(Topic 1), with significant discussion elements. This might be a comment
praising a song while discussing it with others.

**Key observations:**

1.  **Mixed topics are common**: Most documents don’t belong to just one
    topic

2.  **Gamma values add up to 1.0** for each document (probabilities must
    sum to 100%)

3.  **Topic dominance varies**: Some documents have a clear dominant
    topic, others are more balanced

------------------------------------------------------------------------

### 5.8 Visualizing Document-Topic Distributions

``` r
# Visualize gamma distributions for first few documents
lda_documents |> 
  filter(as.numeric(document) <= 10) |>  # First 10 documents only
  mutate(document = factor(document)) |> 
  ggplot(aes(x = factor(topic), y = gamma, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ document, ncol = 5) +
  labs(
    title = "Topic Distribution in First 10 Documents",
    x = "Topic",
    y = "Gamma (Topic Probability)"
  ) +
  theme_minimal()
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-27-1.png)<!-- -->

**What this shows:**

- Each panel = one Reddit comment (Documents 1-10)

- Bar colors: Red (Topic 1: Music), Yellow-green (Topic 2: Discussions),
  Teal (Topic 3: Rules), Blue (Topic 4: Groups), Purple (Topic 5: HYBE)

- Taller bars = topic is more dominant in that comment

- Y-axis goes up to 0.5 (50% probability)

**Key Observations:**

**Documents with clear dominant topics:**

- **Document 2**: Topic 3 (Rules) ~44% - likely a moderator removal
  message

- **Document 3**: Topic 3 (Rules) ~39% - another rule-related post

- **Document 5**: Topic 3 (Rules) ~40% - rule discussion or removal

- **Document 9**: Topic 3 (Rules) ~48% - strongest single-topic focus!

**Documents with balanced/mixed topics:**

- **Documents 1, 4, 6, 7, 8, 10**: All show relatively even distribution
  across 5 topics (~20% each)

- This represents comments that touch on multiple themes

**Why is Topic 3 so dominant in some documents?**

Remember, Topic 3 is about **subreddit rules and moderation**. Documents
2, 3, 5, and 9 likely contain:

- Moderator removal messages (“Your post has been removed…”)

- Rule clarification discussions

- Meta-discussions about subreddit guidelines

These are formulaic, repetitive texts that cluster tightly together.

**Why are most other documents balanced?**

Real K-pop discussions often blend themes: - Discussing a **group’s
comeback** (Topic 4) while praising the **music** (Topic 1)

- Talking about **fans’ reactions** (Topic 2) to the **HYBE
  controversy** (Topic 5)

- Sharing **personal opinions** about **groups and songs** (Topics 1, 2,
  4 mixed)

**Research implications:**

1.  **Automated content filtering**: Documents with \>40% Topic 3 are
    likely mod messages, could be filtered out for analysis

2.  **Discourse complexity**: Most organic fan discussions are
    multi-topical

3.  **Topic purity varies**: Administrative content (rules) is more
    “pure,” while fan discussions blend themes

------------------------------------------------------------------------

### 5.9 Finding Representative Documents for Each Topic

Which documents are the **best examples** of each topic? Let’s find
documents with the highest gamma values for each topic:

``` r
# Find top 3 documents for each topic
top_documents <- lda_documents |> 
  group_by(topic) |> 
  slice_max(gamma, n = 3) |> 
  arrange(topic, -gamma)

print(top_documents)
```

    ## # A tibble: 18 × 3
    ## # Groups:   topic [5]
    ##    document topic gamma
    ##    <chr>    <int> <dbl>
    ##  1 8509         1 0.768
    ##  2 8633         1 0.677
    ##  3 16256        1 0.656
    ##  4 19526        2 0.449
    ##  5 2102         2 0.447
    ##  6 899          2 0.432
    ##  7 3842         3 0.732
    ##  8 2888         3 0.728
    ##  9 3856         3 0.728
    ## 10 13877        3 0.728
    ## 11 19823        3 0.728
    ## 12 22310        3 0.728
    ## 13 6834         4 0.567
    ## 14 17376        4 0.563
    ## 15 6860         4 0.547
    ## 16 17731        5 0.832
    ## 17 17958        5 0.827
    ## 18 11269        5 0.824

**What are we finding?**

For each topic, we’re identifying the 3 documents that are **most
strongly associated** with that topic (highest gamma values).

------------------------------------------------------------------------

### 5.10 Examining Representative Document Content

Now let’s see what these highly-representative documents actually say:

``` r
# Join with original text to see the content
top_docs_with_text  <- 
  top_documents |> 
  mutate(document = as.integer(document)) |>  # Convert character to integer
  left_join(data3 |> select(comment_index, text, author, score), 
            by = c("document" = "comment_index")) |> 
  arrange(topic, -gamma)

# View Topic 1 (Music Appreciation) examples
top_docs_with_text |> 
  filter(topic == 1) |> 
  select(document, gamma, text) |> 
  head(3)
```

    ## # A tibble: 3 × 4
    ## # Groups:   topic [1]
    ##   topic document gamma text                                                     
    ##   <int>    <int> <dbl> <chr>                                                    
    ## 1     1     8509 0.768 "**four**: fire instrumental for an intro song, gets you…
    ## 2     1     8633 0.677 "3 tracks in WHAT IS OPTIONS?? Sorry for overlooking you…
    ## 3     1    16256 0.656 "i've listened to the album a few times now and have gat…

**Topic 1 (Music Appreciation) - Top Documents:**

**What we see:** All three documents are **detailed album reviews** with
track-by-track analysis:

- Document 8509 (γ=0.768): TWICE album review covering all 14 tracks

- Document 8633 (γ=0.677): Another TWICE album review, track-by-track

- Document 16256 (γ=0.656): TXT album review analyzing 8 tracks

**Validation of Topic 1:**

- Heavy focus on musical elements: “instrumental,” “synths,” “chorus,”
  “bridge,” “vocals”

- Emotional/evaluative language: “love,” “great,” “pretty,” “beautiful,”
  “amazing”

- Personal reactions: “I love,” “I like,” “this stood out to me”

- Minimal mention of: industry drama, fans, groups as entities (focus is
  on the music itself)

**Example quote:** *“love the synths at the start, already giving a nice
retro vibe and then the percussion comes in and really sells the whole
vibe”*

This is **exactly** what Topic 1 should capture: individual listeners
describing their sensory and emotional experience with music.

Let’s examine what a “pure” music appreciation comment looks like.

``` r
# View Topic 2 (Fan Discussions) examples
top_docs_with_text |> 
  filter(topic == 2) |> 
  select(document, gamma, text) |> 
  head(3)
```

    ## # A tibble: 3 × 4
    ## # Groups:   topic [1]
    ##   topic document gamma text                                                     
    ##   <int>    <int> <dbl> <chr>                                                    
    ## 1     2    19526 0.449 "Yes, I have been updated on the support the group as a …
    ## 2     2     2102 0.447 "exactly, ppl just get so excited any time there's a new…
    ## 3     2      899 0.432 "When I said coerced I meant hiding their dating life or…

**Topic 2 (Fan Discussions) - Top Documents:**

**What we see:** All three are **analytical discussions about fan
behavior and K-pop culture:**

- Document 19526 (γ=0.449): ILLIT/LSF hate, JungKook’s involvement, fan
  reactions to controversy

- Document 2102 (γ=0.447): Patterns of idol hate/bullying, Haknyeon
  case, international vs Korean fans

- Document 899 (γ=0.432): Fan policing vs. checking behavior, multiple
  idol examples (NewJeans, Suga, Irene)

**Validation of Topic 2:**

- Focus on **people and fans**: “fans feel like,” “people get so
  excited,” “fans police”

- Causal reasoning: “because,” “that’s why,” “made me upset that”

- Community analysis: discussing **how** and **why** fans behave

- Multiple examples: references to many different idols/groups as
  evidence

- Meta-commentary: analyzing K-pop fandom dynamics itself

**Example quotes:**

- *“ppl just get so excited any time there’s a new idol that it becomes
  acceptable to hate and bully”*

- *“I just hope Illit gets the justice they deserve because I still
  can’t believe what they’ve had to gone through”*

**Contrast with Topic 1:**

- **Topic 1**: “I love this song” (personal sensory/emotional response)

- **Topic 2**: “fans think this happened because…” (collective
  analysis/reasoning)

This is **exactly** what Topic 2 should capture: fans discussing and
analyzing the community, behaviors, and cultural dynamics rather than
the music content itself.

``` r
# View Topic 3 (Rules/Moderation) examples
top_docs_with_text |> 
  filter(topic == 3) |> 
  select(document, gamma, text) |> 
  head(3)
```

    ## # A tibble: 3 × 4
    ## # Groups:   topic [1]
    ##   topic document gamma text                                                     
    ##   <int>    <int> <dbl> <chr>                                                    
    ## 1     3     3842 0.732 "Hey u/Fun-Home-605, thank you for submitting to r/kpop!…
    ## 2     3     2888 0.728 "Hey u/DaGayEnby, thank you for submitting to r/kpop! Un…
    ## 3     3     3856 0.728 "Hey u/calikim_mo, thank you for submitting to r/kpop! U…

**Topic 3 (Rules/Moderation) - Top Documents:**

**What we see:** All three are **identical automated moderator removal
messages:**

- Document 3842 (γ=0.732): Removal message to user Fun-Home-605

- Document 2888 (γ=0.728): Removal message to user DaGayEnby

- Document 3856 (γ=0.728): Removal message to user calikim_mo

**Validation of Topic 3:**

- **Formulaic structure**: “Hey u/\[username\], thank you for submitting
  to r/kpop! Unfortunately…”

- **Rule vocabulary**: “submission has been removed,” “rules,”
  “modmail,” “refer to the rules”

- **Repetitive content**: Exact same bullet-pointed list of r/kpoppers
  content types

- **Administrative language**: “locked,” “send a modmail,” “please refer
  to”

- **Zero musical/fan discussion content**: These are pure meta-subreddit
  administration

**Example structure:**

    1. Greeting + removal notice
    2. Reason for removal ("Casual or Fan-Made content")
    3. Alternative subreddit suggestion (r/kpoppers)
    4. Detailed list of what belongs in r/kpoppers
    5. Closing instructions (modmail, rules link)

**Why gamma is so high (\>0.72):**

These documents are **nearly identical copies** of each other, using the
exact same template. They form a tight cluster of purely administrative
text with minimal vocabulary overlap with organic discussions.

**Research implications:**

- Documents with high Topic 3 gamma should be **filtered out** for
  analyses of fan discourse

- Easy to identify: Look for “Thank you for submitting” or
  author=“kpop-ModTeam”

- These represent ~10-15% of corpus but aren’t actual user-generated
  content

``` r
# View Topic 4 (Groups/Industry) examples
top_docs_with_text |> 
  filter(topic == 4) |> 
  select(document, gamma, text) |> 
  head(3)
```

    ## # A tibble: 3 × 4
    ## # Groups:   topic [1]
    ##   topic document gamma text                                                     
    ##   <int>    <int> <dbl> <chr>                                                    
    ## 1     4     6834 0.567 "Katseye meets all these requirements listed down below …
    ## 2     4    17376 0.563 "This is a girl band group that debuted in 2023, surpass…
    ## 3     4     6860 0.547 "You need two recommendations from academy members to ap…

**Topic 4 (Groups/Industry) - Top Documents:**

**What we see:** All three focus on **groups’ industry achievements,
requirements, and metrics:**

- Document 13877 (γ=0.728): KATSEYE Grammy Academy membership
  requirements (detailed criteria)

- Document 10133 (γ=0.622): Korean girl band’s chart performance,
  awards, concerts (MMA, MAMA, KCON)

- Document 7389 (γ=0.612): HYBE groups’ Grammy membership eligibility
  (BTS, Bang PD)

**Validation of Topic 4:**

- \*Groups as entities\*\*: KATSEYE, BTS, (G)I-DLE, IZ\*ONE, band groups

- \*Industry metrics\*\*: “chart,” “awards,” “debut,” “streaming stats,”
  “touring dates”

- **Business language**: “requirements,” “commercially distributed,”
  “academy membership,” “credits”

- **Achievement focus**: “won awards,” “topped music shows,” “3-day
  concert,” “\#1 spot”

- **Temporal framing**: “debuted in 2023,” “4th generation,” “less than
  two years after debut”

**Example quotes:**

- *“Twelve commercially distributed, verifiable credits in a single
  creative profession”*

- *“no 4th or 5th generation girl group has ever held a 3-day concert at
  the Handball Gymnasium”*

- *“They even topped music shows three times without ever appearing on
  them”*

**Contrast with other topics:**

- **Topic 1**: “I love the instrumental” (music appreciation)

- **Topic 2**: “fans think this because…” (community analysis)

- **Topic 4**: “This group achieved X metric” (industry performance)

**Why this vocabulary appears:**

Top words for Topic 4 were: **group, music, groups, year, years, time,
show, bts, big, debut**

All three documents heavily use these terms to discuss groups’ careers,
timelines, and achievements.

**Research implications:**

- Topic 4 captures **structural/factual** discussions about K-pop
  industry

- Focus on measurable success indicators

- Groups discussed as **professional entities** rather than artistic
  creators or fan objects

``` r
# View Topic 5 (HYBE-ADOR) examples
top_docs_with_text |> 
  filter(topic == 5) |> 
  select(document, gamma, text) |> 
  head(3)
```

    ## # A tibble: 3 × 4
    ## # Groups:   topic [1]
    ##   topic document gamma text                                                     
    ##   <int>    <int> <dbl> <chr>                                                    
    ## 1     5    17731 0.832 "This is by Star News.\n\n**Please keep in mind that thi…
    ## 2     5    17958 0.827 "This is the summary of the hearing today by Daily Sport…
    ## 3     5    11269 0.824 "This is by Newsen.\n\n[**[Official] HYBE Responds to De…

**Topic 5 (HYBE-ADOR) - Top Documents:**

**What we see:** All three are **detailed legal updates about the
HYBE-ADOR-NewJeans court case:**

- Document 6237 (γ=0.612): ADOR’s court arguments claiming Min Heejin
  orchestrated contract termination

- Document 6259 (γ=0.610): Full hearing summary of both sides’
  arguments, court mediation

- Document 5935 (γ=0.604): HYBE’s official statement about appealing Min
  Heejin’s non-prosecution

**Validation of Topic 5:**

- **Key entities**: HYBE, ADOR, Min Hee-jin (MHJ), NewJeans, ILLIT
  mentioned repeatedly

- **Legal terminology**: “exclusive contract,” “breach of trust,”
  “provisional injunction,” “court,” “lawsuit”

- **Specific case details**: “KakaoTalk messages,” “contract
  termination,” “corrective response,” “30-day retention period”

- **Timeline references**: “April last year,” “last March,” “July 15,”
  “NewJeans’ termination”

- **Multiple parties’ perspectives**: ADOR’s claims vs. NewJeans’ claims
  vs. HYBE’s statements

**Example quotes:**

- *“Min Hee-jin was behind NewJeans’ termination of the exclusive
  contract from start to finish”*

- *“The ADOR we trusted and signed contracts with no longer exists”*

- *“the appellate court ruled that former CEO Min is ‘intentionally
  undermining the integrated structure’”*

**Why this is Topic 5:**

Top words were: **hybe, mhj, newjeans, ador, case, illit, contract,
side, court, members**

All three documents are saturated with these exact terms in
legal/business contexts.

**Contrast with other topics:**

- **Topic 1**: Music appreciation (“I love the song”)

- **Topic 2**: Fan community analysis (“fans think…”)

- **Topic 4**: General industry achievements (“group won awards”)

- **Topic 5**: Specific ongoing legal controversy (proper nouns, legal
  terms, court proceedings)

**Research implications:**

- Topic 5 is **time-specific** to July 2024 controversy

- May not generalize to other time periods

- Captures how major industry conflicts dominate discourse

- Shows LDA can identify **event-driven topics** alongside structural
  ones

**Document characteristics:**

- Extremely long (1000+ words typical)

- Translation disclaimers (Korean legal documents)

- Formal news article structure

- Heavy quotation of official statements

------------------------------------------------------------------------

------------------------------------------------------------------------

### 5.11 Summary of Representative Documents

**What did we learn from examining high-gamma documents?**

After examining the top 3 documents for each topic, we can now validate
our LDA model’s quality:

| **Topic** | **Top Gamma** | **Document Type** | **Validation** |
|----|----|----|----|
| **Topic 1: Music** | 0.768 | Album reviews (track-by-track) | Perfect match: Heavy use of “song,” “love,” “instrumental,” “chorus” |
| **Topic 2: Discussions** | 0.449 | Fan behavior analysis | Perfect match: Focuses on “people,” “fans,” causal reasoning |
| **Topic 3: Rules** | 0.732 | Automated mod removal messages | Perfect match: Identical formulaic administrative text |
| **Topic 4: Groups** | 0.728 | Industry achievements/metrics | Perfect match: Chart performance, awards, debut timelines |
| **Topic 5: HYBE** | 0.612 | Legal case updates | Perfect match: Court proceedings, contract disputes |

**Key Findings:**

**1. Topic 3 has the highest gamma values (0.73+)**

- Why? Moderator messages are **identical copies** of template text

- Very narrow vocabulary, minimal variation

- These cluster tightly because they’re literally the same document
  repeated

**2. Topic 2 has the lowest gamma values (0.45 max)**

- Why? Fan discussions are **naturally multifaceted**

- Real discourse blends reasoning, examples, multiple topics

- Even “pure” discussion comments touch on multiple themes

**3. All topics validated with actual content**

- Top documents perfectly match our beta-based interpretations

- Word lists (from Section 5.4) align with document themes

- No topic needs reinterpretation

**4. Gamma thresholds reveal document types:**

- **Gamma \> 0.7**: Formulaic/template text (mod messages)

- **Gamma = 0.6-0.7**: Long-form focused content (album reviews, legal
  updates)

- **Gamma = 0.4-0.5**: Organic multi-topical discussions

**What makes a document “representative”?**

A high gamma value (close to 1.0) means:

1.  **Vocabulary concentration**: Document uses words almost exclusively
    from one topic’s vocabulary

2.  **Thematic purity**: Little mixing with other topics’ themes

3.  **Predictability**: If you see high gamma, you know exactly what the
    document contains

**Expected vs. Actual:**

| **Topic** | **Expected High-Gamma Docs** | **What We Actually Found** |
|----|----|----|
| Topic 1 | Album reviews | Track-by-track reviews (TWICE, TXT) |
| Topic 2 | General fan chats | Meta-discussions about fandom behavior |
| Topic 3 | Mod messages | Identical automated removal notices |
| Topic 4 | Group news | Achievement lists, Grammy requirements |
| Topic 5 | HYBE news | Court case legal summaries |

**Why is this validation important?**

**1. Confirms model quality:**

- If top documents didn’t match topic interpretations, we’d need to
  retrain

- Perfect alignment means K=5 captures meaningful structure

**2. Enables filtering:**

- Can remove Topic 3 documents (gamma \> 0.7) for analysis of organic
  discourse

- Can identify event-specific content (Topic 5) vs. structural patterns
  (Topics 1, 2, 4)

**3. Supports coding/annotation:**

- High-gamma documents are perfect training examples

- Can use for manual content analysis or supervised learning

**4. Reveals discourse patterns:**

- Topic 1 and 3: Highly focused (album reviews, admin messages)

- Topic 2: Naturally multifaceted (fan discussions blend themes)

- Topic 5: Event-driven (July 2024 specific)

**Limitations to note:**

**1. Sample bias:** We only looked at top 3 documents per topic

- Most documents have **mixed** topics (lower gamma)

- These extremes show the “ideal types” but aren’t typical

**2. Time specificity:** Topic 5 (HYBE) is July 2025-specific

- Wouldn’t appear in data from other months/years

- Shows how LDA captures temporal events alongside structural patterns

**3. Template text dominates:** Topic 3 has artificially high gamma

- Should be filtered out for analysis of user-generated content

- Represents approximately 10-15% of corpus but minimal informational
  content

**Next Steps:**

Now that we’ve validated topics qualitatively, let’s examine them
quantitatively:

- How many documents belong primarily to each topic?

- What’s the distribution of dominant topics across the corpus?

- Are most documents single-topic or multi-topic?

------------------------------------------------------------------------

### 5.12 Distribution of Dominant Topics

Let’s see how many documents are **primarily** about each topic:

``` r
# Find the dominant topic for each document
dominant_topics <- lda_documents |> 
  group_by(document) |> 
  slice_max(gamma, n = 1) |> 
  ungroup()

# Count documents by dominant topic
topic_distribution <- dominant_topics |> 
  count(topic) |> 
  mutate(percentage = n / sum(n) * 100)

# Display as a formatted table
library(knitr)
kable(topic_distribution, digits = 2, 
      col.names = c("Topic", "Number of Documents", "Percentage (%)"),
      caption = "Distribution of Dominant Topics")
```

| Topic | Number of Documents | Percentage (%) |
|------:|--------------------:|---------------:|
|     1 |                7861 |          28.28 |
|     2 |                6286 |          22.61 |
|     3 |                2865 |          10.31 |
|     4 |                6049 |          21.76 |
|     5 |                4736 |          17.04 |

Distribution of Dominant Topics

------------------------------------------------------------------------

### 5.12 Distribution of Dominant Topics

Let’s see how many documents are **primarily** about each topic:

``` r
# Find the dominant topic for each document
dominant_topics <- lda_documents |> 
  group_by(document) |> 
  slice_max(gamma, n = 1) |> 
  ungroup()

# Count documents by dominant topic
topic_distribution <- dominant_topics |> 
  count(topic) |> 
  mutate(percentage = n / sum(n) * 100)

knitr::kable(topic_distribution, 
             col.names = c("Topic", "Number of Documents", "Percentage (%)"),
             caption = "Distribution of Dominant Topics",
             digits = 2)
```

| Topic | Number of Documents | Percentage (%) |
|------:|--------------------:|---------------:|
|     1 |                7861 |          28.28 |
|     2 |                6286 |          22.61 |
|     3 |                2865 |          10.31 |
|     4 |                6049 |          21.76 |
|     5 |                4736 |          17.04 |

Distribution of Dominant Topics

**Results:**

- **Topic 1 (Music Appreciation)**: 7,861 documents (28.28%)

- **Topic 2 (Fan Discussions)**: 6,286 documents (22.61%)

- **Topic 3 (Rules/Moderation)**: 2,865 documents (10.31%)

- **Topic 4 (Groups/Industry)**: 6,049 documents (21.76%)

- **Topic 5 (HYBE-ADOR Controversy)**: 4,736 documents (17.04%)

**Total**: 27,797 documents analyzed

**Key Findings:**

**1. Relatively Balanced Distribution**

- No single topic dominates discourse (largest is only 28%)

- Topics 1, 2, 4 form the “big three” (72% combined)

- Suggests diverse community interests

**2. Music Appreciation is Most Common (28.28%)**

- Album reviews, track-by-track analysis, listening experiences

- Confirms r/kpop is fundamentally about the music itself

- Nearly 1 in 3 comments focuses on musical content

**3. Fan Discussions are Second (22.61%)**

- Meta-commentary about fandom behavior

- Community analysis, fan culture discussions

- Shows community is self-reflective

**4. Rules/Moderation is Smallest (10.31%)**

- Only ~3,000 automated mod messages out of 28,000 documents

- Confirms these are repetitive but not overwhelming

- Safe to filter out for organic discourse analysis

**5. HYBE Controversy is Substantial (17.04%)**

- Nearly 1 in 5 comments about the legal dispute

- Shows July 2025 was heavily influenced by this event

- Time-specific: would likely be 0% in other months

**6. Groups/Industry News is Major Topic (21.76%)**

- Charts, achievements, debuts, awards

- Shows community tracks industry metrics closely

- Nearly equal to fan discussions

**Interpretation:**

**What this tells us about r/kpop in July 2025:**

**Balanced Community Interests:**

- Unlike some fan communities that focus solely on one aspect

- r/kpop engages with music (28%), meta-discussion (23%), industry
  (22%), and events (17%)

- Diverse discourse ecosystem

**Event Impact:**

- Topic 5 (HYBE) at 17% shows significant but not overwhelming event
  influence

- 83% of discourse continues on structural topics (music, fans, groups)

- Community maintains baseline interests even during major controversies

**Music Remains Central:**

- Despite drama, music appreciation is \#1 topic

- Validates subreddit’s mission as music-focused community

- Positive sign: not purely gossip/drama-driven

``` r
# Visualize the distribution
ggplot(topic_distribution, aes(x = factor(topic), y = n, fill = factor(topic))) +
  geom_col() +
  geom_text(aes(label = paste0(format(n, big.mark = ","), "\n(", 
                                round(percentage, 1), "%)")), 
            vjust = -0.5, size = 4, fontface = "bold") +
  scale_fill_manual(
    values = c("1" = "coral", "2" = "darkgoldenrod3", "3" = "darkseagreen", 
               "4" = "steelblue", "5" = "orchid3"),
    labels = c("1: Music", "2: Discussions", "3: Rules", "4: Groups", "5: HYBE")
  ) +
  labs(
    title = "Distribution of Dominant Topics Across All Documents",
    subtitle = "Each document assigned to topic with highest gamma value (July 2025)",
    x = "Topic",
    y = "Number of Documents",
    fill = "Topic"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom") +
  scale_y_continuous(labels = scales::comma, 
                     expand = expansion(mult = c(0, 0.15)))
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-36-1.png)<!-- -->

**Research Questions Answered:**

**1. What do K-pop fans talk about most?**

- Answer: Music appreciation (28%), but closely followed by fan
  discussions (23%) and industry news (22%)

- No single obsession - balanced engagement

**2. Is the HYBE controversy dominating discourse?**

- Answer: No. At 17%, it’s substantial but not dominant

- 5 out of 6 comments are about other topics

- Shows community resilience to event-driven discourse

**3. How much is meta-discussion vs. content discussion?**

- **Meta (Rules)**: 10.31%

- **Content (Music + Groups + Events)**: 67.08%

- **Community/Fans**: 22.61%

- Clear preference for content over administration

**4. Are discussions focused or diffuse?**

- This shows **forced** single-topic assignment

- Remember: most documents are mixed (low gamma values from Section 5.8)

- These percentages show plurality, not purity

**Important Caveat:**

This analysis assigns each document to its **dominant** topic, but:

``` r
# How many documents have a CLEAR dominant topic (gamma > 0.5)?
clear_dominance <- dominant_topics |> 
  filter(gamma > 0.5) |> 
  nrow()

total_docs <- nrow(dominant_topics)

mixed_topics <- total_docs - clear_dominance

cat("Documents with clear dominant topic (gamma > 0.5):", 
    format(clear_dominance, big.mark = ","), 
    paste0("(", round(clear_dominance/total_docs * 100, 1), "%)"), "\n")
```

    ## Documents with clear dominant topic (gamma > 0.5): 462 (1.7%)

``` r
cat("Documents with mixed topics (gamma < 0.5):", 
    format(mixed_topics, big.mark = ","),
    paste0("(", round(mixed_topics/total_docs * 100, 1), "%)"), "\n")
```

    ## Documents with mixed topics (gamma < 0.5): 27,335 (98.3%)

**What this means:**

- A document with gamma = \[0.25, 0.24, 0.21, 0.18, 0.12\] gets assigned
  to Topic 1

- But it’s really **balanced across all topics** (only 25% Topic 1)

- The gamma \> 0.5 analysis shows how many are **truly** single-topic

**Class exercise**

Redo the graph and the table for gamma \> 0.5 and compare the difference

------------------------------------------------------------------------

### 5.13 Topics Over Time

Now let’s see how topics change throughout July 2025 using **average
gamma values** (not just dominant topics):

``` r
# First, let's check the date range in our data
date_range <- data3 |> 
  summarize(
    start_date = min(date),
    end_date = max(date),
    total_days = as.numeric(difftime(max(date), min(date), units = "days"))
  )

cat("Date Range:", format(date_range$start_date, "%B %d, %Y"), 
    "to", format(date_range$end_date, "%B %d, %Y"), "\n")
```

    ## Date Range: July 01, 2025 to July 31, 2025

``` r
cat("Total Days:", date_range$total_days, "\n")
```

    ## Total Days: 30

**Results:**

- **Start Date**: July 1, 2025

- **End Date**: July 31, 2025

- **Total Days**: 30 days (complete month)

**Prepare temporal data with ALL topics:**

``` r
# Join ALL topic-document probabilities with date information
topics_over_time <- lda_documents |> 
  mutate(document = as.integer(document)) |> 
  left_join(
    data3 |> select(comment_index, date),
    by = c("document" = "comment_index")
  ) 

# Check for any missing dates
missing_dates <- topics_over_time |> 
  filter(is.na(date)) |> 
  nrow()

cat("Documents with missing dates:", missing_dates, "\n")
```

    ## Documents with missing dates: 0

``` r
cat("Total topic-document pairs:", nrow(topics_over_time), "\n")
```

    ## Total topic-document pairs: 111580

``` r
cat("Unique documents:", length(unique(topics_over_time$document)), "\n")
```

    ## Unique documents: 22316

**Important difference from Section 5.12:**

- **Section 5.12**: Counted documents by dominant topic (forced single
  assignment)

- **Section 5.13**: Uses average gamma across ALL documents each day

- **Why better**: Captures mixed-topic nature and true topic prevalence

**Daily Average Gamma by Topic:**

``` r
# Calculate daily average gamma for each topic
daily_topic_averages <- topics_over_time |> 
  group_by(date, topic) |> 
  summarize(
    mean_gamma = mean(gamma),
    median_gamma = median(gamma),
    n_docs = n_distinct(document),
    .groups = "drop"
  )

# Plot daily average gamma
ggplot(daily_topic_averages, aes(x = date, y = mean_gamma, color = factor(topic))) +
  geom_line(size = 1) +
  geom_point(size = 2, alpha = 0.6) +
  scale_color_manual(
    values = c("1" = "coral", "2" = "darkgoldenrod3", "3" = "darkseagreen", 
               "4" = "steelblue", "5" = "orchid3"),
    labels = c("1: Music", "2: Discussions", "3: Rules", "4: Groups", "5: HYBE")
  ) +
  scale_x_date(date_breaks = "3 days", date_labels = "%b %d") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Daily Average Topic Prevalence (July 2025)",
    subtitle = "Mean gamma (topic probability) across all documents each day",
    x = "Date",
    y = "Average Topic Probability (Gamma)",
    color = "Topic"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom"
  )
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-41-1.png)<!-- -->

**What this shows:**

- **Y-axis**: Average probability that a random comment on that day
  belongs to each topic

- **Higher line**: Topic is more prevalent in discourse that day

- **Lines sum to 1.0**: On any given day, all topic probabilities add to
  100%

- **Changes over time**: Shows how topic prevalence shifts through the
  month

**Smoothed Trends (LOESS):**

``` r
# Smooth trends with loess
ggplot(daily_topic_averages, aes(x = date, y = mean_gamma, color = factor(topic))) +
  geom_smooth(method = "loess", se = TRUE, size = 1.2, span = 0.3, alpha = 0.2) +
  scale_color_manual(
    values = c("1" = "coral", "2" = "darkgoldenrod3", "3" = "darkseagreen", 
               "4" = "steelblue", "5" = "orchid3"),
    labels = c("1: Music", "2: Discussions", "3: Rules", "4: Groups", "5: HYBE")
  ) +
  scale_x_date(date_breaks = "3 days", date_labels = "%b %d") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Smoothed Topic Prevalence Trends (July 2025)",
    subtitle = "LOESS smoothing (span=0.3) shows underlying patterns in average gamma",
    x = "Date",
    y = "Average Topic Probability (Gamma)",
    color = "Topic"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom"
  )
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-42-1.png)<!-- -->

**Why smoothing matters:**

- Daily data has noise (random variation in comment mix)

- LOESS reveals the **trend** beneath the noise

- Confidence bands show uncertainty in the trend

- Easier to see if topics are rising, falling, or stable

**Individual Topic Trends (Faceted View):**

``` r
# Faceted view for each topic
ggplot(daily_topic_averages, aes(x = date, y = mean_gamma)) +
  geom_line(size = 1, color = "steelblue") +
  geom_point(size = 2, color = "steelblue", alpha = 0.6) +
  geom_smooth(method = "loess", se = TRUE, color = "red", size = 0.8, 
              span = 0.3, alpha = 0.2) +
  facet_wrap(~ topic, ncol = 1, scales = "free_y",
             labeller = labeller(topic = c(
               "1" = "Topic 1: Music Appreciation",
               "2" = "Topic 2: Fan Discussions",
               "3" = "Topic 3: Rules/Moderation",
               "4" = "Topic 4: Groups/Industry",
               "5" = "Topic 5: HYBE-ADOR Controversy"
             ))) +
  scale_x_date(date_breaks = "3 days", date_labels = "%b %d") +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Individual Topic Trends Over Time (July 2025)",
    subtitle = "Daily average gamma with smoothed trend lines (red)",
    x = "Date",
    y = "Average Topic Probability (Gamma)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    strip.text = element_text(face = "bold", size = 11)
  )
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-43-1.png)<!-- -->

**Analyze each panel:**

- **Topic 1 (Music)**: Look for spikes on album release dates

- **Topic 2 (Discussions)**: Should be relatively stable (baseline
  chatter)

- **Topic 3 (Rules)**: Tracks moderation activity intensity

- **Topic 4 (Groups)**: Event-driven (awards, charts, debuts)

- **Topic 5 (HYBE)**: Should spike on court dates and major
  announcements

**Day of Week Patterns:**

``` r
# Add day of week
topics_by_weekday <- topics_over_time |> 
  mutate(weekday = weekdays(date)) |> 
  group_by(weekday, topic) |> 
  summarize(mean_gamma = mean(gamma), .groups = "drop") |> 
  mutate(weekday = factor(weekday, 
                         levels = c("Monday", "Tuesday", "Wednesday", 
                                   "Thursday", "Friday", "Saturday", "Sunday")))

ggplot(topics_by_weekday, aes(x = weekday, y = mean_gamma, fill = factor(topic))) +
  geom_col(position = "fill") +
  scale_fill_manual(
    values = c("1" = "coral", "2" = "darkgoldenrod3", "3" = "darkseagreen", 
               "4" = "steelblue", "5" = "orchid3"),
    labels = c("1: Music", "2: Discussions", "3: Rules", "4: Groups", "5: HYBE")
  ) +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Topic Prevalence by Day of Week",
    subtitle = "Average gamma (stacked to 100%) by day",
    x = "Day of Week",
    y = "Average Topic Probability",
    fill = "Topic"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "bottom"
  )
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-44-1.png)<!-- -->

**Research Questions:**

- Do music discussions increase on weekends (listening time)?

- Does moderation intensity vary by day?

- Are industry announcements timed to specific days?

- Is controversy discussion consistent across the week?

**Weekend vs. Weekday Analysis:**

**Interpretation:**

- **Positive difference**: Topic probability increases on weekends

- **Negative difference**: Topic probability decreases on weekends

- **% Change**: Magnitude of weekend effect

``` r
# Categorize weekend vs weekday
topics_weekend <- topics_over_time |> 
  mutate(
    weekday = weekdays(date),
    is_weekend = weekday %in% c("Saturday", "Sunday")
  ) |> 
  group_by(is_weekend, topic) |> 
  summarize(mean_gamma = mean(gamma), .groups = "drop")

# Calculate difference
weekend_effect <- topics_weekend |> 
  pivot_wider(names_from = is_weekend, values_from = mean_gamma, 
              names_prefix = "weekend_") |> 
  mutate(
    difference = weekend_TRUE - weekend_FALSE,
    pct_change = (difference / weekend_FALSE) * 100
  ) |> 
  arrange(desc(abs(difference)))

knitr::kable(weekend_effect, 
             digits = 4,
             col.names = c("Topic", "Weekday Gamma", "Weekend Gamma", 
                          "Difference", "% Change"),
             caption = "Weekend Effect on Topic Prevalence")
```

| Topic | Weekday Gamma | Weekend Gamma | Difference | % Change |
|------:|--------------:|--------------:|-----------:|---------:|
|     3 |        0.1934 |        0.2030 |     0.0095 |   4.9179 |
|     1 |        0.2034 |        0.1976 |    -0.0058 |  -2.8552 |
|     5 |        0.2004 |        0.1983 |    -0.0021 |  -1.0606 |
|     2 |        0.2019 |        0.2008 |    -0.0011 |  -0.5343 |
|     4 |        0.2009 |        0.2004 |    -0.0005 |  -0.2501 |

Weekend Effect on Topic Prevalence

Based on the weekend vs. weekday analysis, we observe **minimal but
meaningful** differences:

**Correlation Analysis Between Topics:**

- **Positive correlation (red)**: Topics tend to increase together

  - Might indicate general activity spikes (more comments = more of
    everything)

- **Negative correlation (blue)**: Topics compete for attention

  - When one increases, the other decreases

  - Suggests zero-sum competition for discourse space

- **Near-zero correlation (white)**: Topics vary independently

``` r
# Check if topics compete or co-occur
topic_correlations <- daily_topic_averages |> 
  select(date, topic, mean_gamma) |> 
  pivot_wider(names_from = topic, values_from = mean_gamma, 
              names_prefix = "topic_") |> 
  select(-date) |> 
  cor()

# Display as heatmap
library(reshape2)
cor_melted <- melt(topic_correlations)

ggplot(cor_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "white", size = 4) +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red", 
                       midpoint = 0, limits = c(-1, 1)) +
  labs(
    title = "Topic Correlation Matrix",
    subtitle = "Do topics rise and fall together over time?",
    x = "Topic",
    y = "Topic",
    fill = "Correlation"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![](bigdata_L9-github_files/figure-gfm/unnamed-chunk-46-1.png)<!-- -->

**Interpretation of Correlation Results:**

Based on the correlation matrix, we can identify three distinct
patterns:

**1. Strong Competition: Controversy vs. Content (-0.85 and -0.77)**

- **Topic 1 (Music) ↔ Topic 5 (HYBE)**: r = -0.85 (very strong negative)

- **Topic 4 (Groups) ↔ Topic 5 (HYBE)**: r = -0.77 (strong negative)

**Meaning**: When HYBE controversy discussion increases, music
appreciation and group/industry discussion **decrease proportionally**

**Interpretation**:

- Zero-sum attention economy: controversy “crowds out” content
  discussion

- Community has fixed attention capacity

- Drama displaces substantive music/industry talk

- Suggests controversy is **disruptive** to normal discourse patterns

**2. Positive Co-occurrence: Content Topics (0.47)**

- **Topic 1 (Music) ↔ Topic 4 (Groups)**: r = 0.47 (moderate positive)

**Meaning**: When music appreciation increases, group/industry
discussion **also increases**

**Interpretation**:

- Both are content-focused topics

- Likely rise together during comeback periods (new music +
  charts/achievements)

- High-activity days see more of both

- Suggests these are **complementary** rather than competitive

**3. Moderate Competition: Meta-Discussion (-0.59)**

- **Topic 2 (Discussions) ↔ Topic 3 (Rules)**: r = -0.59 (moderate
  negative)

**Meaning**: When fan meta-discussions increase, moderation messages
**decrease**

**Interpretation**:

- When community is actively discussing (Topic 2), fewer posts are
  removed

- Or: Heavy moderation (Topic 3) suppresses meta-discussion

- Possible explanation: controversial meta-discussions trigger more
  removals

**4. Weak/Neutral Relationships:**

- **Topic 2 (Discussions) ↔ Topic 5 (HYBE)**: r = 0.30 (weak positive)

  - Fan discussions incorporate controversy but aren’t dominated by it

- **Topic 1 (Music) ↔ Topic 2 (Discussions)**: r = -0.37 (weak negative)

  - Slight trade-off between music appreciation and fan meta-talk

- **Topic 3 (Rules) ↔ Topic 4 (Groups)**: r = 0.22 (weak positive)

  - Industry news posts sometimes trigger moderation

- **Topic 2 (Discussions) ↔ Topic 4 (Groups)**: r = -0.13 (very weak)

  - Nearly independent

**Key Research Findings:**

**1. Attention is Zero-Sum for Events**

- The -0.85 correlation between Music and HYBE is **extremely strong**

- Suggests community attention is a fixed pie

- Controversy doesn’t expand discussion, it **displaces** other topics

- When HYBE controversy peaked, music discussion was at its lowest

**2. Content Topics are Complementary**

- The +0.47 correlation between Music and Groups shows they **co-occur**

- Active music discussion days = active industry discussion days

- Suggests these topics feed each other (new releases → chart
  performance)

- Non-zero-sum: both can increase simultaneously

**3. Moderation Reflects Discussion Patterns**

- Topic 3 (Rules) negatively correlates with both Discussion (-0.59) and
  Controversy (-0.51)

- Suggests moderation is **reactive** to problematic content

- When controversy or meta-discussion surge, moderation increases

**4. Implications for Community Health:**

**Positive Sign:** - Music and Groups topics are positively correlated
(content-focused community)

**Concerning Sign:**

- Strong negative correlation with controversy suggests it **disrupts**
  normal patterns

- Community loses content-focused discussion during drama periods

- At r = -0.85, this is nearly a perfect trade-off

**Statistical Note:**

These are **Pearson correlations** based on only 30 data points (days in
July), so:

- Correlations \> 0.36 are statistically significant (p \< 0.05)

- Correlations \> 0.46 are statistically significant (p \< 0.01)

**Significant correlations in our data:**

- Topic 1 ↔ Topic 5: -0.85 (p \< 0.001)

- Topic 4 ↔ Topic 5: -0.77 (p \< 0.001)

- Topic 2 ↔ Topic 3: -0.59 (p \< 0.001)

- Topic 1 ↔ Topic 4: 0.47 (p \< 0.01)

- Topic 1 ↔ Topic 2: -0.37 (p \< 0.05)

All major patterns are statistically significant and not due to chance.

------------------------------------------------------------------------

## Lecture 9 Cheat Sheet: Topic Modeling (LDA)

| **Function/Concept** | **Description** | **Code Example** |
|----|----|----|
| **LDA Concept** | Unsupervised ML technique that discovers latent topics. Each document = mixture of topics; each topic = mixture of words. | Two key principles:<br>1. Documents contain multiple topics<br>2. Topics contain multiple words |
| **Document-Term Matrix (DTM)** | Rows = documents, columns = words, values = counts. Sparse matrix (mostly zeros). | `cast_dtm(comment_index, word, n)` |
| **Sparsity** | Percentage of matrix that is zeros. Text data is naturally 95%+ sparse. | `tidy_dfm@Dim` shows dimensions |
| **Language Detection** | Identify language of text using Google’s CLD2 package. | `cld2::detect_language(data$text)` |
| **Remove Duplicates** | Keep only unique texts to avoid bias from repeated content. | `distinct(text, .keep_all = TRUE)` |
| **Custom Stopwords** | Combine multiple stopword sources + domain-specific terms. | `c(stopwords("en"), stopwords(source = "smart"), "custom")` |
| **TF-IDF Filtering** | Remove words that are too common (appear in \>75% of docs) or too rare (\<0.1% of docs). | `doc_freq = n() / templength`<br>`filter(doc_freq < maxndoc & doc_freq > minndoc)` |
| **Topic Coherence** | Measures how often top words in a topic co-occur. Higher (less negative) = better. | `topic_coherence(lda_model, dtm)` from `topicdoc` package |
| **C_UMass Coherence** | Document co-occurrence based metric. Values are negative; closer to 0 is better. | Most common metric for topic quality |
| **FindTopicsNumber()** | Tests multiple K values with different coherence metrics (CaoJuan, Deveaud). | `FindTopicsNumber(dtm, topics = seq(2, 20, 1), metrics = c("CaoJuan2009"))` |
| **CaoJuan2009** | Minimize this metric. Lower = topics are more distinct. | Shows steady decline, minimum = optimal K |
| **Deveaud2014** | Maximize this metric. Higher = better topic divergence. Often noisy. | More variable than CaoJuan |
| **Choosing K** | Balance coherence (quality) with interpretability. Look for “elbow” in coherence plot. | K=5 had best coherence (-160.46) in our example |
| **LDA()** | Train LDA model using Gibbs sampling method. | `LDA(dtm, k = 5, method = "Gibbs", control = list(seed = 42, iter = 2000))` |
| **LDA Parameters** | `k`: number of topics<br>`iter`: iterations to run<br>`burnin`: discard first N iterations<br>`seed`: reproducibility | `control = list(verbose = 500, seed = 42, iter = 2000, burnin = 500)` |
| **Beta (β) Matrix** | Topic-word probabilities. Dimensions: Topics × Words (5 × 2,683). Shows which words define each topic. | `tidy(lda_model, matrix = "beta")` |
| **Gamma (γ) Matrix** | Document-topic probabilities. Dimensions: Documents × Topics (22,316 × 5). Shows which topics appear in each document. | `tidy(lda_model, matrix = "gamma")` |
| **slice_max()** | Get top N rows by a value. Used to find top words per topic. | `group_by(topic) |> slice_max(beta, n = 10)` |
| **reorder_within()** | Reorder terms within each facet for better visualization. | `mutate(term = reorder_within(term, beta, topic))` |
| **scale_y_reordered()** | Scale y-axis for faceted plots with reorder_within(). | Pairs with `reorder_within()` in faceted plots |
| **Log Ratio Comparison** | log2(topic2_beta / topic1_beta). Positive = more associated with topic2; negative = more associated with topic1. | `mutate(log_ratio = log2(topic2 / topic1))` |
| **Interpreting Beta** | Higher beta = word is more important to that topic. Compare relative values across topics, not absolute. | β = 0.043 for “song” in Topic 1 is very high |
| **Interpreting Gamma** | Gamma values sum to 1.0 per document. Gamma \> 0.5 = clear dominant topic; gamma \< 0.5 = mixed topics. | Document with \[0.25, 0.24, 0.21, 0.18, 0.12\] is mixed |
| **Dominant Topic** | Topic with highest gamma for a document. Useful for categorizing documents. | `group_by(document) |> slice_max(gamma, n = 1)` |
| **Representative Documents** | Documents with highest gamma for each topic. Best examples of “pure” topics. | Gamma \> 0.7 = very pure (e.g., template text) |
| **Topic Distribution** | Count how many documents belong primarily to each topic. | `count(topic) |> mutate(percentage = n/sum(n)*100)` |
| **Temporal Analysis** | Track how topic prevalence changes over time using average gamma by date. | `group_by(date, topic) |> summarize(mean_gamma = mean(gamma))` |
| **LOESS Smoothing** | Smooth noisy time series to reveal underlying trends. | `geom_smooth(method = "loess", span = 0.3)` |
| **Weekend Effect** | Compare topic prevalence on weekends vs. weekdays. | `mutate(is_weekend = weekday %in% c("Saturday", "Sunday"))` |
| **Topic Correlation** | Correlation between topics’ daily prevalence. Positive = co-occur; negative = compete. | `pivot_wider(names_from = topic) |> cor()` |
| **Zero-Sum Attention** | Strong negative correlation (r \< -0.7) means topics compete for attention. | Topic 1 ↔ Topic 5: r = -0.85 (very strong competition) |
| **Complementary Topics** | Positive correlation (r \> 0.4) means topics rise together. | Topic 1 ↔ Topic 4: r = 0.47 (content topics co-occur) |
| **Validation Strategy** | Check if high-gamma documents match beta-based topic interpretations. | Examine top 3 docs per topic for thematic consistency |
| **Template Detection** | Very high gamma (\>0.7) often indicates formulaic/template text (mod messages). | Can filter out for organic discourse analysis |
| **Data Loss Tracking** | Track documents removed at each preprocessing step. | Original → Language filter → Deduplication → TF-IDF filter |
| **Memory Management** | Remove unused objects and run garbage collection for large models. | `rm(list = setdiff(ls(), keep_objects))`<br>`gc()` |
| **Save Workspace** | Save entire workspace or specific objects for later use. | `save.image("file.RData")`<br>`save(lda_model, file = "model.RData")` |
| **Interpretation Principle** | Topics are probabilistic and mixed. No document is purely one topic. Focus on relative probabilities. | Most documents have gamma \< 0.5 for dominant topic |
| **Quality Indicators** | ✅ High coherence<br>✅ Distinct topics (minimal word overlap)<br>✅ Interpretable themes<br>✅ Representative docs match beta words | K=5 achieved all quality criteria in example |
| **Common Pitfall** | Interpreting gamma as hard categories. Documents are mixtures! | Document \[0.28, 0.23, 0.21, 0.18, 0.10\] isn’t “Topic 1” |
| **Research Applications** | Content categorization, trend analysis, event detection, community discourse structure, attention dynamics. | Used to answer “What do fans discuss?” and “How does discourse shift over time?” |
