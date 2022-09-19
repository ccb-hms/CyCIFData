dat <- data.frame(
    hostname = "https://mghp.osn.xsede.org",
    bucket = "bir190004-bucket01/TMA11/zarr/"
)

write.dcf(dat, file = "~/data/CyCIFData/TMA11_osn.dcf")
