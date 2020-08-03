SHELL     = /bin/sh
PLAT      = _GFORTRAN
FORTRAN   = gfortran
OPTS      = -O3 -ffp-contract=off -fPIC -I${DEST_ROOT}/include
DRVOPTS   = -O3 -ffp-contract=off
NOOPT     = -fPIC -I${DEST_ROOT}/include
LOADER    = gfortran
LOADOPTS  =
ARCH      = ar
ARCHFLAGS = cr
RANLIB    = ranlib
BLASLIB   = libblas.a
