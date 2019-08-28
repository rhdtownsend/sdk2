****
SDK2
****

.. toctree::
   :maxdepth: 2
   :caption: Contents:

Overview
========

The SDK2 (*SDK-squared*) is a software development kit (SDK) for
building software development kits. Amongst other things, it is used to
build the `MESA SDK <http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk>`__ and
`MadSDK <http://www.astro.wisc.edu/~townsend/static.php?ref=mesasdk>`__. It
was developed by the Massive Stars Group at the University of
Wisconsin-Madison.

Basic Usage
===========

To use the SDK2, first clone the repository from GitHub:

.. code-block:: console

   $ git clone https://github.com/rhdtownsend/sdk2.git

Set the `SDK2_ROOT` environment variable to point to the downloaded
files:

.. code-block:: console
		
   $ export SDK2_ROOT=~/sdk2

Next, choose an appropriate *profile*. The profile determines which SDK
will be built, and for what platform. Current choices include:

``mesasdk-x86_64-osx-10.12-10.14``
  MESA SDK running on 64-bit OSX 10.12 (Sierra) through 10.14 (Mojave)

``mesasdk-x86_64-linux``
  MESA SDK running on 64-bit Linux

``madsdk-x86_64-osx-10.12-10.14``
  Mad SDK running on 64-bit OSX 10.12 (Sierra) through 10.14 (Mojave)

``madsdk-x86_64-linux``
  Mad SDK running on 64-bit Linux

See the directory ``$SDK2_ROOT/profiles`` for the full list of profiles
(each profile is stored in its own directory; ``common`` is a special
directory used to store info common to all profiles). Once you’ve chosen
a profile, set the ``SDK2_PROFILE`` environment variable accordingly, e.g.

.. code-block:: console

   $ export SDK2_PROFILE=mesasdk-x86_64-linux

Finally, choose the directory where the SDK will get built by setting
the ``SDK2_DEST_ROOT`` environment variable, e.g.

.. code-block:: console

   $ export SDK2_DEST_ROOT=~/mesasdk

If this variable is not set, then a default value will be chosen based
on the ``DEST_ROOT`` variable defined in
``$SDK2_ROOT/profile/<profile_name>/settings``.

.. admonition:: Warning
      
   Set ``SDK2_DEST_ROOT`` with care, as the build directory will be
   wiped during installation. Bad things can happen, for instance, if
   you set ``SDK2_DEST_ROOT`` to your home directory!

With these three environment variables set, you can now build the SDK
via

.. code-block:: console

   $ $SDK2_ROOT/exec/sdk2 all

After some time (typically, an hour or two, depending on the speed of
your system), the SDK2 will complete the build process, and you’ll have
a fresh SDK sitting in the directory ``$SDK2_DEST_ROOT``.

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
package description (PD) file in the directory ``$SDK2_ROOT/pkg`` (or
a subdirectory thereof). The PD file is written in the Bash scripting
language. Perhaps the best way to learn about PD files is to look at
the existing files within the subdirectories of
``$SDK2_ROOT/pkg``. Briefly, at minimum a PD file must define the
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

Portability
===========

If you’re creating an SDK for use on multiple Linux systems, you should
build the SDK on the oldest system you plan on using. This is to ensure
that the SDK doesn’t end up using functionality in newer releases of
glibc (the GNU shared C library) that is absent on older systems. For
the record, the MESA and Mad SDKs are built in a chroot environment
based on Fedora Core 6, which has a very old version (2.5) of glibc.

Support
=======

The SDK2 project comes without any guarantee of support whatsoever.
However, we would like to hear about any problems you encounter when
using it.
