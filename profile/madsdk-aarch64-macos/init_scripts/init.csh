# madsdk_init.csh

# Check that MADSDK_ROOT is set

if ( ! ${?MADSDK_ROOT} ) then
    echo "madsdk_init.csh: you need to set the MADSDK_ROOT environment variable"
    exit 1
endif

# Set paths

setenv PATH "${MADSDK_ROOT}/bin:${PATH}"
if ( ${?MANPATH} ) then
    setenv MANPATH "${MADSDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${MADSDK_ROOT}/share/man"
endif

setenv PGPLOT_DIR "${MADSDK_ROOT}/lib/pgplot"

# Set other environment variables

setenv MADSDK_VERSION `${MADSDK_ROOT}/bin/madsdk_version`
