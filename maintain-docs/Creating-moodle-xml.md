# Searching and replacing ### into webr chunks

TIP: Comment out the moodlequiz relevant parts of the yaml and replace with `output: html_document` to preview iterative in RStudio
---
title: "Getting started in RStudio"
date: "2025-02-15"
output: html_document
#   moodlequiz::moodlequiz:
#     replicates: 1
# moodlequiz:
#   category: "Week 1-1 RStudio"
# editor_options: 
#   chunk_output_type: console
---


## H2 Headers

`moodlequiz` uses ## to separate questions, so if you want to retain that level of header, duplicate your h2 header and add <h2> tags accordingly e.g. `<h2>Getting Started in RStudio</h2>`

### H3 Headers

- `### ` find and replace with <h3> and then manually add `</h3>`
- Use "Find All" on `<h3>` which will highlight all cases and paste `</h3>` at the end of the heading

## Creating webr divs

1. Search ```{r} and replace with `<div id="r-editor-01"><pre>`
2. Search ``` and replace with `</pre></div>`

Note, depending on content you may not all want to turn all chunks into webr. e.g. demo code

## Update and check uniqueness of r-editor-id

The numbers after `r-editor-` needs to be unique within the document
