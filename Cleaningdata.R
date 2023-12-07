These cleaning functions were used for the dataset

---
  title: "Reproducible Science & Figures in R"
date: "2023-11-09"
output:
  html_document: default
pdf_document: default
---
  
  ## Installing packages
  
  ```{r}
install.packages("ggplot2")
install.packages("palmerpenguins")
install.packages("janitor")
install.packages("dplyr")
```

## Loading Packages

```{r}
library(ggplot2)
library(dplyr)
library(palmerpenguins)
library(janitor)
```

## Loading and visualing data

```{r}
head(penguins_raw)
```

## Cleaning data by creating a new 'data' folder and defining a new subject to replace some of the column names to make the data cleaner and more readable  

```{r}
write.csv(penguins_raw, "data/penguins_raw.csv")
names(penguins_raw)
penguins_clean <- select(penguins_raw,-starts_with("Delta"))
penguins_clean <- select(penguins_clean,-Comments)
names(penguins_clean)
```

## Making the same step but with pipes instead

```{r}
names(penguins_raw)

#  ---- OLD VERSION OF THE CODE ----
# penguins_clean <- select(penguins_raw,-starts_with("Delta"))
# penguins_clean <- select(penguins_clean,-Comments)
# ----------------------------------

penguins_clean <- penguins_raw %>%
  select(-starts_with("Delta")) %>%
  select(-Comments) %>%
  clean_names()
names(penguins_clean)
```

## Making a function to clean up the data set instead

```{r}
# A function to make sure the column names are cleaned up, 
# eg lower case and snake case
clean_column_names <- function(penguins_data) {
  penguins_data %>%
    select(-starts_with("Delta")) %>%
    select(-Comments) %>%
    clean_names()
}

# Check what the column names look like:
names(penguins_raw)

#  ---- OLD VERSION OF THE CODE ----
# penguins_clean <- select(penguins_raw,-starts_with("Delta"))
# penguins_clean <- select(penguins_clean,-Comments)
# ----------------------------------

#  ---- OLD VERSION OF THE CODE ----
# penguins_clean <- penguins_raw %>%
#   select(-starts_with("Delta")) %>%
#   select(-Comments) %>%
#   clean_names()
# ----------------------------------

# Define Function
clean_function <- function(penguins_data) {
  penguins_data %>%
    select(-starts_with("Delta")) %>%
    select(-Comments) %>%
    clean_names()
}

# Call Function
penguins_clean <- clean_function(penguins_raw)

# Check the column names in the new data frame:
names(penguins_clean)

```

## Loading the functions R file into the Rmd file and testing to see if the functions work

```{r}
source("functions/cleaning.r")

names(penguins_raw)

penguins_clean <- clean_column_names(penguins_raw)

names(penguins_clean)

# Another function fixes the species names. They're currently too long:
head(penguins_clean["species"])

penguins_clean_species <- shorten_species(penguins_clean)

head(penguins_clean_species["species"])

# Because we want to use multiple functions, we should pipe them. 
penguins_clean <- penguins_raw %>%
  clean_column_names() %>%
  shorten_species() %>%
  remove_empty_columns_rows()

head(penguins_clean)

head(penguins_clean_species)

```
