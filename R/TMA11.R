#' Import Tissue MicroArray files as either HDF5 or Zarr
#'
#' The function uses `ZarrExperiment` to locate remote files. Depending on the
#' `format` input, either a `ZarrRemote` class is produced for `Zarr` files or a
#' `CytoImageList` is given for `HDF5` files. All files are hosted on the Open
#' Storage Network (OSN) and queried via `ExperimentHub` (pending).
#'
#' @param format character(1) Either "hdf5" or "zarr" to indicate the desired
#'   file types to obtain from the OSN. HDF5 files will be represented via
#'   the `cytomapper::CytoImageList` class and Zarr files will be returned as
#'   a single `ZarrRemote` object.
#'
#' @seealso <https://mghp.osn.xsede.org/bir190004-bucket01/index.html#TMA11/>,
#'   <https://www.synapse.org/#!Synapse:syn22345748/wiki/>
#'
#' @examples
#' if (interactive()) {
#'   browseURL(
#'     "https://mghp.osn.xsede.org/bir190004-bucket01/index.html#TMA11/"
#'   )
#'   browseURL("https://www.synapse.org/#!Synapse:syn22345748/wiki/")
#' }
#'
#' @export
TMA11 <- function(format = c("hdf5", "zarr")) {
    format <- match.arg(format)
    ## use for now until EH resource is live
    zr <- ZarrRemote(
        endpoint = "https://mghp.osn.xsede.org/",
        bucket = paste0("bir190004-bucket01/TMA11/", format, "/")
    )
    if (identical(format, "zarr"))
        return(zr)
    files <- files(zr)
    ex_files <- setNames(files, basename(files))
    cytomapper::CytoImageList(
        lapply(
            ex_files, function(file) {
                HDF5Array::HDF5Array(
                    H5File(file, s3 = TRUE), .get_h5_name(file)
                )
            }
        ),
        on_disk = TRUE,
        h5FilesPath = HDF5Array::getHDF5DumpDir()
    )
}
