#' Document package.
#'
#' This function calls [devtools::document()] to update NAMESPACE and documentation
#' and then calls [write_dependencies()] to update the DESCRIPTION file.
#'
#' @inheritParams write_dependencies
#' @export
#'
#' @examples
#' \dontrun{
#' document()
#' }
document <- function(pkg = ".") {
  devtools::document(pkg = pkg)
  pkg <- devtools::as.package(pkg)
  write_dependencies(pkg = pkg)
}
