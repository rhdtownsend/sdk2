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

``mesasdk-x86_64-osx-10.10-10.14``
  MESA SDK running on 64-bit OSX 10.10 (Yosemite) through 10.14 (Mojave)

``mesasdk-x86_64-linux``
  MESA SDK running on 64-bit Linux

``madsdk-x86_64-osx-10.10-10.14``
  Mad SDK running on 64-bit OSX 10.10 (Yosemite) through 10.14 (Mojave)

``madsdk-x86_64-linux``
  Mad SDK running on 64-bit Linux

See the :repo:`profile <profile>` directory for the complete set of
profiles (each profile is stored in its own subdirectory; ``common``
is a special directory used to store info common to all profiles).

Once you’ve chosen a profile, set the ``SDK2_PROFILE`` environment
variable accordingly, e.g.

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
