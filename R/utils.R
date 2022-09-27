.get_h5_name <-
    function(fpath, otype = "H5I_DATASET", remote = TRUE, nameCol = "name")
{
    l1 <- rhdf5::h5ls(fpath, recursive = FALSE, s3 = remote)
    l1[l1$otype == otype, nameCol]
}
