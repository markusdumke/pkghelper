#' Write dependency packages to DESCRIPTION.
#'
#' Scans all files in `R/` for used packages (searching for `::` syntax) and scans
#' `NAMESPACE` file for import and importFrom statements.
#' Then writes dependencies to `Imports` section in `DESCRIPTION` file.
#'
#' Make sure to import all dependencies or use the explicit `::` syntax when
#' calling functions from other packages and to generate the `NAMESPACE` first.
#'
#' @inheritParams devtools::document
#'
#' @export
#'
#' @examples
#' \dontrun{
#' write_dependencies()
#' }
write_dependencies <- function(pkg = ".") {
  pkg <- devtools::as.package(pkg)

  # get dependencies mentioned in package source or NAMESPACE
  packages <- get_dependencies(pkg = pkg)
  if (length(packages) > 0) {
    updated_deps <- data.frame(type = "Imports", package = packages)
  } else {
    updated_deps <- data.frame(type = character(0), package = character(0))
  }
  # get dependencies already declared in DESCRIPTION
  existing_deps <- desc::desc_get_deps(pkg$path)
  # keep version numbers from pre-existing dependencies
  deps <- merge(existing_deps, updated_deps, all.y = TRUE)
  # dependencies with no version info (i.e. new dependencies or not specified) match anything
  deps$version[is.na(deps$version)] <- "*"

  message("Updating ", pkg$package, " DESCRIPTION")
  desc::desc_set_deps(deps, file = pkg$path)
}
