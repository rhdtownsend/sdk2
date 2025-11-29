# init.sh

# Check that FOURDSDK_ROOT is set

if [[ -z "$FOURDSDK_ROOT" ]]; then
    echo "init.sh: you need to set the FOURDSDK_ROOT environment variable"
    return 1
fi

# Set paths

export PATH="${FOURDSDK_ROOT}/bin:${PATH}"
export MANPATH="${FOURDSDK_ROOT}/share/man:${MANPATH}"

export PGPLOT_DIR="${FOURDSDK_ROOT}/lib/pgplot"

# Set other environment variables

export FOURDSDK_VERSION=`${FOURDSDK_ROOT}/bin/fourdsdk_version`
export PKG_CONFIG_PATH="${FOURDSDK_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}"
