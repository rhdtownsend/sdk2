# mesasdk_init.sh

# Check that MESASDK_ROOT is set

if [[ -z "$MESASDK_ROOT" ]]; then
    echo "mesasdk_init.sh: you need to set the MESASDK_ROOT environment variable"
    return 1
fi

# Set paths

export PATH="${MESASDK_ROOT}/bin:${PATH}"
export MANPATH="${MESASDK_ROOT}/share/man:${MANPATH}"

export PGPLOT_DIR="${MESASDK_ROOT}/lib/pgplot"

# Set other environment variables

export MESASDK_VERSION=`${MESASDK_ROOT}/bin/mesasdk_version`
