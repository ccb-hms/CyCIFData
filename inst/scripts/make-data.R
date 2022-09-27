dat <- data.frame(
    hostname = "https://mghp.osn.xsede.org",
    bucket = "bir190004-bucket01/TMA11/zarr/"
)

write.dcf(dat, file = "~/data/CyCIFData/TMA11_OSN_ZARR.dcf")

dat <- data.frame(
    hostname = "https://mghp.osn.xsede.org",
    bucket = "bir190004-bucket01/TMA11/hdf5/"
)

write.dcf(dat, file = "~/data/CyCIFData/TMA11_OSN_H5.dcf")
