library(vroom)
library(gh)

locations_url <-
  paste("https://raw.githubusercontent.com",
        "epiforecasts",
        "covid19-forecast-hub-europe",
        "main",
        "data-locations",
        "locations_eu.csv",
        sep = "/")
countries <- sort(vroom(locations_url)$location_name)

ensemble_reports <- list.files("reports", pattern = "^ensemble-report")
ensemble_report_dates <-
  as.Date(sub("^ensemble-report-(.+).html", "\\1", ensemble_reports))

evaluation_overall_reports <-
  list.files("reports", pattern = "^evaluation-report.*-Overall.html")
evaluation_report_dates <-
  as.Date(sub("^evaluation-report-(.+)-Overall.html", "\\1",
              evaluation_overall_reports))

ensemble_files <- gh(
  "/repos/{owner}/{repo}/contents/{path}",
  owner = "epiforecasts",
  repo = "covid19-forecast-hub-europe",
  path = "data-processed/EuroCOVIDhub-ensemble")
ensemble_filenames <-
  grep("\\.csv$", vapply(ensemble_files, "[[", "", "name"), value = TRUE)
dates <- as.Date(substr(ensemble_filenames, 1, 10))
dates <- sort(dates[dates >= "2021-03-22"], decreasing = TRUE)
