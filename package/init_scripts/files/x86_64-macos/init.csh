# mesasdk_init.csh

# Check that MESASDK_ROOT is set

if ( ! ${?MESASDK_ROOT} ) then
    echo "mesasdk_init.csh: you need to set the MESASDK_ROOT environment variable"
    exit 1
endif

# Set paths

setenv PATH "${MESASDK_ROOT}/bin:${PATH}"
if ( ${?MANPATH} ) then
    setenv MANPATH "${MESASDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${MESASDK_ROOT}/share/man"
endif

setenv PGPLOT_DIR "${MESASDK_ROOT}/lib/pgplot"

# Set other environment variables

setenv MESASDK_VERSION `${MESASDK_ROOT}/bin/mesasdk_version`
