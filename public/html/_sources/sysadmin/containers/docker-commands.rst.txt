Docker commands
===============

Delete all containers, including their volumes:

.. code-block:: bash

   docker rm -vf $(docker ps -aq)

Remove all images (after removing the containers):

.. code-block:: bash

   docker rmi -f $(docker images -aq)

Disable automatic restart of a container:

.. code-block:: bash

   docker update --restart=no <MY-CONTAINER-ID>
