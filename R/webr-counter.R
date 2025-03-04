reditor_count <- 1

class_id <- function() {
  reditor_count <<- reditor_count + 1
  paste0('r-editor-', reditor_count)
}
