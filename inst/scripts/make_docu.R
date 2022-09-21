# version 1
## REMOTE ONLY
df <- data.frame(
    DataProvider = "Laboratory of Systems Pharmacology at Harvard Medical School",
    TaxonomyId = "9606",
    Species = "Homo sapiens",
    Title = "Exemplar Microscopy Images of Tissues (EMIT)",
    SourceUrl = "https://www.synapse.org/#!Synapse:syn22345748/wiki/",
    SourceType = "TXT",
    Location_Prefix = "https://mghp.osn.xsede.org/",
    RDataPath = "bir190004-bucket01/TMA11/zarr/",
    DispatchClass = "FilePath",
    RDataClass = "character",
    SourceVersion = "1.0.0",
    Maintainer  = "Ludwig Geistlinger <ludwig_geistlinger@hms.harvard.edu>",
    stringsAsFactors = FALSE
)
write.csv(
    df,
    file = "~/gh/CyCIFData/inst/extdata/docuData/CyCIFData_v1.csv",
    row.names = FALSE
)

# version 2
# LOCAL .dcf file
df <- data.frame(
    DataProvider = "Laboratory of Systems Pharmacology at Harvard Medical School",
    TaxonomyId = "9606",
    Species = "Homo sapiens",
    Title = "Exemplar Microscopy Images of Tissues (EMIT)",
    SourceUrl = "https://www.synapse.org/#!Synapse:syn22345748/wiki/",
    SourceType = "DCF",
    RDataClass = "matrix",
    SourceVersion = "1.0.0",
    Maintainer  = "Ludwig Geistlinger <ludwig_geistlinger@hms.harvard.edu>",
    stringsAsFactors = FALSE
)
write.csv(
    df,
    file = "~/gh/CyCIFData/inst/extdata/docuData/CyCIFData_v2.csv",
    row.names = FALSE
)

# version 3
## REMOTE ONLY
df <- data.frame(
    DataProvider = "Laboratory of Systems Pharmacology at Harvard Medical School",
    TaxonomyId = "9606",
    Species = "Homo sapiens",
    Title = paste0("Exemplar Microscopy Images of Tissues (EMIT) as ", c("ZARR", "HDF5")),
    SourceUrl = "https://www.synapse.org/#!Synapse:syn22345748/wiki/",
    SourceType = "TXT",
    Location_Prefix = "https://mghp.osn.xsede.org/",
    RDataPath = paste0("bir190004-bucket01/TMA11/", c("zarr/", "hdf5/")),
    DataType = c("Zarr", "HDF5"),
    DispatchClass = "FilePath",
    RDataClass = "character",
    SourceVersion = "1.0.0",
    Maintainer  = "Ludwig Geistlinger <ludwig_geistlinger@hms.harvard.edu>",
    stringsAsFactors = FALSE
)
write.csv(
    df,
    file = "~/gh/CyCIFData/inst/extdata/docuData/CyCIFData_v3.csv",
    row.names = FALSE
)
