logger::log_info("Translating params to CTM format")
portfolio_name <- commandArgs(trailingOnly = TRUE)

working_dir <- file.path("/", "bound", "working_dir")

params_file <- file.path(
  working_dir,
  "10_Parameter_File",
  paste0(portfolio_name, "_PortfolioParameters.yml")
)
portfolio_file <- file.path(
  working_dir,
  "20_Raw_Inputs",
  paste0(portfolio_name, ".csv")
)

logger::log_info("Reading portfolio parameters")
if (file.exists(params_file)) {
  raw_portfolio_params <- config::get(file = params_file)[["parameters"]]
} else {
  logger::log_error("Parameter file not found")
  stop("Parameter file not found")
}

imported_params <- raw_portfolio_params
imported_params[["language_select"]] <- imported_params[["language"]]

default_params <- jsonlite::fromJSON("/default_config.json")

logger::log_info("Merging default and imported parameters")
params <- config::merge(default_params, raw_portfolio_params)

if (params[["holdings_date"]] == "2022Q4") {
  params[["data_dir"]] <- file.path("/", "pacta-data", params[["holdings_date"]])
} else {
  stop("This demo only supports 2022Q4 holdings_date")
}

if (params[["project_code"]] != "GENERAL") {
  stop("This demo only supports GENERAL project_code")
}

params[["portfolio_path"]] <- portfolio_file
params[["output_dir"]] <- file.path(working_dir, "40_Results")

logger::log_info("Writing parameters to file")
writeLines(
  jsonlite::toJSON(params, pretty = TRUE, auto_unbox = TRUE),
  con = file.path(working_dir, "params.json")
)
logger::log_info("Done translating params to CTM format")
