#!/usr/bin/env Rscript

# This file makes a clean zip of a folder, removing
# any special mac files and .Rproj.user
# It will create a folder with the same name as the lesson material
# E.g. ../../create_public.R Wk1-1-intro

path <- commandArgs(TRUE)[1]

original_wd <- getwd()          # Store current working directory
on.exit(setwd(original_wd))  

setwd(path) # Change to new working directory

# Remove files that don't want in public release
files <- 
  list.files(".", full.names = TRUE, recursive = TRUE, all.files = TRUE)

unwanted <- c("TODO", ".DS_", "Rproj.user", "WIP/", "X_setup", "solutions", "ignore", ".Rhistory", ".git", ".key")

for(f in unwanted)
  files <- files[!grepl(tolower(f), tolower(files), fixed = TRUE)]

# flags:
# - X excludes specieal mac files
# - 9 max compression
# - r recursive
filename <- paste0(original_wd, "/", basename(path), ".zip")

message(sprintf("Creating file %s\n", filename))
utils::zip(filename, files,  flags = "-9X")
