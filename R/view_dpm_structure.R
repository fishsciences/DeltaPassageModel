#' Create pkgnet package report
#'
#' Create pkgnet package report that launches in default browser. The 'Function Network' tab is useful for visualizing
#' how DPM is structured by showing a network graph of the functions.
#'
#' @md
#'
#' @export

view_dpm_structure <- function(){
  pkgnet::CreatePackageReport("DeltaPassageModel")
}

