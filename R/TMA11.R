#' Import Tissue MicroArray files as either HDF5 or Zarr
#'
#' The function uses `ZarrExperiment` to locate remote files. Depending on the
#' `format` input, either a `ZarrRemote` class is produced for `Zarr` files or a
#' `CytoImageList` is given for `HDF5` files. All files are hosted on the Open
#' Storage Network (OSN) and queried via `ExperimentHub` (pending).
#'
#' @param data.component character(1)
#'
#' @param format character(1) Either "hdf5" or "zarr" to indicate the desired
#'   file types to obtain from the OSN. HDF5 files will be represented via
#'   the `CytoImageList::CytoImageList` class and Zarr files will be returned as
#'   a single `ZarrRemote` object.
#'
#' @param mask.type character(1)
#'
#' @seealso <https://mghp.osn.xsede.org/bir190004-bucket01/index.html#TMA11/>,
#'   <https://www.synapse.org/#!Synapse:syn22345748/wiki/>
#'
#' @examples
#' if (interactive()) {
#'   browseURL(
#'     "https://mghp.osn.xsede.org/bir190004-bucket01/index.html#TMA11/"
#'   )
#'   browseURL("https://www.synapse.org/#!Synapse:syn22345748/wiki/")
#' }
#'
#' @export
TMA11 <- function(data.component = c("expression", "images", "masks"), 
                  format = c("hdf5", "zarr"),
                  mask.type = c("cell", "nucleus"))
{
    data.component <- match.arg(data.component)
    if(data.component == "expression") .loadExpression()
    else if(data.component == "images") .loadImages(format)
    else .loadMasks(mask.type)
}

.loadImages <- function(format = c("hdf5", "zarr"))
{
    format <- match.arg(format)
    ## use for now until EH resource is live
    zr <- ZarrExperiment::ZarrRemote(
        endpoint = "https://mghp.osn.xsede.org/",
        bucket = paste0("bir190004-bucket01/TMA11/", format, "/")
    )
    if (identical(format, "zarr"))
        return(zr)
    files <- ZarrExperiment::files(zr)
    ex_files <- setNames(files, basename(files))

    # TODO: check in with CytoImageList on caching to not repeatedly
    #       download from OSN
    h5array_list <- .get_h5_from_files(ex_files)
    CytoImageList::CytoImageList(
        h5array_list,
        on_disk = TRUE,
        h5FilesPath = HDF5Array::getHDF5DumpDir()
    )
}

.loadExpression <- function()
{
    # connect to bucket and get file contents
    zr <- ZarrExperiment::ZarrRemote(
        endpoint = "https://mghp.osn.xsede.org/",
        bucket = "bir190004-bucket01/TMA11/rds/"
    )
    files <- ZarrExperiment::files(zr)

    # pull out individual components of the omics data
    exprs <- .get_rds_from_files("exprs", files)
    cdat <- .get_rds_from_files("coldata", files)
    rdat <- .get_rds_from_files("rowdata", files)
    tissues <- .get_rds_from_files("tissues", files)

    # data reshaping
    scols <- c("x", "y")
    smat <- as.matrix(cdat[,scols])
    rcols <- setdiff(colnames(cdat), scols)
    cdat <- cdat[,rcols]

    # construct SpatialExperiment
    spe <- SpatialExperiment::SpatialExperiment(assay = list(exprs = exprs),
                                                colData = cdat,
                                                rowData = rdat,
                                                spatialCoords = smat)
    return(spe)
}

.loadMasks <- function(mask.type = c("cell", "nucleus"))
{
    mask.type <- match.arg(mask.type)
    zr <- ZarrExperiment::ZarrRemote(
        endpoint = "https://mghp.osn.xsede.org/",
        bucket = paste0("bir190004-bucket01/TMA11/segmentation/")
    )
    files <- ZarrExperiment::files(zr)
}
