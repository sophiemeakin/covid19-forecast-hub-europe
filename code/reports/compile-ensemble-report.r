# packages ---------------------------------------------------------------------
library(purrr)
library(dplyr)
library(here)
library(readr)
library(scoringutils)
library(rmarkdown)
library(data.table)
library(covidHubUtils)
library(lubridate)

options(knitr.duplicate.label = "allow")

start_date <- as.Date("2021-03-22")
recreate <- TRUE

report_dates <-
  lubridate::floor_date(lubridate::today(), "week", week_start = 7) + 1
report_type <- "ensemble"

dir.create(here::here("html"))

if (recreate) {
  report_dates <- seq(start_date, report_dates, by = 7)
}

for (rdc in as.character(report_dates)) {
  report_date <- as.Date(rdc)
  rmarkdown::render(here::here(
    "code", "reports", "ensemble",
    "ensemble-report.Rmd"
  ),
  params = list(report_date = report_date),
  output_format = "html_document",
  output_file =
    here::here("html", paste0(
      "ensemble-report-", report_date,
      ".html"
    )),
  envir = new.env()
  )
}
