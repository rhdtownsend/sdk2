# mesasdk_init.sh

# Check that MESASDK_ROOT is set

if [[ -z "$MESASDK_ROOT" ]]; then
    echo "mesasdk_init.sh: you need to set the MESASDK_ROOT environment variable"
    return 1
fi

# Check architecture

if [ ! -f "${MESASDK_ROOT}/etc/check_arch.done" ]; then
    echo "mesasdk_init.sh: checking architecture"
    if [ `${MESASDK_ROOT}/bin/mesasdk_arch_check` != 'Y' ]; then
	echo "mesasdk_init.sh: unsupported architecture"
	return 1
    fi
    touch "${MESASDK_ROOT}/etc/check_arch.done"
fi

# Regenerate headers

if [ ! -f "${MESASDK_ROOT}/etc/regen_headers.done" ]; then
    echo "mesasdk_init.sh: regenerating headers"
    mkheaders=$(find "$MESASDK_ROOT/" -name mkheaders | head -n 1)
    $mkheaders "$MESASDK_ROOT"
    touch "${MESASDK_ROOT}/etc/regen_headers.done"
fi

# Set paths

export PATH="${MESASDK_ROOT}/bin:${PATH}"
export MANPATH="${MESASDK_ROOT}/share/man:${MANPATH}"

export PGPLOT_DIR="${MESASDK_ROOT}/lib/pgplot"

# Check prerequisites

if [ ! -f "${MESASDK_ROOT}/etc/check_preq.done" ]; then
    echo "mesasdk_init.sh: checking prerequisites"
    pushd "${MESASDK_ROOT}/etc" > /dev/null
    missing=$(${MESASDK_ROOT}/bin/mesasdk_preq_check -q LDFLAGS=-L/opt/X11/lib)
    if [ -n "$missing" ]; then
	echo "mesasdk_init.sh: missing prerequisites:"
	echo $missing | awk '{print "  "$0}'
	echo "Please visit http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk#Prerequisites_2 and review the prerequisites required for use of the MESA SDK"
	return 1
    fi
    rm config.log
    popd > /dev/null
    touch "${MESASDK_ROOT}/etc/check_preq.done"
fi

# Set other environment variables

export MESASDK_VERSION=`${MESASDK_ROOT}/bin/mesasdk_version`
