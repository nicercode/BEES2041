generate_moodle_quiz_rmd <- function(file, webr = FALSE) {

  file_moodle_quiz <- str_replace(file, ".qmd", "-moodle.rmd")
  yaml <- rmarkdown::yaml_front_matter(file)

  # New front matter
front_matter <- sprintf(
"---
title: \"%s\"
output:
  moodlequiz::moodlequiz:
    replicates: 1
moodlequiz:
  category: %s
editor_options:
  chunk_output_type: console
---

```{r,  echo=FALSE, message=FALSE, warning=FALSE}
# webr counter
source('../../R/webr-counter.R')
library(moodlequiz)
```\n\n", yaml$title, yaml$title
)

  # Read the file
  lines <- readLines(file)
  
  # detect end of front matter
  i <- which(str_detect(lines, "---"))[2]
 
  new_lines <- 
    # Drop old front matter
    lines[-seq(1, i)] |>
    remove_solutions() |>
    add_headers() 
  
  if(webr) {
    new_lines <- new_lines |>
      add_webr()
  }

  c(front_matter, new_lines) |>
  writeLines(file_moodle_quiz)

  file_moodle_quiz
}


add_headers <- function(lines) {
  lines |>
    # Using `NNNN` for new line when collapsing because this doesn't interfere with string replacement whereas `\n` does
    stringr::str_c(collapse = "NNN") |>
    # the regular expression searches for everything between  NNNN##  and NNNN, dpluicates the lines with h3 tags and then splits the string back into lines
    stringr::str_replace_all("NNN## (.+?)(?=NNN)", "NNN## \\1NNNNNN<h3>\\1</h3>NNNNNN") |>
    stringr::str_split_1("NNN")
}


add_webr <- function(lines) {
  lines |>
    # Using `NNNN` for new line when collapsing because this doesn't interfere with string replacement whereas `\n` does
    stringr::str_c(collapse = "NNN") |>
    # the regular expression searches for everything between  NNNN##  and NNNN, dpluicates the lines with h3 tags and then splits the string back into lines
    stringr::str_replace_all("\`\`\`\\{r(.*?)\\}(.*?)\`\`\`", "<div id=`r class_id()`><pre>\\2</pre></div>") |>
    stringr::str_split_1("NNN")
}
