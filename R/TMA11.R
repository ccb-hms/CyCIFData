#' @export
TMA11 <- function(format = c("hdf5", "zarr")) {
    format <- match.arg(format)
    ## use for now until EH resource is live
    zr <- ZarrRemote(
        endpoint = "https://mghp.osn.xsede.org/",
        bucket = paste0("bir190004-bucket01/TMA11/", format, "/")
    )
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
