#' Returns all packages used by the package.
#'
#' Scans all files in R/ for used packages (searching for :: syntax) and scans
#' NAMESPACE file for import and importFrom.
#'
#' Make sure to import all dependencies or use the explicit `::` syntax when
#' calling functions from other packages and to generate the `NAMESPACE` first.
#'
#' @inheritParams write_dependencies
#'
#' @return A character vector with the packages used in the package.
#' @export
#'
#' @examples
#' \dontrun{
#' get_dependencies
#' }
get_dependencies <- function(pkg = ".") {
  pkg <- devtools::as.package(pkg)
  pkg.path <- pkg$path
  sort(unique(c(get_dependencies_r(pkg.path), get_dependencies_namespace(pkg.path))))
}

get_dependencies_r <- function(pkg.path) {
  files <- list.files(file.path(pkg.path, "R"))
  purrr::map(files, ~parse(file.path("R", .)) %>%
               as.character %>%
               stringr::str_extract_all("[a-zA-Z][a-zA-Z0-9\\.]+(?=::)")) %>%
    unlist %>%
    unique %>%
    sort
}

get_dependencies_namespace <- function(pkg.path) {
  namespace <-
    parse(file.path(pkg.path, "NAMESPACE")) %>%
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
