# madsdk_init.sh

# Check that MADSDK_ROOT is set

if [[ -z "$MADSDK_ROOT" ]]; then
    echo "madsdk_init.sh: you need to set the MADSDK_ROOT environment variable"
    return 1
fi

# Set paths

export PATH="${MADSDK_ROOT}/bin:${PATH}"
export MANPATH="${MADSDK_ROOT}/share/man:${MANPATH}"

export PGPLOT_DIR="${MADSDK_ROOT}/lib/pgplot"

# Set other environment variables

export MADSDK_VERSION=`${MADSDK_ROOT}/bin/madsdk_version`
export PKG_CONFIG_PATH="${MADSDK_ROOT}/lib/pkgconfig:${PKG_CONFIG_PATH}"
