#!/bin/bash

# Quick Start Script for Quarto Website Migration
# This script helps set up the basic folder structure for your course website

echo "==================================="
echo "Quarto Website Setup Script"
echo "Social Data Analysis Course"
echo "==================================="
echo ""

# Create main directory structure
echo "Creating directory structure..."

# Session directories
mkdir -p sessions/session01
mkdir -p sessions/session02
mkdir -p sessions/session03
mkdir -p sessions/session04
mkdir -p sessions/session05
mkdir -p sessions/session06
mkdir -p sessions/session07
mkdir -p sessions/session08
mkdir -p sessions/session09
mkdir -p sessions/session10
mkdir -p sessions/session11
mkdir -p sessions/session12
mkdir -p sessions/session13

# Resources directory
mkdir -p resources

# Keep existing directories
# images/ (already exists)
# Spring25/ (already exists)

echo "✓ Directory structure created"
echo ""

# Create placeholder index.qmd files for each session
echo "Creating session placeholder files..."

for i in {01..13}
do
    cat > sessions/session${i}/index.qmd << 'EOF'
---
title: "Session X: Topic Title"
subtitle: "Subtitle Here"
date: "Date Here"
---

## Overview

Session overview here.

## Learning Objectives

- Objective 1
- Objective 2
- Objective 3

## Topics Covered

Content here.

## Required Readings

Readings here.

## In-Class Materials

Links to slides and code.

## Assignment

Assignment details.
EOF
done

echo "✓ Session placeholder files created"
echo ""

# Create resource files
echo "Creating resource pages..."

cat > resources/cheatsheets.qmd << 'EOF'
---
title: "R Cheatsheets"
---

## Essential R Cheatsheets

Collection of helpful R cheatsheets for the course.

- Base R
- dplyr
- ggplot2
- tidyr

## External Resources

- [RStudio Cheatsheets](https://rstudio.com/resources/cheatsheets/)
EOF

cat > resources/datasets.qmd << 'EOF'
---
title: "Datasets"
---

## Course Datasets

List of datasets used in this course.

## Where to Find Data

Resources for finding data for your projects.
EOF

echo "✓ Resource pages created"
echo ""

# Create .gitignore for Quarto
echo "Creating .gitignore..."

cat > .gitignore << 'EOF'
/.quarto/
/_site/
/.Rproj.user
.Rhistory
.RData
.Ruserdata
*.log
.DS_Store
EOF

echo "✓ .gitignore created"
echo ""

echo "==================================="
echo "Setup Complete!"
echo "==================================="
echo ""
echo "Next steps:"
echo "1. Copy _quarto.yml, index.qmd, and styles.css to your repository root"
echo "2. Customize the content in index.qmd and session files"
echo "3. Run 'quarto preview' to test locally"
echo "4. Run 'quarto render' to build the site"
echo "5. Push to GitHub and enable GitHub Pages"
echo ""
echo "For detailed instructions, see quarto_migration_guide.md"
echo ""
