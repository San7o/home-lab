Gstreamer
=========

Gstreamer is a library / framework to work with multimedia (audio and video).
The key idea of gstreamer is the pipeline, which connects inputs and output of
plugins to other plugins, with a source and a sink at the extremes. You need
this entire machinery to parse multimedia files like `mp4` or data streams. You
can composite streams and make transformations, like OBS does.

Quickstart
----------

Install:

.. code-block:: bash

   sudo apt install gstreamer1.0-tools gstreamer1.0-plugins-base \
                    gstreamer1.0-plugins-good \
                    gstreamer1.0-plugins-bad \
                    gstreamer1.0-plugins-ugly gstreamer1.0-libav

Test:

.. code-block:: bash

   gst-launch-1.0 videotestsrc ! videoconvert ! autovideosink

You can use bindings for different languages like Python or Rust.
