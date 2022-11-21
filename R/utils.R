.get_h5_name <- function(fpath) {
    ## names are predictable
    gsub(".h5", "", basename(fpath), fixed = TRUE)
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

