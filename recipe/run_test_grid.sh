#!/bin/bash
set -ex

export PKG_PATH=$(python -c "import pybacktrack; import os; print(os.path.dirname(pybacktrack.__file__))")

test -f "${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc" || (echo "Grid file not found at ${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc" && exit 1)

ncdump -h "${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc"

gmt grdinfo "${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc"

echo "Sampling: normal"
echo "150 -30" | gmt grdtrack -G"${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc"

#echo "Sampling: z"
#echo "150 -30" | gmt grdtrack -G"${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc?z"

#echo "Sampling: gdal"
#echo "150 -30" | gmt grdtrack -G"${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc=gd"

echo "Sampling: netcdf"
echo "150 -30" | gmt grdtrack -G"${PKG_PATH}/bundle_data/sediment_thickness/GlobSed.nc=nf"
