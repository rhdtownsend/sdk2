# madsdk_init.csh

# Check that MADSDK_ROOT is set

if ( ! ${?MADSDK_ROOT} ) then
    echo "madsdk_init.csh: you need to set the MADSDK_ROOT environment variable"
    exit 1
endif

# Check architecture

if ( ! -f "${MADSDK_ROOT}/etc/check_arch.done" ) then
    echo "madsdk_init.csh: checking architecture"
    if ( `${MADSDK_ROOT}/bin/madsdk_arch_check` != 'Y' ) then
	echo "madsdk_init.csh: unsupported architecture"
	exit 1
    endif
    touch "${MADSDK_ROOT}/etc/check_arch.done"
endif

# Regenerate headers

if ( ! -f "${MADSDK_ROOT}/etc/regen_headers.done" ) then
    echo "madsdk_init.csh: regenerating headers"
    set mkheaders=`find "$MADSDK_ROOT/" -name mkheaders | head -n 1`
    $mkheaders "$MADSDK_ROOT"
    touch "${MADSDK_ROOT}/etc/regen_headers.done"
endif

# Set paths

setenv PATH "${MADSDK_ROOT}/bin:${PATH}"
if ( ${?MANPATH} ) then
    setenv MANPATH "${MADSDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${MADSDK_ROOT}/share/man"
endif

setenv PGPLOT_DIR "${MADSDK_ROOT}/lib/pgplot"

# Check prerequisites

if ( ! -f "${MADSDK_ROOT}/etc/check_preq.done" ) then
    echo "madsdk_init.csh: checking prerequisites"
    pushd "${MADSDK_ROOT}/etc" > /dev/null
    set missing=`${MADSDK_ROOT}/bin/madsdk_preq_check -q LDFLAGS=-L/opt/X11/lib`
    if ( "$missing" != "" ) then
	echo "madsdk_init.csh: missing prerequisites:"
	echo $missing | awk '{print "  "$0}'
	echo "Please visit http://user.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Prerequisites and review the prerequisites required for use of the Mad SDK"
	popd > /dev/null
	exit 1
    endif
    rm config.log
    popd > /dev/null
    touch "${MADSDK_ROOT}/etc/check_preq.done"
endif

# Make sure valgrid can find itself

setenv VALGRIND_LIB "${MADSDK_ROOT}/lib/valgrind"

# Set other environment variables

setenv MADSDK_VERSION `${MADSDK_ROOT}/bin/madsdk_version`
setenv PKG_CONFIG_PATH "${MADSDK_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}"
