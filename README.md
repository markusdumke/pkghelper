
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkghelper

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
<!-- badges: end -->

## Installation

You can install the package from Github with

``` r
devtools::install_github("markusdumke/pkghelper")
```

## Usage

Currently the package includes functions which scan the R code in the
package for all packages in use and writes these packages to the Imports
field of the DESCRIPTION file.

Together with `devtools` and `roxygen2` this package helps to make the R
package generation process more automatically.

``` r
library(pkghelper)
# Get names of packages my package depends on
get_dependencies()
#> [1] "desc"     "devtools" "magrittr" "purrr"    "stringr"
```

``` r
# Modify DESCRIPTION
write_dependencies()
#> Updating pkghelper DESCRIPTION
#> Type: Package
#> Package: pkghelper
#> Title: Manage package dependencies
#> Version: 0.1.0
#> Author: Markus Dumke
#> Maintainer: Markus Dumke <markusdumke@gmail.com>
#> Description: Fill Imports section in DESCRIPTION file of R package by
#>     scanning code for used packages.
#> License: MIT + file LICENSE
#> Imports:
#>     desc,
#>     devtools,
#>     magrittr,
#>     purrr,
#>     stringr
#> Encoding: UTF-8
#> LazyData: true
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 6.1.0
```
