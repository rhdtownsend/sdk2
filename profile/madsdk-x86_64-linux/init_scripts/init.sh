# madsdk_init.sh

# Check that MADSDK_ROOT is set

if [[ -z "$MADSDK_ROOT" ]]; then
    echo "madsdk_init.sh: you need to set the MADSDK_ROOT environment variable"
    return 1
fi

# Check architecture

if [ ! -f "${MADSDK_ROOT}/etc/check_arch.done" ]; then
    echo "madsdk_init.sh: checking architecture"
    if [ `${MADSDK_ROOT}/bin/madsdk_arch_check` != 'Y' ]; then
	echo "madsdk_init.sh: unsupported architecture"
	return 1
    fi
    touch "${MADSDK_ROOT}/etc/check_arch.done"
fi

# Regenerate headers

if [ ! -f "${MADSDK_ROOT}/etc/regen_headers.done" ]; then
    echo "madsdk_init.sh: regenerating headers"
    mkheaders=$(find "$MADSDK_ROOT/" -name mkheaders | head -n 1)
    $mkheaders "$MADSDK_ROOT"
    touch "${MADSDK_ROOT}/etc/regen_headers.done"
fi

# Set paths

export PATH="${MADSDK_ROOT}/bin:${PATH}"
export MANPATH="${MADSDK_ROOT}/share/man:${MANPATH}"

export PGPLOT_DIR="${MADSDK_ROOT}/lib/pgplot"

# Check prerequisites

if [ ! -f "${MADSDK_ROOT}/etc/check_preq.done" ]; then
    echo "madsdk_init.sh: checking prerequisites"
    pushd "${MADSDK_ROOT}/etc" > /dev/null
    missing=$(${MADSDK_ROOT}/bin/madsdk_preq_check -q LDFLAGS=-L/opt/X11/lib)
    if [ -n "$missing" ]; then
	echo "madsdk_init.sh: missing prerequisites:"
	echo $missing | awk '{print "  "$0}'
	echo "Please visit http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Prerequisites and review the prerequisites required for use of the Mad SDK"
	return 1
    fi
    rm config.log
    popd > /dev/null
    touch "${MADSDK_ROOT}/etc/check_preq.done"
fi

# Make sure valgrid can find itself

export VALGRIND_LIB="${MADSDK_ROOT}/lib/valgrind"

# Set other environment variables

export MESASDK_ROOT=$MADSDK_ROOT
export MESASDK_VERSION=`${MADSDK_ROOT}/bin/madsdk_version`
