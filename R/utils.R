.get_h5_name <-
    function(fpath, otype = "H5I_DATASET", remote = TRUE, nameCol = "name")
{
    l1 <- rhdf5::h5ls(fpath, recursive = FALSE, s3 = remote)
    l1[l1$otype == otype, nameCol]
}

.getH5 <- function(file)
{   
    h5f <- HDF5Array::H5File(file, s3 = TRUE)
    h5a <- HDF5Array::HDF5Array(h5f, .get_h5_name(file))
    return(h5a)
} 

.getRecord <- function(pattern, files)
{
    rfile <- paste(pattern, "rds", sep = ".")
    ind <- basename(files) == rfile
    dat <- readRDS(url(files[ind]))
    return(dat)
}

