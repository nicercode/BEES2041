# Searching and replacing webr chunks

1. `<h3>` replace with `###`
2. `</h3>` replace with nothing
3. `<div id=\"r-editor-[0-9]+\">(?:<pre>)?` replace ```{r} the start of an R chunk
4. `</pre>` replace ```
5. `</div>` replace with nothing
6. `<br>`
7. Check the setup for required dependencies
8. Manually review `moodlequiz::cloze(...)`, retain the answer as plain text, and remove extra options.
9. Knit the document to verify answers





