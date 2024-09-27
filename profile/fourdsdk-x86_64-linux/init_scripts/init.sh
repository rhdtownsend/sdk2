# fourdsdk_init.sh

# Check that FOURDSDK_ROOT is set

if [[ -z "$FOURDSDK_ROOT" ]]; then
    echo "fourdsdk_init.sh: you need to set the FOURDSDK_ROOT environment variable"
    return 1
fi

# Check architecture

if [ ! -f "${FOURDSDK_ROOT}/etc/check_arch.done" ]; then
    echo "fourdsdk_init.sh: checking architecture"
    if [ `${FOURDSDK_ROOT}/bin/fourdsdk_arch_check` != 'Y' ]; then
	echo "fourdsdk_init.sh: unsupported architecture"
	return 1
    fi
    touch "${FOURDSDK_ROOT}/etc/check_arch.done"
fi

# Regenerate headers

if [ ! -f "${FOURDSDK_ROOT}/etc/regen_headers.done" ]; then
    echo "fourdsdk_init.sh: regenerating headers"
    mkheaders=$(find "$FOURDSDK_ROOT/" -name mkheaders | head -n 1)
    $mkheaders "$FOURDSDK_ROOT"
    touch "${FOURDSDK_ROOT}/etc/regen_headers.done"
fi

# Set paths

export PATH="${FOURDSDK_ROOT}/bin:${PATH}"
export MANPATH="${FOURDSDK_ROOT}/share/man:${MANPATH}"

export PGPLOT_DIR="${FOURDSDK_ROOT}/lib/pgplot"

# Check prerequisites

if [ ! -f "${FOURDSDK_ROOT}/etc/check_preq.done" ]; then
    echo "fourdsdk_init.sh: checking prerequisites"
    pushd "${FOURDSDK_ROOT}/etc" > /dev/null
    missing=$(${FOURDSDK_ROOT}/bin/fourdsdk_preq_check -q LDFLAGS=-L/opt/X11/lib)
    if [ -n "$missing" ]; then
	echo "fourdsdk_init.sh: missing prerequisites:"
	echo $missing | awk '{print "  "$0}'
	echo "Please visit http://www.astro.wisc.edu/~townsend/static.php?ref=fourdsdk#Prerequisites_2 and review the prerequisites required for use of the FOURD SDK"
	popd > /dev/null
	return 1
    fi
    rm config.log
    popd > /dev/null
    touch "${FOURDSDK_ROOT}/etc/check_preq.done"
fi

# Make sure valgrid can find itself

export VALGRIND_LIB="${FOURDSDK_ROOT}/lib/valgrind"

# Set other environment variables

export FOURDSDK_VERSION=`${FOURDSDK_ROOT}/bin/fourdsdk_version`
