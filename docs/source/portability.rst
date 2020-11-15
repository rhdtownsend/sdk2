Portability
===========

If you’re creating an SDK for use on multiple Linux systems, you
should build the SDK on the oldest system you plan on using. This is
to ensure that the SDK doesn’t end up using functionality in newer
releases of glibc (the GNU shared C library) that is absent on older
systems. For the record, the MESA and Mad SDKs are built in a Docker
container based on CentOS 5.11. To build the image for this container,
use the :file:`{$SDK2_ROOT}/docker/create_docker_image` script; and to
run the container, use the
:file:`{$SDK2_ROOT}/docker/run_docker_container` script.
