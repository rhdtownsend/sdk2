# fourdsdk_init.csh

# Check that FOURDSDK_ROOT is set

if ( ! ${?FOURDSDK_ROOT} ) then
    echo "fourdsdk_init.csh: you need to set the FOURDSDK_ROOT environment variable"
    exit 1
endif

# Check architecture

if ( ! -f "${FOURDSDK_ROOT}/etc/check_arch.done" ) then
    echo "fourdsdk_init.csh: checking architecture"
    if ( `${FOURDSDK_ROOT}/bin/fourdsdk_arch_check` != 'Y' ) then
	echo "fourdsdk_init.csh: unsupported architecture"
	exit 1
    endif
    touch "${FOURDSDK_ROOT}/etc/check_arch.done"
endif

# Regenerate headers

if ( ! -f "${FOURDSDK_ROOT}/etc/regen_headers.done" ) then
    echo "fourdsdk_init.csh: regenerating headers"
    set mkheaders=`find "$FOURDSDK_ROOT/" -name mkheaders | head -n 1`
    $mkheaders "$FOURDSDK_ROOT"
    touch "${FOURDSDK_ROOT}/etc/regen_headers.done"
endif

# Set paths

setenv PATH "${FOURDSDK_ROOT}/bin:${PATH}"
if ( ${?MANPATH} ) then
    setenv MANPATH "${FOURDSDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${FOURDSDK_ROOT}/share/man"
endif

setenv PGPLOT_DIR "${FOURDSDK_ROOT}/lib/pgplot"

# Check prerequisites

if ( ! -f "${FOURDSDK_ROOT}/etc/check_preq.done" ) then
    echo "fourdsdk_init.csh: checking prerequisites"
    pushd "${FOURDSDK_ROOT}/etc" > /dev/null
    set missing=`${FOURDSDK_ROOT}/bin/fourdsdk_preq_check -q LDFLAGS=-L/opt/X11/lib`
    if ( "$missing" != "" ) then
	echo "fourdsdk_init.csh: missing prerequisites:"
	echo $missing | awk '{print "  "$0}'
	echo "Please visit http://www.astro.wisc.edu/~townsend/static.php?ref=fourdsdk#Prerequisites_2 and review the prerequisites required for use of the FOURD SDK"
        popd > /dev/null
	exit 1
    endif
    rm config.log
    popd > /dev/null
    touch "${FOURDSDK_ROOT}/etc/check_preq.done"
endif

# Make sure valgrid can find itself

setenv VALGRIND_LIB "${FOURDSDK_ROOT}/lib/valgrind"

# Set other environment variables

setenv FOURDSDK_VERSION `${FOURDSDK_ROOT}/bin/fourdsdk_version`
