Post Quantum Safety
===================

There is a lot of bullshit information online about post-quantum algorithms.
Corporate blog posts, academic materials, AI generated websites, and other
completely useless things which will just waste your time.

The reality is that to be "post quantum safe" you as a sysadmin have to update
openssl to a version 3.5+, make sure your services and infrastructure supports
it, and enforce TLS 1.3+ in your services from their respective configuration
files.
