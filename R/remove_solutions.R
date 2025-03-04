# This function removes any content in Rmd files with the
# following format
# ```{r, solution}
# your code here
# ```

remove_solutions <- function(lines) {
  lines |>
    # Using `NNNN` for new line when collapsing because this doesn't interfere with string replacement whereas `\n` does
    stringr::str_c(collapse = "NNN") |>
    # the regular expression searches for everything between  `r, solution}` and three backticks and replaces this with two blank lines
    stringr::str_replace_all("r solution.+?(?=\`\`\`)", "r}NNNNNN") |>
    stringr::str_split_1("NNN")
}

remove_cloze <- function(lines, replace = "???") {
  lines |>
    stringr::str_replace_all("`r cloze.+?\`", replace)
}
