# version 1
df <- data.frame(
    DataProvider = "Laboratory of Systems Pharmacology at Harvard Medical School",
    TaxonomyId = "9606",
    Species = "Homo sapiens",
    Title = "Exemplar Microscopy Images of Tissues (EMIT)",
    SourceUrl = "https://www.synapse.org/#!Synapse:syn22345748/wiki/",
    SourceType = "TXT",
    Location_Prefix = "https://mghp.osn.xsede.org/",
    RDataPath = "bir190004-bucket01/TMA11/zarr/",
    RDataClass = "ZarrRemote",
    SourceVersion = "1.0.0",
    Maintainer  = "Ludwig Geistlinger <ludwig_geistlinger@hms.harvard.edu>",
    stringsAsFactors = FALSE
)
write.csv(
    df,
    file = "~/gh/CyCIFData/inst/extdata/docuData/CyCIFData_v1.csv",
    row.names = FALSE
)
