Text as Data: Dictionary Methods and Word Embeddings
================
Dr. Ayse D. Lokmanoglu
Lecture 7, (B) March 16, (A) March 4

# R Exercises

------------------------------------------------------------------------

## Lecture 7 Table of Contents

| Section | Topic                                                   |
|---------|---------------------------------------------------------|
| 1       | Introduction to Text as Data                            |
| 2       | Dictionary Methods                                      |
| 2.1     | Online Dataset: Twitter Data                            |
| 2.2     | Text Preprocessing                                      |
| 2.3     | Sentiment Analysis with Dictionary Methods              |
| 2.4     | Visualizing and Comparing Sentiment Analysis Results    |
| 2.5     | Most common positive and negative words                 |
| 2.6     | Normalize sentiment scores                              |
| 3       | Word Embeddings                                         |
| 3.1     | Introduction to Word Embeddings                         |
| 3.1.1   | Continuous Bag of Words (CBOW)                          |
| 3.1.2   | Skip-Gram Model                                         |
| 3.2     | Applying Word Embeddings in R                           |
| 3.2.1   | Training Word2Vec with CBOW                             |
| 3.2.2   | Visualize CBOW                                          |
| 3.2.3   | Training Word2Vec with Skip Gram                        |
| 4       | Class Exercises: Sentiment Analysis and Word Embeddings |

------------------------------------------------------------------------

**ALWAYS** Let’s load our libraries

``` r
library(tidyverse)   # Data manipulation and visualization (includes dplyr, ggplot2, tidyr, stringr)
library(tidytext)    # Text mining using tidy data principles
library(ggplot2)     # Creating visualizations and plots
library(stopwords)   # Access to stopword lists in multiple languages
library(word2vec)    # Training word embedding models (CBOW and Skip-Gram)
library(umap)        # Dimensionality reduction for visualizing high-dimensional data
library(wordcloud2)  # Creating interactive word clouds
library(plotly)      # Creating interactive plots and visualizations
library(htmlwidgets)
```

## 1. Introduction to Text as Data

Text data:

- is unstructured,

- requires preprocessing to be analyzed.

![](https://media.geeksforgeeks.org/wp-content/uploads/20210526142713/BlockDigramofTextMining.png)
*source:
<https://media.geeksforgeeks.org/wp-content/uploads/20210526142713/BlockDigramofTextMining.png>*

| **Phase** | **Technique** | **Core Question** | **Purpose** | **Methods & R Packages** |
|----|----|----|----|----|
| **Text Preprocessing** | Tokenization | How can we segment text into meaningful units? | Convert text into individual words or phrases. | `tidytext` (`unnest_tokens()`), `stringr` (`str_split()`) |
|  | Stopword Removal | How can we remove redundant words? | Eliminate common words that add little meaning. | `tidytext` (`stop_words`), `stopwords` |
|  | Lemmatization & Stemming | How can we reduce word variations? | Standardize words to their root forms. | `textstem` (`lemmatize_words()`), `SnowballC` (`wordStem()`) |
| **Feature Engineering** | N-grams | How can we capture word sequences? | Identify multi-word expressions and patterns. | `tidytext` (`unnest_tokens(ngrams = 2)`), `text2vec` |
|  | Part-of-Speech Tagging | How can we recognize word functions? | Assign grammatical categories to words. | `udpipe` (`udpipe_annotate()`), `spacyr` |
| **Content Analysis** | Dictionary-Based Analysis | How can we quantify meaning in text? | Detect linguistic, psychological, or topical patterns. | `tidytext` (`get_sentiments()`), `quanteda` (`dfm_lookup()`) |
| **Machine Learning** | Supervised Classification | How can we predict categories from text? | Assign labels based on prior training examples. | `caret`, `textrecipes`, `tidymodels` |
|  | Unsupervised Clustering | How can we discover hidden patterns? | Group similar documents or topics automatically. | `topicmodels` (LDA), `quanteda` (k-means clustering), `text2vec` (word embeddings) |

We will learn 2 methods today:

1.  **Dictionary Methods** - Using predefined word lists to categorize
    text (e.g., sentiment analysis with lexicons).

2.  **Word Embeddings** - Representing words as numerical vectors to
    capture semantic relationships and similarities.

------------------------------------------------------------------------

## 2. Dictionary Methods

Dictionary-based methods assign predefined categories to words.

### 2.1 Online Dataset: Amazon Sales Data

Dataset Citation: Karkavel Raja, J. (2023). Amazon sales dataset \[Data
set\]. Kaggle.
<https://www.kaggle.com/datasets/karkavelrajaj/amazon-sales-dataset>

**Note:** **This dataset is raw and unfiltered, meaning it may contain
explicit language, including swear words. Please proceed with awareness
and discretion.**

We will use a publicly available Amazon Sales Review Dataset, which
contains tweets labeled as positive, neutral, or negative.

``` r
amazon_data <- read_csv("https://raw.githubusercontent.com/aysedeniz09/IntroCSS/refs/heads/main/data/amazon.csv")

colnames(amazon_data)
```

    ##  [1] "product_id"          "product_name"        "category"           
    ##  [4] "discounted_price"    "actual_price"        "discount_percentage"
    ##  [7] "rating"              "rating_count"        "about_product"      
    ## [10] "user_id"             "user_name"           "review_id"          
    ## [13] "review_title"        "review_content"      "img_link"           
    ## [16] "product_link"

------------------------------------------------------------------------

### 2.2 Text Preprocessing

Since we are working with the **review_content column** from the Amazon
sales dataset, we need to ensure proper formatting before tokenization.
We will create a new `text` column, remove unnecessary whitespace,
convert text to lowercase, remove URLs and numbers, and maintain
consistency across all reviews. We’ll also add an index column to help
with merging data later in our analysis.

``` r
# Ensure text is properly formatted
amazon_data <- amazon_data |>
  mutate(textBU = review_content,   ### created a backup column so we always have the OG review
    text = str_squish(review_content)) |>
  filter(!is.na(text)) |>
  mutate(text = str_to_lower(text)) |> # Convert to lowercase
  mutate(text = str_remove_all(text, "https?://\\S+")) |> # Remove URLs
  mutate(text = str_remove_all(text, "\\d+")) |>  # Remove numbers
  mutate(review_index = seq_len(nrow(amazon_data))) |> ### creating an index
  mutate(nwords = str_count(text, "\\w+")) ### counting number of words

head(amazon_data$text)
```

    ## [1] "looks durable charging is fine toono complains,charging is really fast, good product.,till now satisfied with the quality.,this is a good product . the charging speed is slower than the original iphone cable,good quality, would recommend, had worked well till date and was having no issue.cable is also sturdy enough...have asked for replacement and company is doing the same...,value for money"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    ## [2] "i ordered this cable to connect my phone to android auto of car. the cable is really strong and the connection ports are really well made. i already has a micro usb cable from ambrane and it's still in good shape. i connected my phone to the car using the cable and it got connected well and no issues. i also connected it to the charging port and yes it has fast charging support.,it quality is good at this price and the main thing is that i didn't ever thought that this cable will be so long it's good one and charging power is too good and also supports fast charging,value for money, with extra length👍,good, working fine,product quality is good,good,very good,bought for my daughter's old phone.brand new cable it was not charging, i already repacked and requested for replacement.i checked again, and there was some green colour paste/fungus inside the micro usb connector. i cleaned with an alcoholic and starts working again.checked the ampere of charging speed got around ma-ma - not bad, came with braided .m long cable, pretty impressive for the price.can't blame the manufacturer.but quality issues by the distributor, they might have stored in very humid place."                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
    ## [3] "not quite durable and sturdy, good, nice product,working well,it's a really nice product"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
    ## [4] "good product,long wire,charges good,nice,i bought this cable for rs. worthy product for this price, i tested it in various charger adapters w and w it supports fast charging as well.,good,ok,i had got this at good price on sale on amazon and product is useful with warranty but for warranty you need to go very far not practical for such a cost and mine micro to type c connector stopped working after few days only.,i like this product"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
    ## [5] "bought this instead of original apple, does the work for rs, not as fast as apple charger but its a good option if you want cheap and good product, bought it for ipad pro . and it's working flawlessly, build quality is ok, its not like i am gonna hang my clothes on it and i want a very strong cable, even a braided cable stop working after a year, i have used both anker and apple store strong braided cable they all stop working after a year so please don't buy high end cables just for that instead choose a this one and even if it's stops working withing a year you only loose rs compares to rs.update------------------------------------pin has stopped charging from one side, now i have to slip the pin to charge from other side, but i will update and let know for how long does it work,,it’s good. not sure about durability as the pin area feels a bit fragile,does not support apple carplayso was little disappointed about thatother than that cable is made up of very good quality,best to buy,% not fathful,writing this review post  months and  orders of the same product.honestly portronics konnect l lightning cable works like magic with the original apple charging brick.seeing the price of the cable i initially hesitated buying as it was as low as ₹/- with the offers and so i wasn’t sure if it would work well with my iphone  or whether it would impact my iphone’s battery health because all the other lightning cable brands were costing over ₹/- like wayona, amazon basics, etc.earlier i was using wayona brand lightning cable with eventually frayed and stopped working.charging speed:charges my iphone fast enough almost similar compared to the original cable level when used with w original apple power adapter.quality and durability:great quality braided cable and doesn’t tangle easily and can withstand day-to-day usage.l-shaped pin:this is very innovative by portronics and it makes sure the cable doesn’t get damaged even if used while charging.carplay and data sync:works smoothly with carplay and syncs data effortlessly.ps: i have used this cable only with the original apple charging brick and extremely satisfied with its performance.,better than i expect the product i like that quality and i plan to buy same type cable come with usb c to lighting cable for emergency purpose that much i love this cable. buy for this cable only emergency uses only since good one,good product and value for money"
    ## [6] "it's a good product.,like,very good item strong and useful usb cablevalue for moneythanks to amazon and producer, product and useful product,-,sturdy but does not support w charging"

Before applying dictionary methods, we need to clean the text by:

- Tokenizing the reviews into individual words

- Removing stop words (common words like “the”, “and”, “is” that don’t
  carry much sentiment)

- Removing unnecessary characters

``` r
# Tokenize text
amazon_tokens <- amazon_data |> 
  unnest_tokens(word, text) |>
  anti_join(stop_words, by = "word") ## removing stopwords

# View tokenized words
head(amazon_tokens$word)
```

    ## [1] "durable"   "charging"  "fine"      "toono"     "complains" "charging"

------------------------------------------------------------------------

### 2.3 Sentiment Analysis with Dictionary Methods

To understand how different sentiment analysis lexicons classify text,
we will compare results from multiple dictionaries, including **Bing**,
**AFINN**, and **NRC**. Each lexicon provides different insights:

- **Bing**: Binary classification (positive/negative sentiment).
- **AFINN**: Numeric scores for sentiment intensity.
- **NRC**: Categorizes words into emotional dimensions (anger, joy,
  fear, etc.).

**Note: For AFINN and NRC you need to select 1 in your console when
prompted**

``` r
get_sentiments("afinn")
```

    ## # A tibble: 2,477 × 2
    ##    word       value
    ##    <chr>      <dbl>
    ##  1 abandon       -2
    ##  2 abandoned     -2
    ##  3 abandons      -2
    ##  4 abducted      -2
    ##  5 abduction     -2
    ##  6 abductions    -2
    ##  7 abhor         -3
    ##  8 abhorred      -3
    ##  9 abhorrent     -3
    ## 10 abhors        -3
    ## # ℹ 2,467 more rows

``` r
get_sentiments("bing")
```

    ## # A tibble: 6,786 × 2
    ##    word        sentiment
    ##    <chr>       <chr>    
    ##  1 2-faces     negative 
    ##  2 abnormal    negative 
    ##  3 abolish     negative 
    ##  4 abominable  negative 
    ##  5 abominably  negative 
    ##  6 abominate   negative 
    ##  7 abomination negative 
    ##  8 abort       negative 
    ##  9 aborted     negative 
    ## 10 aborts      negative 
    ## # ℹ 6,776 more rows

``` r
get_sentiments("nrc")
```

    ## # A tibble: 13,872 × 2
    ##    word        sentiment
    ##    <chr>       <chr>    
    ##  1 abacus      trust    
    ##  2 abandon     fear     
    ##  3 abandon     negative 
    ##  4 abandon     sadness  
    ##  5 abandoned   anger    
    ##  6 abandoned   fear     
    ##  7 abandoned   negative 
    ##  8 abandoned   sadness  
    ##  9 abandonment anger    
    ## 10 abandonment fear     
    ## # ℹ 13,862 more rows

Let’s now see how is it in our dataset

``` r
# Apply Bing sentiment lexicon
## Step 1:
bing_sentiments_S1 <- amazon_tokens |>
  inner_join(get_sentiments("bing"), by = "word")
head(bing_sentiments_S1)
```

    ## # A tibble: 6 × 21
    ##   product_id product_name                 category discounted_price actual_price
    ##   <chr>      <chr>                        <chr>    <chr>            <chr>       
    ## 1 B07JW9H4J1 Wayona Nylon Braided USB to… Compute… ₹399             ₹1,099      
    ## 2 B07JW9H4J1 Wayona Nylon Braided USB to… Compute… ₹399             ₹1,099      
    ## 3 B07JW9H4J1 Wayona Nylon Braided USB to… Compute… ₹399             ₹1,099      
    ## 4 B07JW9H4J1 Wayona Nylon Braided USB to… Compute… ₹399             ₹1,099      
    ## 5 B07JW9H4J1 Wayona Nylon Braided USB to… Compute… ₹399             ₹1,099      
    ## 6 B07JW9H4J1 Wayona Nylon Braided USB to… Compute… ₹399             ₹1,099      
    ## # ℹ 16 more variables: discount_percentage <chr>, rating <dbl>,
    ## #   rating_count <dbl>, about_product <chr>, user_id <chr>, user_name <chr>,
    ## #   review_id <chr>, review_title <chr>, review_content <chr>, img_link <chr>,
    ## #   product_link <chr>, textBU <chr>, review_index <int>, nwords <int>,
    ## #   word <chr>, sentiment <chr>

``` r
bing_sentiments_S2 <- bing_sentiments_S1 |> 
  count(review_index, sentiment)
head(bing_sentiments_S2)
```

    ## # A tibble: 6 × 3
    ##   review_index sentiment     n
    ##          <int> <chr>     <int>
    ## 1            1 negative      2
    ## 2            1 positive      6
    ## 3            2 negative      5
    ## 4            2 positive      8
    ## 5            3 positive      4
    ## 6            4 positive      4

``` r
bing_sentiments_S3 <- bing_sentiments_S2 |> 
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0)

head(bing_sentiments_S3)
```

    ## # A tibble: 6 × 3
    ##   review_index negative positive
    ##          <int>    <int>    <int>
    ## 1            1        2        6
    ## 2            2        5        8
    ## 3            3        0        4
    ## 4            4        0        4
    ## 5            5        9       11
    ## 6            6        0        3

``` r
bing_sentiments_S4 <- bing_sentiments_S3 |> 
  mutate(sentiment = positive - negative)
head(bing_sentiments_S4)
```

    ## # A tibble: 6 × 4
    ##   review_index negative positive sentiment
    ##          <int>    <int>    <int>     <int>
    ## 1            1        2        6         4
    ## 2            2        5        8         3
    ## 3            3        0        4         4
    ## 4            4        0        4         4
    ## 5            5        9       11         2
    ## 6            6        0        3         3

Full Pipe:

``` r
bing_sentiments <- amazon_tokens |>
  inner_join(get_sentiments("bing"), by = "word") |> 
  count(review_index, sentiment) |> 
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) |> 
  mutate(sentiment = positive - negative) |> 
  mutate(method = "Bing")
```

Now let’s repeat it with AFINN, from now on I am going to give you the
full pipeline, if you want you can see step by step

``` r
afinn_sentiments <- amazon_tokens |>
  inner_join(get_sentiments("afinn")) |> 
  group_by(review_index) |>  
  summarise(sentiment = sum(value)) |> 
  mutate(method = "AFINN")
```

Now w/ NRC:

``` r
nrc_sentiments <-  amazon_tokens |> 
    inner_join(get_sentiments("nrc") |> 
                 filter(sentiment %in% c("positive", 
                                         "negative"))) |> 
  count(review_index, sentiment) |> 
  pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) |> 
  mutate(sentiment = positive - negative) |> 
  mutate(method = "NRC")
```

------------------------------------------------------------------------

### 2.4 Visualizing and Comparing Sentiment Analysis Results

``` r
all_sentiments <- bind_rows(afinn_sentiments,
          bing_sentiments,
          nrc_sentiments) |> 
  dplyr::select(-positive, -negative)


ggplot(all_sentiments,
       aes(review_index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")
```

![](bigdata_L7-github_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

**Interpreting the Sentiment Analysis Results**

The visualization above shows sentiment scores across approximately
1,500 Amazon product reviews using three different lexicons:

**AFINN (Top Panel - Red):**

- Shows sentiment scores ranging from approximately -20 to +70

- Most reviews cluster around neutral to slightly positive (0-20 range)

- Several spikes indicate strongly positive reviews (scores above 50)

- The high positive scores suggest customers who leave reviews tend to
  express strong satisfaction

- Negative sentiment appears less frequent and less extreme

**Bing (Middle Panel - Green):**

- Displays scores from approximately -30 to +30

- More balanced distribution between positive and negative sentiment

- The zero line represents neutral sentiment (equal positive and
  negative words)

- Green bars above zero indicate positive sentiment; bars below indicate
  negative

- Shows more variability and captures both satisfied and dissatisfied
  customers

**NRC (Bottom Panel - Blue):**

- Generally lower scores, mostly ranging from 0 to 40

- Few negative values, indicating this lexicon captures more positive
  than negative emotions

- Several notable spikes (around review index 1000) suggest reviews with
  strong emotional content

- The lower overall scores reflect that NRC filters for specific
  emotions (anger, joy, fear, trust) rather than general sentiment

**Key Observations:**

- All three methods show predominantly positive sentiment, which is
  typical for product reviews (satisfied customers are more likely to
  leave reviews)

- AFINN produces the highest magnitude scores, making it useful for
  detecting strong sentiment

- Bing provides the most balanced view of positive vs. negative
  sentiment

- Different lexicons can produce different results for the same text,
  highlighting the importance of comparing multiple methods

------------------------------------------------------------------------

### 2.5 Most common positive and negative words

``` r
bing_word_counts <- amazon_tokens |> 
  inner_join(get_sentiments("bing")) |> 
  count(word, sentiment, sort = TRUE) |> 
  ungroup()

head(bing_word_counts)
```

    ## # A tibble: 6 × 3
    ##   word  sentiment     n
    ##   <chr> <chr>     <int>
    ## 1 nice  positive    947
    ## 2 easy  positive    917
    ## 3 fast  positive    580
    ## 4 fine  positive    522
    ## 5 worth positive    431
    ## 6 issue negative    335

Visualize it:

``` r
bing_word_counts |> 
  group_by(sentiment) |> 
  slice_max(n, n = 10) |> 
  ungroup() |> 
  mutate(word = reorder(word, n)) |> 
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(x = "Sentiment Count",
       y = NULL)
```

![](bigdata_L7-github_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

We can also do wordclouds using `wordcloud2`

``` r
# Get word frequencies for disgust and trust emotions
sentiment_words <- amazon_tokens |> 
  inner_join(get_sentiments("nrc")) |> 
  filter(sentiment %in% c("disgust", "trust")) |> 
  count(word, sentiment, sort = TRUE)

# # Check the data structure
# head(sentiment_words, 20)

# Create separate wordclouds for each sentiment
disgust_words <- sentiment_words |> 
  filter(sentiment == "disgust") |> 
  select(word, n) |>
  rename(freq = n)  # wordcloud2 likes 'freq' as column name

trust_words <- sentiment_words |> 
  filter(sentiment == "trust") |> 
  select(word, n) |>
  rename(freq = n)

# # Check the structure before creating wordcloud
# str(disgust_words)
# head(disgust_words)

wordcloud2(disgust_words, 
           size = 0.5,
           color = "random-dark", 
           backgroundColor = "white",
           minSize = 5)
```

<div class="wordcloud2 html-widget html-fill-item" id="htmlwidget-5d4da96f8dd4e5eea18e" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-5d4da96f8dd4e5eea18e">{"x":{"word":["bad","weight","disappointed","damage","defective","waste","powerful","finally","boil","feeling","lagging","larger","lesser","overpriced","default","dislike","smell","honest","irritating","pollution","remains","cutting","gray","hanging","weird","delay","disappoint","fat","lose","dirt","dirty","hate","misleading","ugly","wasted","bug","awful","blame","burnt","mess","pathetic","fungus","horrible","inconvenient","painful","sentence","sticky","trash","damn","fool","owing","treat","annoyance","bang","bloody","bummer","crap","debris","drunken","hell","humble","irritation","lying","saturated","speck","unbearable","unpleasant","abnormal","abuse","criticize","dire","disappointment","disaster","fleece","garbage","ill","messy","mosquito","unfair","backwards","bleeding","bloated","censor","clumsy","collapse","depressing","deteriorated","entangled","filthy","goo","idiot","infamous","intense","interior","intrusive","lie","muddy","poaching","questionable","scrub","shame","soiled","spider","stain","stomach","unsatisfied","wasting","worthless","adverse","angry","atrocious","cancer","cheat","cholera","corruption","cough","crude","crushed","cur","cursing","death","degrade","deplorable","desert","destructive","discoloration","discolored","disgusting","dismal","distorted","dying","enemy","excellence","failure","greasy","gross","harmful","hood","horrific","horror","idiotic","illegal","impure","inappropriate","incase","incompatible","insanity","instability","lawyer","lemon","lick","lord","mishap","murky","nasty","nose","offense","pollute","rat","rejection","repellent","ridiculous","rogue","rubbish","sick","snake","spoil","suffering","suffocating","suppression","surly","terrible","thief","threatening","toad","toxic","tree","uneasy","unhappy","unsatisfactory","unsettled","whine","winning"],"freq":[252,219,70,63,62,60,55,54,29,29,29,27,25,25,24,23,18,17,16,16,16,14,14,14,14,13,12,12,12,11,11,11,11,10,10,9,8,8,8,8,8,7,6,6,6,6,6,6,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"fontFamily":"Segoe UI","fontWeight":"bold","color":"random-dark","minSize":5,"weightFactor":0.3571428571428572,"backgroundColor":"white","gridSize":0,"minRotation":-0.7853981633974483,"maxRotation":0.7853981633974483,"shuffle":true,"rotateRatio":0.4,"shape":"circle","ellipticity":0.65,"figBase64":null,"hover":null},"evals":[],"jsHooks":{"render":[{"code":"function(el,x){\n                        console.log(123);\n                        if(!iii){\n                          window.location.reload();\n                          iii = False;\n\n                        }\n  }","data":null}]}}</script>

``` r
wordcloud2(trust_words, 
           size = 0.5,
           color = "random-light", 
           backgroundColor = "white",
           minSize = 5)
```

<div class="wordcloud2 html-widget html-fill-item" id="htmlwidget-b5aa6ad75a0541d846f5" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-b5aa6ad75a0541d846f5">{"x":{"word":["money","recommend","budget","excellent","happy","weight","warranty","found","clean","perfect","durable","pretty","top","cover","level","expect","machine","accurate","star","bank","durability","calls","iron","deal","provide","hope","system","friendly","manual","compact","wear","content","team","stable","helpful","improve","center","base","powerful","effective","finally","trust","fixed","pay","improvement","green","reliable","suggest","save","crisp","prefer","efficient","real","genuine","personal","comfort","doubt","guard","protector","true","planning","fairly","feeling","safe","exchange","larger","share","wonderful","fitting","food","proof","providing","seal","count","responsive","enjoy","fill","operation","professional","automatic","strength","worthy","cap","guide","lover","rod","related","word","honest","intact","series","instructions","measure","remains","depend","usual","advice","friend","mother","offering","official","prestige","depth","flagship","prepared","supporting","brother","experienced","ground","intend","lovely","policy","reliability","respect","school","serve","constantly","honor","income","signature","brilliant","constant","continue","enjoying","shopping","sweet","title","assured","crucial","enable","favorite","loving","peace","pilot","evident","expert","glow","god","instruction","manage","promise","relevant","steady","sun","understanding","account","confirmation","elders","laser","management","patience","successful","calculator","cautious","confidence","guarantee","insulation","label","magnet","maintenance","majority","measured","pleasant","praise","relative","smith","visionary","achieve","cabinet","cash","confirmed","credit","explain","father","justice","owing","purification","routine","sceptical","straightforward","treat","weigh","advise","advised","appreciation","authentic","commerce","communication","companion","convincing","dance","entertainment","faith","fidelity","forecast","friendliness","protected","purify","structure","toughness","uplift","verified","architecture","assembly","assurance","authenticity","clearance","courier","elite","encourage","excel","excited","familiar","fellow","freedom","freely","hero","leading","liking","messenger","mislead","obvious","president","proven","reliance","retain","seals","secret","statement","upright","advisable","agreed","alive","authentication","authority","blessing","buddy","censor","coax","committed","compass","compensate","consistency","convinced","dependent","deserve","digit","elevation","engaging","evergreen","favorable","fortitude","fuse","generous","goodness","grin","harmony","heritage","inclusion","indestructible","inform","inspired","intense","interior","lesson","mathematical","medical","moral","neutral","nursery","opera","protecting","proud","rule","salary","theory","truth","assist","attest","bloom","champion","chocolate","civilization","communicate","compliance","compliment","confident","consult","cooperative","cradle","credibility","credible","deceiving","defended","deliverance","diagnosis","diary","dignity","economy","emphasize","endless","endow","enlighten","excellence","exhaustive","expertise","fabrication","footing","fortune","fundamental","gentleman","glory","grow","guidebook","heavenly","illumination","immerse","impeccable","incline","infinity","inspire","instruct","intelligence","intelligent","justifiable","law","lord","magnificent","majestic","merchant","merit","mighty","miracle","nest","objective","organization","passion","picnic","pill","purely","radar","ranger","reimbursement","remedy","rescue","respects","responsible","safekeeping","shoulder","sing","sir","strengthening","substantiate","temperate","thoughtful","trade","transaction","tree","unreliable","unwavering","virtue","winning"],"freq":[689,263,259,237,220,219,210,203,198,191,183,179,177,155,148,132,126,119,104,103,102,99,94,93,92,90,89,84,80,79,71,64,64,63,62,60,58,56,55,54,54,53,51,51,50,49,46,45,39,38,38,37,36,35,35,34,32,32,32,32,30,29,29,29,27,27,27,27,26,26,26,26,25,24,24,23,23,23,23,22,22,22,21,20,19,19,18,18,17,17,17,16,16,16,15,15,14,14,14,14,14,14,13,13,13,13,12,12,12,12,12,12,12,12,12,12,11,11,11,11,10,10,10,10,10,10,10,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],"fontFamily":"Segoe UI","fontWeight":"bold","color":"random-light","minSize":5,"weightFactor":0.1306240928882438,"backgroundColor":"white","gridSize":0,"minRotation":-0.7853981633974483,"maxRotation":0.7853981633974483,"shuffle":true,"rotateRatio":0.4,"shape":"circle","ellipticity":0.65,"figBase64":null,"hover":null},"evals":[],"jsHooks":{"render":[{"code":"function(el,x){\n                        console.log(123);\n                        if(!iii){\n                          window.location.reload();\n                          iii = False;\n\n                        }\n  }","data":null}]}}</script>

------------------------------------------------------------------------

### 2.6 Normalize sentiment scores

- What are some ways I can normalize sentiment scores?
  - Divide by number of words in the review!
  - This accounts for review length - longer reviews naturally have more
    sentiment words

``` r
afinn_sentiments2 <- afinn_sentiments |> 
  left_join(amazon_data, by = "review_index") |> 
  group_by(review_index) |>
  mutate(normalized_score = sentiment / nwords)

head(afinn_sentiments2)
```

    ## # A tibble: 6 × 23
    ## # Groups:   review_index [6]
    ##   review_index sentiment method product_id product_name                 category
    ##          <int>     <dbl> <chr>  <chr>      <chr>                        <chr>   
    ## 1            1         4 AFINN  B07JW9H4J1 Wayona Nylon Braided USB to… Compute…
    ## 2            2         7 AFINN  B098NS6PVG Ambrane Unbreakable 60W / 3… Compute…
    ## 3            3         6 AFINN  B096MSW6CT Sounce Fast Phone Charging … Compute…
    ## 4            4         4 AFINN  B08HDJ86NZ boAt Deuce USB 300 2 in 1 T… Compute…
    ## 5            5        -1 AFINN  B08CF3B7N1 Portronics Konnect L 1.2M F… Compute…
    ## 6            6         4 AFINN  B08Y1TFSP6 pTron Solero TB301 3A Type-… Compute…
    ## # ℹ 17 more variables: discounted_price <chr>, actual_price <chr>,
    ## #   discount_percentage <chr>, rating <dbl>, rating_count <dbl>,
    ## #   about_product <chr>, user_id <chr>, user_name <chr>, review_id <chr>,
    ## #   review_title <chr>, review_content <chr>, img_link <chr>,
    ## #   product_link <chr>, textBU <chr>, text <chr>, nwords <int>,
    ## #   normalized_score <dbl>

``` r
ggplot(afinn_sentiments2, aes(x = normalized_score)) +
  geom_histogram(bins = 30, fill = "steelblue", color = "black") +
  labs(
    title = "Histogram of AFINN Normalized Sentiment Scores",
    x = "AFINN Normalized Scores (Sentiment per Word)",
    y = "Count"
  ) +
  theme_minimal()
```

![](bigdata_L7-github_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

To compare the non-normalized scores:

``` r
ggplot(afinn_sentiments2, aes(x = sentiment)) +
  geom_histogram() +
  labs(
    title = "Histogram of AFINN  Sentiment Scores",
    x = "AFINN  Scores",
    y = "Count"
  ) +
  theme_minimal()
```

![](bigdata_L7-github_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

**Why normalize?**

- Longer reviews will naturally have higher absolute sentiment scores

- Normalization helps us compare sentiment intensity across reviews of
  different lengths

- A short review with score 10 might be more positive than a long review
  with score 10

------------------------------------------------------------------------

## 3. Word Embeddings

Traditional approaches treat words as discrete symbols with no inherent
relationship - “good” and “great” are just different words. Word
embeddings change this by representing words as **vectors of numbers**
where similar words have similar vector representations.

**Key Concept:** Words that appear in similar contexts tend to have
similar meanings.

For example, in product reviews:

- “This cable is **durable**”

- “This cable is **sturdy**”

- “This cable is **reliable**”

The words “durable,” “sturdy,” and “reliable” appear in similar
contexts, so their word embeddings will be close to each other in vector
space.

**Vector Arithmetic Magic:** Once words are vectors, we can perform
mathematical operations:

- `vector("good") - vector("bad")` captures the concept of quality

- `vector("phone") - vector("cable") + vector("charger")` might land
  near words related to charging accessories

**Why use word embeddings for product reviews?**

- Capture subtle differences in how customers describe products

- Identify similar product features across different reviews

- Understand relationships between descriptive words (e.g., “fast
  charging” vs “quick charging”)

- Go beyond simple positive/negative to understand what customers
  actually care about

------------------------------------------------------------------------

### 3.1 Introduction to Word Embeddings

There are several popular word embedding methods:

- **Word2Vec**: Uses a neural network model to generate word embeddings
  based on context. We’ll use this method today.
- **GloVe** (Global Vectors): Constructs word vectors based on word
  co-occurrence statistics across the entire corpus.
- **FastText**: Extends Word2Vec by representing words as subword
  n-grams, improving performance for rare words and handling typos
  better.

**For this lecture, we’ll focus on Word2Vec with two training
algorithms:**

1.  **CBOW (Continuous Bag of Words)**
    - Predicts a word based on its surrounding context words
2.  **Skip-Gram**
    - Predicts surrounding context words based on a target word

------------------------------------------------------------------------

#### 3.1.1 Continuous Bag of Words (CBOW)

The **CBOW model** predicts a target word based on the surrounding
context words. It works as follows:

1.  **Input Context**: The model takes a window of words surrounding a
    target word.
2.  **Word Representation**: Each word is mapped to a vector embedding
    that captures its semantic and syntactic properties.
3.  **Aggregation**: The individual word vectors in the context window
    are combined into a single vector.
4.  **Prediction**: The model uses this aggregated vector to predict the
    most probable target word.
5.  **Optimization**: The model is trained to minimize the difference
    between predicted and actual words, refining the vector
    representations over time.

**Example from a product review:**

Given the review: *“This cable has **excellent** charging speed”*

With a window size of 2, to predict the word **“excellent”**, the model
uses:

- Context words: \[“cable”, “has”, “charging”, “speed”\]

- The model learns that words appearing near “excellent” in reviews are
  often product features

- Over many reviews, “excellent” becomes closely associated with
  positive quality descriptors

**Why CBOW is useful for reviews:**

- Fast to train, efficient for large datasets (like thousands of product
  reviews)

- Good at learning common patterns in customer language

- Works well when you have many examples of similar contexts (e.g.,
  “great quality”, “excellent quality”, “amazing quality”)

![](https://media.geeksforgeeks.org/wp-content/uploads/20231220164157/Screenshot-2023-12-20-164143.png)
*image from:
<https://media.geeksforgeeks.org/wp-content/uploads/20231220164157/Screenshot-2023-12-20-164143.png>*

- **Input layer**: Context words \[w(t-2), w(t-1), w(t+1), w(t+2)\] -
  the words surrounding our target
- **Hidden layer (Sum)**: These context word vectors are averaged/summed
  together
- **Output layer**: Predicts the target word w(t)

CBOW is efficient for handling large datasets and is useful for tasks
requiring general word representations.

------------------------------------------------------------------------

#### 3.1.2 Skip-Gram Model

Unlike CBOW, the **Skip-Gram model** works in reverse: it predicts
**context words** given a target word. It works as follows:

1.  **Input Target Word**: The model takes a single word as input.
2.  **Word Representation**: The target word is mapped to a
    high-dimensional vector embedding.
3.  **Probability Distribution**: The model generates probabilities for
    words likely to appear in the surrounding context.
4.  **Context Word Prediction**: Words with the highest probability are
    selected as context words.
5.  **Training Optimization**: The model fine-tunes word embeddings by
    maximizing the probability of correctly predicting surrounding
    words.

![](https://media.geeksforgeeks.org/wp-content/uploads/20231220164505/Screenshot-2023-12-20-164451.png)

*image from:
<https://media.geeksforgeeks.org/wp-content/uploads/20231220164505/Screenshot-2023-12-20-164451.png>*

- **Input layer**: Single target word w(t)
- **Projection layer**: The word is converted to its vector
  representation
- **Output layer**: Predicts multiple context words \[w(t-2), w(t-1),
  w(t+1), w(t+2)\]

**Example from a product review:**

Given the target word **“durable”** in the review: *“This cable is very
**durable** and sturdy”*

With a window size of 2, the model tries to predict context words:

- Expected context: \[“cable”, “very”, “and”, “sturdy”\]

- The model learns what words typically appear near “durable” in product
  reviews

- Over time, it understands that “durable” is associated with product
  quality descriptors

Skip-Gram performs better on small datasets and captures relationships
between rare words more effectively, making it ideal for identifying
specific product features that might not appear frequently.

**CBOW vs Skip-Gram - Which to use?**

| Feature | CBOW | Skip-Gram |
|----|----|----|
| **Speed** | Faster to train | Slower to train |
| **Best for** | Frequent words, large datasets | Rare words, smaller datasets |
| **Accuracy** | Good for common patterns | Better for capturing nuanced relationships |
| **Our Amazon data** | Good choice (1,465 reviews) | Also viable, better for specific product terms |

------------------------------------------------------------------------

### 3.2 Applying Word Embeddings in R

We will train a **Word2Vec model** on the Amazon product reviews using
both **Continuous Bag of Words (CBOW)** and **Skip-Gram** algorithms to
analyze relationships between words customers use to describe products.

For more on word embeddings:
<https://s-ai-f.github.io/Natural-Language-Processing/Word-embeddings.html>

#### 3.2.1 Training Word2Vec with CBOW

**Step 1: Select the text column**

``` r
reviews <- amazon_data$text
```

**Step 2: Train a Word2Vec model using the CBOW algorithm**

**What do the parameters mean?**

- `dim = 15`: Each word will be represented as a vector with 15
  dimensions

- `iter = 20`: The model will iterate through the data 20 times to learn
  patterns

- `type = "cbow"`: Using Continuous Bag of Words algorithm

``` r
cbow_model <- word2vec(x = reviews, type = "cbow", dim = 15, iter = 20)
```

**Step 3: Create embeddings using the trained CBOW model and print**

``` r
# checking embeddings
cbow_embedding <- as.matrix(cbow_model)
cbow_embedding <- predict(cbow_model, c("quality", "durable"), type = "embedding")
print("The CBOW embedding for 'quality' and 'durable' is as follows:")
```

    ## [1] "The CBOW embedding for 'quality' and 'durable' is as follows:"

``` r
print(cbow_embedding)
```

    ##               [,1]      [,2]       [,3]     [,4]       [,5]        [,6]
    ## quality  1.2025050 0.6638257 -0.1812494 1.059464 0.02755646 -2.46302342
    ## durable -0.8650298 1.1314095 -2.3551283 1.536014 0.04510239 -0.08961504
    ##               [,7]        [,8]      [,9]      [,10]     [,11]      [,12]
    ## quality  0.5330371  0.03221637 -1.114101 -0.5676234 0.2730089 -0.4610037
    ## durable -0.2005682 -0.39719358 -1.536827  0.1245560 0.5725173 -0.4151438
    ##              [,13]     [,14]      [,15]
    ## quality -0.3463746 -1.841939  0.4923424
    ## durable  0.1623335 -1.281561 -0.5580249

**Step 4: Find similar words (look-alikes)**

``` r
cbow_lookslike <- predict(cbow_model, c("quality", "durable"), 
                          type = "nearest", top_n = 5)
print("The nearest words for 'quality' and 'durable' in CBOW model prediction:")
```

    ## [1] "The nearest words for 'quality' and 'durable' in CBOW model prediction:"

``` r
print(cbow_lookslike)
```

    ## $quality
    ##     term1             term2 similarity rank
    ## 1 quality       performance  0.9098881    1
    ## 2 quality      beautycamera  0.8908731    2
    ## 3 quality decentperformance  0.8823302    3
    ## 4 quality       lookinggood  0.8814546    4
    ## 5 quality        impressive  0.8701320    5
    ## 
    ## $durable
    ##     term1    term2 similarity rank
    ## 1 durable   sturdy  0.9551952    1
    ## 2 durable reliable  0.9236155    2
    ## 3 durable     hell  0.8916085    3
    ## 4 durable  braided  0.8714685    4
    ## 5 durable    thick  0.8687557    5

**Interpreting the results:**

The output shows the most similar words based on the CBOW model:

For **“quality”**:

- Top similar words: “build”, “ok”, “appealing”, “built”

- Similarity scores range from ~0.87 to 0.89 (closer to 1 = more
  similar)

- These words often appear in similar contexts when customers discuss
  product quality

For **“durable”**:

- Top similar words: “sturdy”, “reliable”, “thick”, “wire”

- Similarity scores are very high (~0.88 to 0.95)

- Notice how “sturdy” and “reliable” are nearly synonymous with
  “durable”

- “thick” and “wire” appear because customers often discuss cable
  thickness when describing durability

**Why this matters:**

- The model learned these relationships just from how words appear
  together in reviews

- No manual labeling or dictionary was needed

- You could use these word groups to:

  - Identify product features customers care about

  - Find alternative ways customers express the same sentiment

  - Group similar customer feedback together

#### 3.2.2 Visualize CBOW

**Step 1: Prepare word list using tidy approach**

We’ll extract the top 100 most frequent words from our reviews
(excluding stopwords) to visualize.

``` r
# Get top 100 words using tidytext
word_freq <- amazon_data |>
  unnest_tokens(word, text) |>
  anti_join(stop_words, by = "word") |>
  count(word, sort = TRUE) |>
  top_n(100, n) |>
  pull(word)

cat("Number of words to visualize:", length(word_freq), "\n")
```

    ## Number of words to visualize: 100

``` r
head(word_freq, 20)
```

    ##  [1] "product"  "quality"  "cable"    "price"    "phone"    "charging"
    ##  [7] "nice"     "easy"     "battery"  "time"     "buy"      "sound"   
    ## [13] "watch"    "tv"       "money"    "fast"     "fine"     "amazon"  
    ## [19] "water"    "camera"

**Step 2: Match the embeddings**

``` r
# checking embeddings
# Get embeddings for our top 100 words
cbow_embedding <- as.matrix(cbow_model)
cbow_embedding <- predict(cbow_model, word_freq, type = "embedding")
cbow_embedding <- na.omit(cbow_embedding)  # Remove any words not found in the model

# Check how many words we successfully embedded
cat("Successfully embedded", nrow(cbow_embedding), "words\n")
```

    ## Successfully embedded 100 words

**Step 3: Reduce dimensions with UMAP for visualization** Since our
embeddings have 15 dimensions, we need to reduce them to 2D for
plotting. UMAP (Uniform Manifold Approximation and Projection) preserves
the local structure of the high-dimensional data.

``` r
# Reduce to 2D using UMAP
visualization <- umap(cbow_embedding, n_neighbors = 15, n_threads = 2)

# Create data frame for plotting
df <- data.frame(
  word = rownames(cbow_embedding), 
  x = visualization$layout[, 1], 
  y = visualization$layout[, 2], 
  stringsAsFactors = FALSE
)

# Preview the data
head(df)
```

    ##              word           x           y
    ## product   product -0.28426891  1.33326785
    ## quality   quality  0.76065832  1.87926290
    ## cable       cable -0.09329616 -0.08191678
    ## price       price -0.80635330  1.46285291
    ## phone       phone  0.73710298 -1.62912150
    ## charging charging -1.00224282 -0.16201743

**Step 4: Create interactive visualization**

``` r
# Create interactive plot
plot_ly(df, x = ~x, y = ~y, type = "scatter", mode = 'text', text = ~word) %>%
  layout(
    title = "CBOW Word Embeddings: Amazon Product Reviews",
    xaxis = list(title = "UMAP Dimension 1"),
    yaxis = list(title = "UMAP Dimension 2"),
    hovermode = "closest"
  )
```

<div class="plotly html-widget html-fill-item" id="htmlwidget-f66c0ff0731e265a3a4a" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-f66c0ff0731e265a3a4a">{"x":{"visdat":{"750261577ba":["function () ","plotlyVisDat"]},"cur_data":"750261577ba","attrs":{"750261577ba":{"x":{},"y":{},"mode":"text","text":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"scatter"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"CBOW Word Embeddings: Amazon Product Reviews","xaxis":{"domain":[0,1],"automargin":true,"title":"UMAP Dimension 1"},"yaxis":{"domain":[0,1],"automargin":true,"title":"UMAP Dimension 2"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":[-0.28426891227699835,0.76065832112053089,-0.09329615882186193,-0.80635330304902819,0.7371029797088644,-1.0022428231314509,0.23049022487694648,0.30944973379093099,-1.815859218688729,-1.6297800505954225,-1.4903549126515716,1.9575131910481307,1.9061718310523084,1.3981706510697869,-1.5333161308245515,-2.1423653913845522,0.74500426750181781,-0.60990020809996315,-1.5151385372581503,1.5370954036565179,-2.1356102465222198,1.2021578889863989,-0.35874128119654847,1.4424317374011055,-1.8253103886430673,-1.8835332915110883,-0.6822430227835663,-1.3282119087105904,-0.071258445419752903,-1.5000645213997101,-1.1379510317402453,0.86973509698521756,-1.3237537131763877,1.9073543334506056,-0.54967998735621304,0.1494382593129866,0.39092150992528962,-1.4193901002698444,-1.9010422533685241,-0.75668460988564146,0.61182837479255348,-0.46540029038606034,-0.65219739500433249,-1.6915086643720121,0.97914004821609435,-0.88787252367540015,0.65653006421288884,0.22977771589476781,0.24408698294515085,0.70783626720534576,1.5637694652988667,1.0349646482380042,-0.82568903121739901,-1.5556808168978911,1.5295389487127968,0.039743652082707914,0.34647136210945551,-1.3559918989059743,1.1461727230076075,1.6516650012332477,0.49114068571410918,-0.99891793638199022,1.3186733545988005,0.49672051915648696,1.9318691225570603,-0.54769643485309061,0.53143906208001379,2.1699942509164982,-0.402107340566634,0.61401683544345387,-0.92501179227550079,-1.291774861014817,1.7146790523863009,0.34461773455874312,1.4418894494672596,-0.66182495578897926,0.96293682421330473,-1.7143698254161073,0.39833275402679558,-0.033412259473317274,0.90340911829671278,-0.66262869593505203,0.20177256821266099,0.10213159452006693,-0.27521031537701912,-1.3968690089515698,0.38393134578678145,-1.0467709661524065,1.6990985926280233,1.6576174914141379,0.91085255625993433,-0.7965469508384202,1.0981729522178165,0.31581585349092034,2.1962344236606697,2.1212257901188787,0.21374484142728178,-0.95401298232851994,0.3632565212081218,-1.9309485836195723],"y":[1.3332678465701169,1.8792628953328068,-0.081916780430024261,1.4628529141397948,-1.6291214950237154,-0.16201742779852157,2.4169471081290688,0.92042523060157899,-0.59772519996312545,-0.78207710101410499,1.3392602560477784,0.35920798790929265,-0.70309282103368131,-1.5235651399715002,1.0735619275155637,-0.17578421299389513,2.4728322150213149,-2.6138532256523375,-0.4052422500911026,-0.051188146637152432,-0.29850859594342971,-0.52723888692366905,1.2448360267973588,0.69545468111503661,1.1236870207221585,-0.28415967810344944,1.8750247869502772,-1.4200692323832755,-0.84373858412150948,-1.2982799195386874,-0.28391666325439502,-1.5505663659208055,-1.6701138404189593,-0.7725137811577969,-1.5872007428428698,1.2480697177315663,-1.5343333192657906,-1.0663576609228773,-1.2179930574732785,-0.26795977302933949,-1.25817148641781,-1.4534383875772505,0.073373219542281376,0.21046430271947303,-1.1071420979828817,-2.6759407442012471,1.2469516471851061,2.3133598283740158,-1.4293162424377024,-0.81822628096166317,-0.84696803226393369,1.3418238623629923,-2.7416191888915025,1.3876945976433883,-0.25312283022975302,1.8160276826053297,2.3650534851923295,0.95641969843769914,1.4984541416926889,0.97527914737218158,-1.6806271272316946,1.6114786472734837,0.47446882745790786,0.81730575264352678,0.21595058333364037,-2.6964739601501435,2.169727878462421,0.57884358872088093,-0.59507301904973464,0.0011680205368831409,1.0062262820662871,-1.9372778261072159,-1.3728038688110549,2.6887890081222219,-1.6564614903804347,-0.20354258081601895,-0.26399253216092511,-1.529384595265145,2.7348654019570731,1.2768048121941673,2.4884259522164642,2.2053645328460556,1.3055957531493583,-0.79612787353923187,0.77918159346608551,-0.27239818756829215,1.0315308005937474,-2.8573843294781032,-1.1362070620839559,-1.26120549497173,0.33303724162042059,-1.8046406435303797,0.86621018291609841,2.6785933201216086,-0.49958802861206042,-0.22907697218824397,0.27291103323017607,-2.1720921345367414,-1.3044456183939894,1.0352110971084612],"mode":"text","text":["product","quality","cable","price","phone","charging","nice","easy","battery","time","buy","sound","watch","tv","money","fast","fine","amazon","water","camera","power","screen","worth","bit","bought","speed","range","months","usb","days","charge","device","review","features","issue","light","mobile","day","usage","charger","laptop","issues","original","life","remote","installation","sturdy","low","mouse","box","experience","build","service","purchase","display","performance","decent","recommend","design","picture","bluetooth","budget","feel","size","noise","support","bad","bass","samsung","easily","rs","update","call","excellent","app","gb","button","month","average","it’s","expected","happy","weight","type","length","heating","normal","warranty","feature","video","job","found","plastic","amazing","boat","option","clean","received","connect","buying"],"type":"scatter","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

**What to look for in the visualization:**

- **Clusters of similar words**: Words close together have similar
  meanings or appear in similar contexts

- Look for these typical clusters:

  - **Quality descriptors**: “good”, “excellent”, “quality”, “durable”,
    “sturdy”

  - **Price-related**: “price”, “worth”, “value”, “money”, “cheap”

  - **Product features**: “cable”, “charging”, “fast”, “long”, “wire”

  - **Negative feedback**: “waste”, “poor”, “bad”, “worst”,
    “disappointed”

  - **Positive emotions**: “love”, “perfect”, “happy”, “satisfied”

**Tips for interpretation:**

- The exact positions are not meaningful, but relative distances are

- Words that appear in similar review contexts will cluster together

- You can hover over words to see their exact labels (in the interactive
  plot)

- If two product-related words are close, customers likely use them
  interchangeably

------------------------------------------------------------------------

#### 3.2.3 Training Word2Vec with Skip Gram

Now let’s train a Skip-Gram model and compare it with CBOW.

Remember: Skip-Gram predicts context words from a target word, making it
better at capturing relationships for rare words.

**Step 1: Select the text column:**

``` r
reviews <- amazon_data$text
```

**Step 2: Train the Skip-Gram model**

``` r
# Using skip-gram algorithm
skip_gram_model <- word2vec(x = reviews, type = "skip-gram", dim = 15, iter = 20)
```

**What’s different from CBOW?**

- `type = "skip-gram"`: Uses Skip-Gram algorithm instead of CBOW

- Same dimensions (15) and iterations (20) for fair comparison

- Generally slower to train but better for rare/specific product terms

**Step 3: Create embeddings and examine specific words**

``` r
# Checking embeddings
skip_embedding <- as.matrix(skip_gram_model)
skip_embedding <- predict(skip_gram_model, c("quality", "durable"), type = "embedding")
print("The Skip-Gram embedding for 'quality' and 'durable' is as follows:")
```

    ## [1] "The Skip-Gram embedding for 'quality' and 'durable' is as follows:"

``` r
print(skip_embedding)
```

    ##              [,1]     [,2]     [,3]       [,4]        [,5]       [,6]
    ## quality 2.3674839 1.237583 1.120280 -0.4259838 0.007147176 -0.6298435
    ## durable 0.8535268 0.726113 1.293574  0.9131581 0.537023365 -1.0645292
    ##               [,7]        [,8]       [,9]     [,10]      [,11]     [,12]
    ## quality -0.1963775  0.87424290 -0.5931958 0.3389825 -0.4168760 0.5876618
    ## durable -0.4880621 -0.02917298  0.3693385 1.3844260 -0.2563458 1.7919627
    ##               [,13]      [,14]    [,15]
    ## quality -0.05699976 -1.2636389 1.625222
    ## durable  0.16518299 -0.6538487 1.947228

**Step 4: Find similar words using Skip-Gram**

``` r
# Finding similar words
skip_lookslike <- predict(skip_gram_model, c("price", "quality"), type = "nearest", 
                          top_n = 5)
print("The nearest words for 'price' and 'quality' in Skip-Gram model:")
```

    ## [1] "The nearest words for 'price' and 'quality' in Skip-Gram model:"

``` r
print(skip_lookslike)
```

    ## $price
    ##   term1      term2 similarity rank
    ## 1 price      range  0.9737731    1
    ## 2 price       best  0.9604432    2
    ## 3 price  visionary  0.9554536    3
    ## 4 price reasonable  0.9530410    4
    ## 5 price affordable  0.9372116    5
    ## 
    ## $quality
    ##     term1       term2 similarity rank
    ## 1 quality       build  0.9651373    1
    ## 2 quality        good  0.9467291    2
    ## 3 quality       great  0.9420540    3
    ## 4 quality        nice  0.9389253    4
    ## 5 quality undoubtedly  0.9370061    5

**Compare with CBOW results:**

- Do you see different similar words than CBOW found?

- Skip-Gram might capture more nuanced relationships

- Especially useful for less common product-specific terms

**Step 5: Create new embeddings for the words_list. And then draw the
visualization.**

``` r
# Get top 100 words using tidytext
word_freq <- amazon_data |>
  unnest_tokens(word, text) |>
  anti_join(stop_words, by = "word") |>
  count(word, sort = TRUE) |>
  top_n(100, n) |>
  pull(word)

# checking embeddings
skip_embedding <- as.matrix(skip_gram_model)
skip_embedding <- predict(skip_gram_model, word_freq, type = "embedding")
skip_embedding <- na.omit(skip_embedding)


vizualization <- umap(skip_embedding, n_neighbors = 15, n_threads = 2)

df  <- data.frame(word = rownames(skip_embedding), 
                  xpos = gsub(".+//", "", rownames(skip_embedding)), 
                  x = vizualization$layout[, 1], y = vizualization$layout[, 2], 
                  stringsAsFactors = FALSE)

plot_ly(df, x = ~x, y = ~y, type = "scatter", mode = 'text', text = ~word) |> 
    layout(
    title = "Skip-Gram Word Embeddings: Amazon Product Reviews",
    xaxis = list(title = "UMAP Dimension 1"),
    yaxis = list(title = "UMAP Dimension 2"),
    hovermode = "closest"
  )
```

<div class="plotly html-widget html-fill-item" id="htmlwidget-3872bd70b61461a5cbae" style="width:672px;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-3872bd70b61461a5cbae">{"x":{"visdat":{"75025dc8c158":["function () ","plotlyVisDat"]},"cur_data":"75025dc8c158","attrs":{"75025dc8c158":{"x":{},"y":{},"mode":"text","text":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"scatter"}},"layout":{"margin":{"b":40,"l":60,"t":25,"r":10},"title":"Skip-Gram Word Embeddings: Amazon Product Reviews","xaxis":{"domain":[0,1],"automargin":true,"title":"UMAP Dimension 1"},"yaxis":{"domain":[0,1],"automargin":true,"title":"UMAP Dimension 2"},"hovermode":"closest","showlegend":false},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false},"data":[{"x":[-1.9215934236733068,-1.8561161351335302,2.8377344208903592,-2.477083427506404,1.690871521210068,2.680208851841122,-1.4536786183164185,0.22679319700116263,0.30090681533156366,0.86142687661041017,-2.8854394168848683,-1.8907831287178065,-0.24526835696999494,1.1664994246002591,-1.7048333881130509,2.7746686096456701,-0.64758777140158619,2.3977486443187361,1.2170409007786567,-1.4443697439041481,2.781739250724069,0.045161593906550335,-2.4097610340079356,-0.60898721174277959,1.9520499955987813,1.5488342115599147,-2.7599168471863318,1.330269359359999,2.395335668337478,1.023047091733158,2.7609592213388132,1.2816001748160326,0.88144864169482884,-0.17621397410845152,1.7555811112910322,-0.10941202043900899,1.7552107704317832,0.99710601938079457,0.65151636888495035,2.5595621933891128,1.3934150617874466,1.6037233294860997,3.0415617606356795,-0.27269035545078102,0.82599785665379222,2.2591278319781152,-0.76798174843165035,-2.1966275423612549,-0.53496456178799467,1.3883904014362627,-2.244239483083271,-1.1201258450161955,2.3332697328819583,-3.311121887037229,-1.8257023273043242,-2.5782272569035589,-2.4930909665070189,-3.0674260726835532,-0.83360876432977637,-1.9722076913088529,0.97831350577477283,-2.851451874226925,-0.91068711873778752,-0.29256786913963406,-1.8941181146478958,2.3133484658211065,-1.7995389013279128,-1.7771044566512453,2.1912545764136349,0.41305378826257683,-2.4809927298418208,1.2428659073170278,0.61080284210803648,-1.6324708951789697,0.60531991853362555,-0.93001926296699911,0.22911327364957101,1.0755120226405555,-2.5810831488875485,-1.5224174683998832,-0.88979874777028456,-3.2296565662242807,-0.023058462394002888,2.4930028352227707,-0.1391901351353767,1.5922447387391792,0.087845031426560083,2.073557000431915,0.27560286099688269,0.53811844808445231,-1.1728562952215813,1.8485655556507745,-0.76155332215218741,-1.3106685986598454,-1.3702681963163736,0.75216784266657211,0.3751490934866018,2.2817540385751762,1.49618619239912,-2.8140236835439385],"y":[1.4680957619141872,0.4381881288339935,0.3391055721219991,0.8013886687659233,0.059322582319498718,-0.034500721322302086,1.1292391571399194,1.4720425399537587,-1.4411730263296287,-2.1140914282217467,1.6053281373592436,0.093064643409177084,-0.20192620686562313,-0.11137767239100516,1.402033011390972,-0.29765129985968763,0.66711704350462675,-1.3740473468511458,-1.559356624082967,-0.65155743634459973,0.46829241390792609,0.19601338581626893,1.4595055580743503,1.9529167348981908,-0.51633734691273081,-1.1018116914280083,0.36250576477455132,-2.359471191451306,0.43285486628397418,-2.4298159975795266,-0.42571910458924589,0.34729853814892131,-2.5727155909281656,-0.1704916095140383,-2.2948534111439738,0.77519905986520543,0.28674549543080197,-2.0673253317741875,-2.3759874821146112,0.12301345904718808,0.5137253281319718,-2.1930951411476478,0.098423671466512097,-1.5147104574788965,0.30802703274969501,-1.5531387835242261,1.7376845078181957,0.012028913996822599,0.50554620714878507,-0.32452367849467656,-0.47206399064544002,1.2232417667481275,-1.7643364906111025,1.9655862536097768,-0.73052703177106748,-0.35303695853290051,0.21353976584460321,1.6943106659039744,1.6402204118005725,-0.46837188071952474,0.075254246512681533,0.74414993645507765,2.0370992254263007,1.8093633060196224,-0.096855127426844989,-1.0317360730684171,-0.33418741389846085,-0.039423118378298039,-0.36492113121313108,1.2576973038155934,1.3024486471510905,-2.581994789774158,-0.19391697028215127,0.63907571689337583,0.018509961556466115,-0.92260436286311043,0.80963532304451302,-2.6426531293936693,0.17269204021297258,1.7026556654077059,0.87180385644042246,1.6664845614729282,1.1511081567854244,0.55254640482129558,1.9721036677234465,-1.3928909720108873,-1.4313473043511613,-2.1191184597221255,-0.17426741429663495,-0.35964945687635375,2.0063944896093298,-2.4019034141491886,2.2394849272592343,0.71593165912402634,0.029846914118013546,0.38458936668895527,1.394292939484667,-2.2677329915525313,0.64760474343860919,1.836838954245696],"mode":"text","text":["product","quality","cable","price","phone","charging","nice","easy","battery","time","buy","sound","watch","tv","money","fast","fine","amazon","water","camera","power","screen","worth","bit","bought","speed","range","months","usb","days","charge","device","review","features","issue","light","mobile","day","usage","charger","laptop","issues","original","life","remote","installation","sturdy","low","mouse","box","experience","build","service","purchase","display","performance","decent","recommend","design","picture","bluetooth","budget","feel","size","noise","support","bad","bass","samsung","easily","rs","update","call","excellent","app","gb","button","month","average","it’s","expected","happy","weight","type","length","heating","normal","warranty","feature","video","job","found","plastic","amazing","boat","option","clean","received","connect","buying"],"type":"scatter","marker":{"color":"rgba(31,119,180,1)","line":{"color":"rgba(31,119,180,1)"}},"error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"line":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}</script>

**Comparing CBOW vs Skip-Gram visualizations:**

After creating both visualizations, compare them side-by-side:

1.  **Word clusters**: Are the same words clustered together in both
    models?
2.  **Cluster tightness**: Which model creates tighter, more distinct
    clusters?
3.  **Rare words**: Does Skip-Gram better separate specific product
    terms?
4.  **Overall structure**: Which gives you more useful insights about
    customer language?

**Key differences you might observe:**

- Skip-Gram often creates clearer separation between different product
  aspects

- CBOW might group more general descriptive words together

- Skip-Gram may better distinguish between specific features (e.g.,
  “fast charging” vs “long cable”)

- Look for how quality-related words (“durable”, “sturdy”, “reliable”)
  cluster together

**Which model to use?**

- **CBOW**: Faster, good for frequent words, general patterns

- **Skip-Gram**: Better for rare words, specific product terms, nuanced
  relationships

- **For Amazon reviews**: Both work well! Try both and see which gives
  better insights for your specific analysis

------------------------------------------------------------------------

## 4. Class Exercises: Sentiment Analysis and Word Embeddings

### Exercise 1: Sentiment Analysis on Airline Data

- Load the Airline Sentiment dataset.

``` r
url <- "https://raw.githubusercontent.com/aysedeniz09/IntroCSS/refs/heads/main/data/tweets.csv"
airline_user_data <- read_csv(url)
str(airline_user_data)
```

    ## spc_tbl_ [14,640 × 15] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ tweet_id                    : num [1:14640] 5.7e+17 5.7e+17 5.7e+17 5.7e+17 5.7e+17 ...
    ##  $ airline_sentiment           : chr [1:14640] "neutral" "positive" "neutral" "negative" ...
    ##  $ airline_sentiment_confidence: num [1:14640] 1 0.349 0.684 1 1 ...
    ##  $ negativereason              : chr [1:14640] NA NA NA "Bad Flight" ...
    ##  $ negativereason_confidence   : num [1:14640] NA 0 NA 0.703 1 ...
    ##  $ airline                     : chr [1:14640] "Virgin America" "Virgin America" "Virgin America" "Virgin America" ...
    ##  $ airline_sentiment_gold      : chr [1:14640] NA NA NA NA ...
    ##  $ name                        : chr [1:14640] "cairdin" "jnardino" "yvonnalynn" "jnardino" ...
    ##  $ negativereason_gold         : chr [1:14640] NA NA NA NA ...
    ##  $ retweet_count               : num [1:14640] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ text                        : chr [1:14640] "@VirginAmerica What @dhepburn said." "@VirginAmerica plus you've added commercials to the experience... tacky." "@VirginAmerica I didn't today... Must mean I need to take another trip!" "@VirginAmerica it's really aggressive to blast obnoxious \"entertainment\" in your guests' faces &amp; they hav"| __truncated__ ...
    ##  $ tweet_coord                 : chr [1:14640] NA NA NA NA ...
    ##  $ tweet_created               : chr [1:14640] "2015-02-24 11:35:52 -0800" "2015-02-24 11:15:59 -0800" "2015-02-24 11:15:48 -0800" "2015-02-24 11:15:36 -0800" ...
    ##  $ tweet_location              : chr [1:14640] NA NA "Lets Play" NA ...
    ##  $ user_timezone               : chr [1:14640] "Eastern Time (US & Canada)" "Pacific Time (US & Canada)" "Central Time (US & Canada)" "Pacific Time (US & Canada)" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   tweet_id = col_double(),
    ##   ..   airline_sentiment = col_character(),
    ##   ..   airline_sentiment_confidence = col_double(),
    ##   ..   negativereason = col_character(),
    ##   ..   negativereason_confidence = col_double(),
    ##   ..   airline = col_character(),
    ##   ..   airline_sentiment_gold = col_character(),
    ##   ..   name = col_character(),
    ##   ..   negativereason_gold = col_character(),
    ##   ..   retweet_count = col_double(),
    ##   ..   text = col_character(),
    ##   ..   tweet_coord = col_character(),
    ##   ..   tweet_created = col_character(),
    ##   ..   tweet_location = col_character(),
    ##   ..   user_timezone = col_character()
    ##   .. )
    ##  - attr(*, "problems")=<externalptr>

- Apply dictionary-based sentiment analysis using **Bing**, **AFINN**,
  and **NRC**.
- Compare the results and interpret the findings.
- Create a **visualization** (bar chart or word cloud) of sentiment
  scores.

### Exercise 2: Exploring Word Embeddings

- Find a **pre-trained word embedding model** (GloVe, Word2Vec, or
  FastText).
- Identify **the top 10 most similar words** for “positive” and
  “negative”.
- Visualize word relationships.

### Optional Exercise 3: Combining Sentiment Analysis and Word Embeddings (This is an advanced exercise for those that want to try)

- Select a subset of the Airline dataset.
- Compute sentiment scores using dictionary-based methods.
- Extract word embeddings for the most frequent words in positive and
  negative tweets.
- Compare sentiment-based results with word embedding similarities.

------------------------------------------------------------------------

## Lecture 7 Cheat Sheet

| **Function/Concept** | **Description** | **Code Example** |
|----|----|----|
| Tokenization (`unnest_tokens()`) | Breaks text into individual words or phrases for processing. | `twitter_tokens |> unnest_tokens(word, text)` |
| Removing Stopwords (`anti_join(stop_words)`) | Removes common stopwords to focus on meaningful content. | `twitter_tokens |> anti_join(stop_words)` |
| Sentiment Analysis (`get_sentiments()`) | Applies sentiment lexicons (Bing, AFINN, NRC) to categorize words. | `twitter_tokens |> inner_join(get_sentiments('bing'))` |
| Bing Sentiment Analysis (`inner_join(get_sentiments('bing'))`) | Classifies words as positive or negative using the Bing lexicon. | `bing_sentiments |> count(post_index, sentiment)` |
| AFINN Sentiment Analysis (`inner_join(get_sentiments('afinn'))`) | Assigns sentiment scores based on word intensity using AFINN. | `afinn_sentiments |> group_by(text) |> summarize(score = sum(value))` |
| NRC Sentiment Analysis (`inner_join(get_sentiments('nrc'))`) | Categorizes words by emotions such as anger, joy, and fear. | `nrc_sentiments |> count(sentiment)` |
| Word Embeddings - CBOW (`word2vec(type = 'cbow')`) | Trains a Continuous Bag of Words (CBOW) model for word embeddings. | `cbow_model <- word2vec(x = tweets, type = 'cbow', dim = 15, iter = 20)` |
| Word Embeddings - Skip-Gram (`word2vec(type = 'skip-gram')`) | Trains a Skip-Gram model to predict context words from target words. | `skip_gram_model <- word2vec(x = tweets, type = 'skip-gram', dim = 15, iter = 20)` |
| Finding Similar Words (`predict(model, type = 'nearest')`) | Finds words with similar meanings based on trained word embeddings. | `predict(cbow_model, c('election', 'vote'), type = 'nearest')` |
| Extracting Word Embeddings (`predict(model, type = 'embedding')`) | Extracts vector representations of words for further analysis. | `predict(skip_gram_model, c('election', 'vote'), type = 'embedding')` |
| Visualizing Sentiments (`ggplot() + geom_col()`) | Generates bar plots to visualize sentiment distribution in text. | `ggplot(bing_summary, aes(x = sentiment, y = n, fill = sentiment)) + geom_col()` |
| UMAP for Dimensionality Reduction (`umap()`) | Reduces high-dimensional word embeddings for visualization. | `umap_result <- umap(word_embeddings, n_neighbors = 15, n_threads = 2)` |
| Normalize Sentiment Scores (`mutate(normalized_score = score / word_count)`) | Normalizes sentiment scores by dividing by word count. | `afinn_scores |> mutate(normalized_score = score / word_count)` |
| Creating a Sentiment Pipeline (`pivot_wider() + mutate()`) | Combines multiple sentiment analysis steps into a single pipeline. | `bing_sentiments |> pivot_wider(names_from = sentiment, values_from = n, values_fill = 0) |> mutate(sentiment = positive - negative)` |
| Word Frequency with Tidy (`count()`) | Counts word frequencies using tidy approach | `twitter_tokens |> count(word, sort = TRUE)` |
| Top N Words (`top_n()`) | Selects top n rows based on a variable | `word_freq |> top_n(100, n)` |
| Word Cloud (`wordcloud2()`) | Creates interactive word clouds | `wordcloud2(word_freq, color = "gray20")` |
