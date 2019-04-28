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
	echo "Please visit http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Prerequisites_2 and review the prerequisites required for use of the Mad SDK"
	exit 1
    endif
    rm config.log
    popd > /dev/null
    touch "${MADSDK_ROOT}/etc/check_preq.done"
endif

# Set other environment variables

setenv MESASDK_ROOT $MADSDK_ROOT
setenv MESASDK_VERSION `${MADSDK_ROOT}/bin/madsdk_version`
