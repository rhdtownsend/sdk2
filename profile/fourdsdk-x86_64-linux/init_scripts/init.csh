# mesasdk_init.csh

# Check that MESASDK_ROOT is set

if ( ! ${?MESASDK_ROOT} ) then
    echo "mesasdk_init.csh: you need to set the MESASDK_ROOT environment variable"
    exit 1
endif

# Check architecture

if ( ! -f "${MESASDK_ROOT}/etc/check_arch.done" ) then
    echo "mesasdk_init.csh: checking architecture"
    if ( `${MESASDK_ROOT}/bin/mesasdk_arch_check` != 'Y' ) then
	echo "mesasdk_init.csh: unsupported architecture"
	exit 1
    endif
    touch "${MESASDK_ROOT}/etc/check_arch.done"
endif

# Regenerate headers

if ( ! -f "${MESASDK_ROOT}/etc/regen_headers.done" ) then
    echo "mesasdk_init.csh: regenerating headers"
    set mkheaders=`find "$MESASDK_ROOT/" -name mkheaders | head -n 1`
    $mkheaders "$MESASDK_ROOT"
    touch "${MESASDK_ROOT}/etc/regen_headers.done"
endif

# Set paths

setenv PATH "${MESASDK_ROOT}/bin:${PATH}"
if ( ${?MANPATH} ) then
    setenv MANPATH "${MESASDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${MESASDK_ROOT}/share/man"
endif

setenv PGPLOT_DIR "${MESASDK_ROOT}/lib/pgplot"

# Check prerequisites

if ( ! -f "${MESASDK_ROOT}/etc/check_preq.done" ) then
    echo "mesasdk_init.csh: checking prerequisites"
    pushd "${MESASDK_ROOT}/etc" > /dev/null
    set missing=`${MESASDK_ROOT}/bin/mesasdk_preq_check -q LDFLAGS=-L/opt/X11/lib`
    if ( "$missing" != "" ) then
	echo "mesasdk_init.csh: missing prerequisites:"
	echo $missing | awk '{print "  "$0}'
	echo "Please visit http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Prerequisites_2 and review the prerequisites required for use of the MESA SDK"
        popd > /dev/null
	exit 1
    endif
    rm config.log
    popd > /dev/null
    touch "${MESASDK_ROOT}/etc/check_preq.done"
endif

# Make sure valgrid can find itself

setenv VALGRIND_LIB "${MESASDK_ROOT}/lib/valgrind"

# Set other environment variables

setenv MESASDK_VERSION `${MESASDK_ROOT}/bin/mesasdk_version`
