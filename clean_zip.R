#!/usr/bin/env Rscript

# This file makes a clean zip of a folder, removing
# any special mac files and .Rproj.user
# Example, /create_public.R my_folder

path <- commandArgs(TRUE)[1]

# Remove files that don't want in public release
files <- 
  list.files(path, full.names = TRUE, recursive = TRUE, all.files = TRUE)

unwanted <- c("TODO", ".DS_", "Rproj.user", "WIP/", "X_setup", "solutions", "ignore", ".Rhistory", ".git", "output", ".key")

for(f in unwanted)
  files <- files[!grepl(tolower(f), tolower(files), fixed = TRUE)]

# deafult flags. 
# X excludes specieal mac files
# 9 max compression
# r recursive
utils::zip(paste0(path, ".zip"), files,  flags = "-9X")
