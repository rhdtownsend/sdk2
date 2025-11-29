# init.csh

# Check that FOURDSDK_ROOT is set

if ( ! ${?FOURDSDK_ROOT} ) then
    echo "init.csh: you need to set the FOURDSDK_ROOT environment variable"
    exit 1
endif

# Set paths

setenv PATH "${FOURDSDK_ROOT}/bin:${PATH}"
if ( ${?MANPATH} ) then
    setenv MANPATH "${FOURDSDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${FOURDSDK_ROOT}/share/man"
endif

setenv PGPLOT_DIR "${FOURDSDK_ROOT}/lib/pgplot"

# Set other environment variables

setenv FOURDSDK_VERSION `${FOURDSDK_ROOT}/bin/fourdsdk_version`
setenv PKG_CONFIG_PATH "${FOURDSDK_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}"
