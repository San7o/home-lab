Eigenvalues and Eigenvectors
============================

Today we will look at Eigenvalues and Eigenvectors in linear algebra. I will use
the great book "Algebra Lineare" by Marco Abate as my reference.

Eigenvectors are an important theoretical and practical topic, they are is used
also in machine learning and are often used as the preferred axis for rotations
or other transformations.

Definition
----------

Let :math:`T: V\rightarrow V` be an endomorphism (maps from a space to itself)
of a vector space `V`. A vector :math:`v_0 \ne 0` of `V` is an eigenvector of
`T` with respect to the *eigenvalue* :math:`\lambda` if:

.. math::

    T(v_0)=\lambda v_0

The set of *eigenvalues* is called the spectre of `T`. If :math:`\lambda \in \
space(T)` then the set:

.. math::

    V_{\lambda} = \{ v\in T\ \|\ T(v)=\lambda v \}

is called *eigenspace*.

Notice that from the definition follows:

.. math::

    Tv_0 - \lambda v_0 = 0
    (T - \lambda I)v_0 = 0

Therefore :math:`(T-\lambda I)=0` (is singular) and it's determinant is 0.

.. math::

    det(T-\lambda I)=0

This is very useful to compute the eigenvalues. Once you have those, and T, you
can use them in the definition to get the eigenspace and the eigenvectors.

