#' Update Imports section in DESCRIPTION file.
#'
#' Scans all files in R/ for used packages (searching for :: syntax) and scans
#' NAMESPACE file for import and importFrom. Then writes dependencies to Imports
#' section in DESCRIPTION file.
#'
#' Make sure to import all dependencies or use the explicit `::` syntax when
#' calling functions from other packages and to generate the `NAMESPACE` first.
#'
#' @inheritParams devtools::document
#'
#' @export
#' @import magrittr
#'
#' @examples
#' \dontrun{
#' write_dependencies()
#' }
write_dependencies <- function(pkg = ".") {
  pkg <- devtools::as.package(pkg)
  packages <- get_dependencies(pkg = pkg)
  deps <- data.frame(type = "Imports", package = packages, version = "*")
  message("Updating ", pkg$package, " DESCRIPTION")
  desc::desc_set_deps(deps)
}
