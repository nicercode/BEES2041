
class_id <- function() {
  if (!exists("reditor_count", envir = .GlobalEnv)) {
    reditor_count <<- 1
  }
  reditor_count <<- reditor_count + 1
  paste0('r-editor-', reditor_count)
}
