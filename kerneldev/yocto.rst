Yocto
=====

Yocto is a collection of tools and configurations for building Linux images.

The best resource is the Reference Manual:

    https://docs.yoctoproject.org/ref-manual/index.html

You usually need at least 140 GB of free disk space if you want to work with
yocto...

Overview
--------

The goal of yocto is to build a full Linux distribution. This includes the
toolchain, bootloader, kernel and filesystem image. Yocto is not a particular
tool, it is more of an umbrella project under the Linux Foundation. It uses the
"OpenEmbedded" framework which provides tools and configurations to build Linux.
The tool you use for building is called `BitBake`, and the reference base
distribution you start with is called "poky".

What makes yocto different from other build systems is the use of "layers".
Layers are directories that contain build instructions, such as BSP (Board
Support Package), UI (frameworks like qt), and distro layers (systemd..). You
can create, add, remove and modify layers in your build by editing the
`bblayers.con` file. Openembedded already provides a lot of these for you, and
you can find and share lots of layers online, like the official raspberry pi
layer for example.

File Formats
------------

Yocto uses the following file formats:

* Recipes (`.bb`): describe build instructions for a single package. This includes
  fetching, dependencies, configuration and compilation, output. They can
  inherit from classes (`.bbclass`) via the `inherit` keyword.

* PackageGroups (special `.bb`): often used to group packages together for a FS
  image.

* Classes (`.bbclass`): class definitions to group common functionality. They
  must live under `meta-my-layer/classes/`.

* Configuration (`.conf`): drives the overall behaviour of the build process

* Append files (`.bbappend`): define additional metadata for a similarly names
  `.bb` file, add or override previously set values

* Include files (`.inc`): files which are used with the `include` or `require`
  directive

Source Directory Structure
--------------------------

By convention, a layer's directory starts with `meta-`. Here is an example
layout.

.. code-block:: text

     meta-my-layer/
       README.md
       conf/
         layer.conf
         machine/
           raspberrypi.conf
       recipes-bsp/
       recipes-core/
       recipes-graphics/
       recipes-kernel/
         linux/
           linux-raspberrypi.inc
           linux-raspberrypi-dev.bb

The layer contains a `conf/layer.conf` file which is the base configuration file
which register all the others. We also have a `config/machine/my-machine.conf`
for each machine this layer supports.

The features this layer provides are implemented under recipes. The name of the
recipes directories are standardized. See `reference manual section 5.3`_,
standard names include `recipes-connectivity`, `recipes-core`, `recipes-graphics`, `recipes-kernel`. `recipes-miltimedia` etc.

.. _reference manual section 5.3: https://docs.yoctoproject.org/ref-manual/structure.html#the-openembedded-core-oe-core-metadata-meta

In Yocto, the underscore is the strict delimiter that separates the recipe name
(`PN`) from the recipe version (`PV`). For example, `my-app_1.0.bb` sets `PN` to
`my-app` and `PV` to `1.0`.

To check that a layer is correct:

.. code-block:: bash

   yocto-check-layer /path/to/meta-my-layer

Tasks
-----

Yocto orchestates independent, isolated tasks. Each recipe goes through a
pipeline of tasks. The standardizes tasks can be found on the `reference manual
chapter 7`_, some of them are:

* `do_fetch`
* `do_unpack`
* `do_patch`
* `do_prepare_recipe_sysroot`
* `do_configure`
* `do_compile`
* `do_install`
* `do_package`
* `do_populate_sysroot`
* `do_package_qa`
* `do_package_write_*`
* `do_deploy`
* etc

.. _reference manual chapter 7: https://docs.yoctoproject.org/ref-manual/tasks.html

You define and registers tasks in `.bb`, `.bbclass` or `.inc` files, for
example:

.. code-block:: bash

   do_my_custom_cleanup() {
     # Custom engineering work here
     bbnote "Cleaning up custom artifacts"
   }
   
   addtask my_custom_cleanup after do_compile before do_install

Fragments
---------

`Fragments`_ are build configuration features that can be independently enabled and
disabled using standard tooling.

.. _Fragments: https://docs.yoctoproject.org/ref-manual/fragments.html

Quick Start
-----------

Do this to start a new project:

.. code-block:: bash

    # Setup
    mkdir yocto && cd yocto
    # Install build dependencies
    sudo apt-get install build-essential chrpath cpio debianutils \
                         diffstat file gawk gcc git iputils-ping  \
                         libacl1 locales python3 python3-git      \
                         python3-jinja2 python3-pexpect python3-pip \
                         python3-subunit socat texinfo unzip wget \
                         xz-utils zstd
    # Get bitbake
    git clone https://git.openembedded.org/bitbake

    # Configure
    ./bitbake/bin/bitbake-setup init
    source bitbake-builds/poky-wrynose/build/init-build-env 
    bitbake-config-build enable-fragment core/yocto/root-login-with-empty-password
    bitbake-config-build enable-fragment core/yocto/sstate-mirror-cdn

    # Build a recipe
    # You can build different images:
    # - core-image-minimal: bare essentials
    # - core-image-base: console only with drivers and firmware
    # - core-image-sato: includes X11 and some UI applications
    # - core-image-full-cmdlike: no GUI but lots of cli tools
    bitbake core-image-minimal
    
    runqemu snapshot nographic

Now that you have a linux image, to actually develop an out-of-tree kernel
module, you can use bitbake to generate the cross compilationm environment for
you (or use `devtool`, more on this later):

.. code-block:: bash

    bitbake core-image-minimal -c populate_sdk

This generates a shell script in build/tmp/deploy/sdk/ that you can execute to
generate the sdk.

.. code-block:: bash

    . <sdk_dir>/environment-setup-x86-64-v3-poky-linux

You then develop the module "normally", using a Makefile. To test it, you run a
virtual machine and `scp` the module inside it, or mount a network filesystem,
or something similar. With this you can avoid restarting the image each time.

Once you are done developing, you can integrate it to the image by adding the
module inside the bitbake build system. You do this by creating a new recipe
that uses the module.bbclass. Then to build it with the bitbake toolchain:

.. code-block:: bash

    bitbake my-driver

Here is an index of many yocto layers:

   https://layers.openembedded.org/layerindex/branch/master/layers/

Useful commands:

.. code-block:: bash

  bitbake-config-build list-fragments
  bitbake-layers -h
  bitbake-layers create-layer meta-test
  bitbake-layers show-layers

If you get errors like `ERROR: Fetcher failure for URL:
'git://git.openembedded.org/bitbake...'. Unable to fetch URL from any source.`,
do this:

.. code-block:: bash

    git config --global url."https://git.yoctoproject.org/git/".insteadOf "git://git.yoctoproject.org/"
    git config --global url."https://git.openembedded.org/".insteadOf "git://git.openembedded.org/"

Devtool
-------

We have seen that you can create the toolchain with yocto, and develop the
module with make. To connect these two systems, you can use `devtool`. It does
some setting up for you and it links the module with the yocto toolchain.

To run the following commands you need to have sourced the bitbake environment.

.. code-block:: bash

    # Generate new recipes of the driver
    devtool add <recipe-name> /path/to/driver
    # Or modify existing ones
    devtool modify <recipe-name>

    # Now you can go to the new workspace directory to modify the
    # sources
    cd build/workspace/<recipe-name>/sources

    # Iterative development

    devtool build <recipe-name>
    devtool deploy-target <recipe-name> root@<target-ip>

    # Commit changes
    git add .
    git commit -m "commit message"
    # Update, keep the workspace active
    devtool update-recipe <recipe-name> -a <path to custom layer>
    
    # Cleanup

    # Close the workspace
    devtool finish <recipe-name> meta-custom-project

Kas
---

To setup the entire yocto project in a repeatable way, you can (and should) use
a tool like Kas. It is not only really useful for CI, but also for local
development. You can create a single `project.yml` file that describes your
yocto setup, then enter it with:

.. code-block:: bash

    kas build project.yml
    kas shell project.yml

