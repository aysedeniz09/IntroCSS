#!/bin/bash

# Session Generator - Links to rendered HTML pages
# GitHub links point to .md files
# Lectures: Spring2027/LectureSlides/bigdata_LX-github.qmd (renders to .html)
# Exercises: Spring2027/exercises/bigdata_LX.R

echo "==================================="
echo "Generating Session Pages"
echo "==================================="
echo ""

# Session data: number|title
declare -a sessions=(
  "01|Why Computational Social Science? R Basics and Your First Dataset"
  "02|Data Wrangling"
  "03|Collecting Data: The Arctic Shift API"
  "04|Cleaning Text: Strings and Regular Expressions"
  "05|Visualization and Your First Quarto Dashboard"
  "06|Text as Data I: Tokens, KWIC, and TF-IDF"
  "07|Text as Data II: Dictionary Methods and Sentiment"
  "08|Text as Data III: Topic Modeling"
  "09|Topics and Sentiment over Time"
  "10|Topic Networks (ANTMN)"
  "11|Presenting Data: Publishing Your Dashboard"
  "12|Dashboard Presentations"
)

# Create sessions directory if needed
mkdir -p sessions

# Generate each session
for session in "${sessions[@]}"; do
  IFS='|' read -r num title <<< "$session"
  
  # Create directory
  mkdir -p "sessions/$num"
  
  # Determine navigation
  prev_num=$(printf "%02d" $((10#$num - 1)))
  next_num=$(printf "%02d" $((10#$num + 1)))
  
  if [ "$num" = "01" ]; then
    prev_link="← [Home](../../index.qmd)"
  else
    prev_link="← [Session $prev_num](../$prev_num/session.qmd)"
  fi
  
  if [ "$num" = "12" ]; then
    next_link="[End of Course] →"
  else
    next_link="[Session $next_num →](../$next_num/session.qmd)"
  fi
  
  # Remove leading zero for filename (L1, L2, not L01, L02)
  file_num=$((10#$num))
  
  # Create the session file
  cat > "sessions/$num/session.qmd" << 'ENDFILE'
---
title: "Session SESSIONNUM - SESSIONTITLE"
---

::: {.panel-tabset}

## Lecture

### Lecture Materials

- [View Lecture Notes](../../Spring2027/LectureSlides/bigdata_LFILENUM-github.html)
- [View Source on GitHub](https://github.com/aysedeniz09/IntroCSS/blob/main/Spring2027/LectureSlides/bigdata_LFILENUM-github.md)

---

## In-Class Script

### In-Class Script

- [Download the In-Class Script (.R)](../../Spring2027/exercises/bigdata_LFILENUM.R)
- [View on GitHub](https://github.com/aysedeniz09/IntroCSS/blob/main/Spring2027/exercises/bigdata_LFILENUM.R)

**Instructions:**

1. Right-click the download link above and select "Save Link As"
2. Save the `.R` file in your class project folder
3. Open the file in RStudio
4. Follow along in class and complete the activities

:::

---

::: {.grid}
::: {.g-col-4}
PREVLINK
:::
::: {.g-col-4 style="text-align: center;"}
[Schedule](../../schedule.qmd)
:::
::: {.g-col-4 style="text-align: right;"}
NEXTLINK
:::
:::
ENDFILE

  # Replace placeholders
  perl -i -pe "s/SESSIONNUM/$num/g" "sessions/$num/session.qmd"
  perl -i -pe "s/SESSIONTITLE/$title/g" "sessions/$num/session.qmd"
  perl -i -pe "s/LFILENUM/L$file_num/g" "sessions/$num/session.qmd"
  perl -i -pe "s|PREVLINK|$prev_link|g" "sessions/$num/session.qmd"
  perl -i -pe "s|NEXTLINK|$next_link|g" "sessions/$num/session.qmd"
  
  echo "✓ Created Session $num: $title"
done

echo ""
echo "==================================="
echo "All session files created!"
echo "==================================="
echo ""
echo "Files needed:"
echo "- Spring2027/LectureSlides/bigdata_L1-github.md (for GitHub)"
echo "- Spring2027/LectureSlides/bigdata_L1-github.qmd (for Quarto rendering)"
echo ""
echo "Run 'quarto preview' to see your site!"
echo ""