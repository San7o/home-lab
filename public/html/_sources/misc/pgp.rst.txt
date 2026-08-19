Pgp
===

Pgp (Pretty Good Privacy) is a cryptographic system used for encrypting,
decrypting, and signing data.

To create your own pgp key pair, run the following command:

.. code-block:: bash

   gpg --full-generate-key

You can export your public key with:

.. code-block:: bash

   gpg --armor --export "your_email@example.com"

To backup your key pair you can create the following files:

.. code-block:: bash

   gpg --armor --export-secret-keys "your_email@example.com" > private-key-backup.asc
   gpg --armor --export "your_email@example.com" > public-key-backup.asc
   gpg --export-ownertrust > ownertrust-backup.txt

And import them with:

.. code-block:: bash

   gpg --import public-key-backup.asc
   gpg --import private-key-backup.asc
   gpg --import-ownertrust ownertrust-backup.txt
