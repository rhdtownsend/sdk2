Basic Usage
===========

To use the SDK2, first clone the repository from GitHub:

.. code-block:: console

   $ git clone https://github.com/rhdtownsend/sdk2.git

Set the :envvar:`SDK2_ROOT` environment variable to point to the root directory of the 
repository:

.. code-block:: console
		
   $ export SDK2_ROOT=~/sdk2

Also, set the :envvar:`SDK2_TMP` environment variable to point to a
temporary directory that will be used to build SDKs (if possible,
place this directory on a fast storage device, such as an SSD):

.. code-block:: console
		
   $ export SDK2_TMP=~/sdk2-tmp

Next, choose an appropriate *profile*. The profile determines which SDK
will be built, and for what platform. Current choices include:

``mesasdk-x86_64-macos``
  MESA SDK running on Intel 64-bit OSX (10.10 onward)

``mesasdk-x86_64-linux``
  MESA SDK running on Intel 64-bit Linux

``mesasdk-aarch64-linux``
  MESA SDK running on ARM 64-bit Linux

``madsdk-x86_64-macos``
  Mad SDK running on Intel 64-bit OSX (10.10 onward)

``madsdk-x86_64-linux``
  Mad SDK running on Intel 64-bit Linux

See the :repo:`profile <profile>` directory for the complete set of
profiles (each profile is stored in its own subdirectory; :file:`common`
is a special directory used to store info common to all profiles).

Once you’ve chosen a profile, set the :envvar:`SDK2_PROFILE` environment
variable accordingly, e.g.

.. code-block:: console

   $ export SDK2_PROFILE=mesasdk-x86_64-linux

Finally, set the :envvar:`SDK2_RELEASE` environment variable to the
relase number of the SDK. Convention is to use ``Y.M.N``, where
``Y`` is the two-digit year, ``M`` is the month number, and ``N``
is an index counting upward from ``1`` for each release made
in that month. So, for the third release in November 2020, you would use

.. code-block:: console

   $ export SDK2_RELEASE=20.11.3

With these three environment variables set, you can now build the SDK
via

.. code-block:: console

   $ $SDK2_ROOT/exec/sdk2 all

After some time (typically, an hour or two, depending on the speed of
your system), the SDK2 will complete the build process, and you’ll
have a fresh SDK sitting in the directory
:file:`{$SDK2_TMP}/{$PROFILE_NAME}`. Here, :envvar:`PROFILE_NAME` is
the name of the profile --- ``mesasdk`` for the MESA SDK, and
``madsdk`` for the Mad SDK.
