Customization
=============

Changing Packages
-----------------

To change which packages are built for a given profile, edit the list
of packages given in the file
``$SDK2_ROOT/profile/<profile_name>/packages``. Lines can be commented
out using the # symbol.

Adding Profiles
---------------

To add a profile, simply copy one of the existing profiles in
``$SDK2_ROOT/profile`` and edit the files
``$SDK2_ROOT/profile/<profile_name>/settings`` and
``$SDK2_ROOT/profile/<profile_name>/packages`` as necessary.

Adding Packages
---------------

To add a package (for subsequent listing in
``$SDK2_ROOT/profile/<profile_name>/packages``), you need to create a
package description (PD) file in the directory ``$SDK2_ROOT/package`` (or
a subdirectory thereof). The PD file is written in the Bash scripting
language. Perhaps the best way to learn about PD files is to look at
the existing files within the subdirectories of
``$SDK2_ROOT/package``. Briefly, at minimum a PD file must define the
following variables:

``SRC_FILE``
  Name of file containing source code for package (must
  exist in ``$SDK2_ROOT/src`` directory, or on the server with the
  URL prefix given by the ``PROFILE_URL`` profile variable)

``SRC_DIR``
  Name of directory to unpack source code into (typically,
  the same as the package name)

Additionally, the PD file must define a Bash function ``build()`` which
contains the commands necessary to build the package. It may also define
functions ``unpack()`` and ``install()``, which handle unpacking the
source code and installing the package; if these are not defined, then
defaults are used (see the script ``$SDK2_ROOT/exec/sdk2`` for details).
