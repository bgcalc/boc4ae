## config

## max number of Ps (2-5)
N <- 5

## max number of dice (1-6)
max_dice <- 6

## max targeting value (1-6)
max_target <- 5


####


## load packages
suppressPackageStartupMessages({
  library("data.table")
  library("qs2")
  library("shiny")
  library("shinyjs")
  library("shinyWidgets")
})

## load data
battle_data <- list(
  NULL,
  qd_read("b2.qs2"),
  qd_read("b3.qs2"),
  qd_read("b4.qs2"),
  qd_read("b5.qs2")
)
