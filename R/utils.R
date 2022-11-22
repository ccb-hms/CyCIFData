.get_h5_name <- function(fpath) {
    ## names are predictable
    gsub(".h5", "", basename(fpath), fixed = TRUE)
}

.get_h5_from_files <- function(files)
{
    lapply(
        files,
        function(file) {
            h5f <- HDF5Array::H5File(file, s3 = TRUE)
            HDF5Array::HDF5Array(h5f, .get_h5_name(file))
        }
    )
}

.get_rds_from_files <- function(pattern, files)
{
    rfile <- paste(pattern, "rds", sep = ".")
    ind <- basename(files) == rfile
    readRDS(url(files[ind]))
}

