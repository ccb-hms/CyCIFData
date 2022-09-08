# version 1
df <- data.frame(
    DataProvider = "Laboratory of Systems Pharmacology at Harvard Medical School",
    TaxonomyId = "9606",
    Species = "Homo sapiens",
    SourceUrl = "https://www.synapse.org/#!Synapse:syn22345748/wiki/",
    SourceType = "TXT",
    SourceVersion = "1.0.0",
    Maintainer  = "Ludwig Geistlinger <ludwig_geistlinger@hms.harvard.edu>",
    stringsAsFactors = FALSE
)
write.csv(
    df,
    file = "inst/extdata/docuData/CyCIFData_v1.csv",
    row.names = FALSE
)
