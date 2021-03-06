% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vwf.R
\name{vwf}
\alias{vwf}
\title{Variable Window Filter}
\usage{
vwf(CHM, winFun, minHeight = NULL, maxWinDiameter = 99,
  minWinNeib = "queen", verbose = FALSE)
}
\arguments{
\item{CHM}{Canopy height model. Either in \link[raster]{raster} format, or a path directing to a raster file. A character vector of multiple paths directing to a
tiled raster dataset can also be used.}

\item{winFun}{function. The function that determines the size of the window at any given location on the
canopy. It should take the value of a given \code{CHM} pixel as its only argument, and return the desired *radius* of
the circular search window when centered on that pixel. Size of the window is in map units.}

\item{minHeight}{numeric. The minimum height value for a \code{CHM} pixel to be considered as a potential treetop. All \code{CHM} pixels beneath
this value will be masked out.}

\item{maxWinDiameter}{numeric. Sets a cap on the maximum window diameter (in cells). If an
improperly calibrated function is set for \code{winFun}, it may produce overly large windows that would perform poorly
and significantly slow processing time. This setting can be disabled by setting to \code{NULL}.}

\item{minWinNeib}{character. Define whether the smallest possible search window (3x3) should use a \code{queen} or
a \code{rook} neighborhood.}

\item{verbose}{logical. Print progress to console if set to \code{TRUE}.}
}
\value{
\link[sp:SpatialPoints]{SpatialPointsDataFrame}. The point locations of detected treetops. The object contains two fields in its
data table: \emph{height} is the height of the tree, as extracted from the \code{CHM}, and \emph{winRadius} is the radius
of the search window when the treetop was detected. Note that \emph{winRadius} does not necessarily correspond to the radius
of the tree's crown.
}
\description{
Implements the variable window filter algorithm (Popescu & Wynne, 2004) for detecting treetops from a canopy height model.
}
\details{
This function uses the resolution of the raster to figure out how many cells the window needs to cover.
This means that the raster value (representing height above ground) and the map unit (represented by the raster's resolution),
need to be in the _same unit_. This can cause issues if the raster is in lat/long, whereby its resolution is in decimal degrees.
}
\examples{
# Set function for determining variable window radius
winFunction <- function(x){x * 0.06 + 0.5}

# Set minimum tree height (treetops below this height will not be detected)
minHgt <- 2

# Detect treetops in demo canopy height model
ttops <- vwf(CHMdemo, winFunction, minHgt)

}
\references{
Popescu, S. C., & Wynne, R. H. (2004). Seeing the trees in the forest. \emph{Photogrammetric Engineering & Remote Sensing, 70}(5), 589-604.
}
\seealso{
\code{\link{mcws}} \code{\link{sp_summarise}}
}
