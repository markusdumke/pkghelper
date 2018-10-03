#' Update Imports section in DESCRIPTION file.
#'
#' Scans all files in R/ for used packages (searching for :: syntax) and scans
#' NAMESPACE file for import and importFrom. Then writes dependencies to Imports
#' section in DESCRIPTION file.
#'
#' @return Nothing.
#' @export
#' @import magrittr
#'
#' @examples
#' \dontrun{
#' update_dependencies()
#' }
update_dependencies <- function() {
  packages <- get_dependencies()
  desc <- desc::description$new()
  deps <- data.frame(type = "Imports", package = packages, version = "*")
  desc$set_deps(deps)
}

get_dependencies <- function() {
  sort(unique(c(get_dependencies_r(), get_dependencies_namespace())))
}

get_dependencies_r <- function() {
  files <- list.files(here::here("R/"))
  purrr::map(files, ~parse(stringr::str_c("R/", .)) %>%
               as.character %>%
               stringr::str_extract_all("[a-zA-Z][a-zA-Z0-9\\.]+(?=::)")) %>%
    unlist %>%
    unique %>%
    sort
}

get_dependencies_namespace <- function() {
  namespace <-
    parse(here::here("NAMESPACE")) %>%
    as.character

  imports <- namespace %>%
    stringr::str_extract_all("(?<=import\\()[[^\\)]]+") %>%
    unlist %>%
    unique

  imports.from <- namespace %>%
    stringr::str_extract_all("(?<=importFrom\\()[[^,]]+") %>%
    unlist %>%
    unique

  sort(unique(imports, imports.from))
}
