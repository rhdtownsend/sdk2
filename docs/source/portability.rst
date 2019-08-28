Portability
===========

If you’re creating an SDK for use on multiple Linux systems, you should
build the SDK on the oldest system you plan on using. This is to ensure
that the SDK doesn’t end up using functionality in newer releases of
glibc (the GNU shared C library) that is absent on older systems. For
the record, the MESA and Mad SDKs are built in a chroot environment
based on Fedora Core 6, which has a very old version (2.5) of glibc.
