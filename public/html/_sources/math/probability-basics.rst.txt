Probability Basics
==================

In this document I will summarize the core ideas of probability theory.

Basic Definitions
-----------------

There are two main interpretations of what probability is. The first one is to
think of a probability as the frequency of a certain event occurring. If a coin
has 0.5 probability of landing heads, then we expect the coin to land heads
about half of the time. The other interpretation views probability as a quantity
of uncertainty or ignorance about something, this is more related to information
rather than repeated trials. In the coin example, here we mean that the coin is
equally likely to land heads or tails on the next toss.

We define the following terms:

- :math:`\Omega` as the sample space, it is composed of independent events
- :math:`A\subset 2^{\Omega}` is a subset of the sample space of a problem
- :math:`a\in A` is an event

Probability Function
--------------------

A function `P` is a probability function if:

- `P` is non negative: :math:`P(A)\ge 0\ \forall A\in \Omega`
- `P` is normalized: :math:`P(\Omega)=1`
- `P` is :math:`\sigma` -additive: if :math:`A_i \cap A_j \ne \emptyset,\ A\in \Omega` then  :math:`P(\cup_i A_i)=\sum_i P(A_i)`

From set theory, you can demonstrate that the following holds:

.. math::

    P(A\cup B) = P(A) + P(B) - P(A\cap B)

Bayes Theorem
-------------

Bayes theorem is a foundamental theorem that correlates the probabilty of
variables given another variable. First, we define :math:`P(A|H)` as the
probability of A given H, and we can calculate this as:

.. math::

    P(A|H)=\frac{P(A\cap H)}{P(H)},\ P(H)>0

The Bayes theorem states:

.. math::

    P(A_i|B)=\frac{P(B|A_i)P(A_i)}{\sum_j P(B|A_j)P(A_j)}=\frac{P(B|A_i)P(A_i)}{P(B)}

Stochastic Independence
-----------------------

Events :math:`A\in \Omega` are said to be independent if:

.. math::

    P(A_{i1} \cap A_{i2} \cap ... \cap A_{ik}) = \prod_{j=1}^k P(A_{ij}) = P(A_{i1})\cdot P(A_{i2})\cdot ...\cdot P(A_{ik})

The same applies to bivaraite functions:

.. math::

    P_{X, Y}(x, y) = P_X(x)\cdot P_Y(y),\ \forall (x, y)\in R_x \times R_y

moreover:

.. math::

    P_{X|Y}(x|y) = P_X(x)
    P_{Y|X}(y|x) = P_Y(y)

Distribution Function
---------------------

A function `F` is a probability distribution function if:

- `F` never decreases
- `F` is right-continuous
- `F` always has a left-limit
- :math:`\lim_{x\to - \infty} f(x)=0`
- :math:`\lim_{x\to\infty}f(x)=1`

Then:

.. math::

    P((a, b])=^{(discrete)}F(b)-F(a^-) =^{(continuous)} \int_a^b f(x)dx

Where `f(x)` is called density when if `F\in C^1` in the continuous formulation.

Random Variable
---------------

Random variables are a mathematical formalization used to model quantities which
depend on random events, it lets us quantify random events so that we can make
probability calculations.

More formally, a random variable is a function that maps event in some sample
space :math:`\Omega` to a set of outcomes in measurable space `E`, which is often
:math:`\mathbb{R}`.

.. math::

    X:\Omega \to E

The probability that $X$ takes on a value in a measurable set :math:`S\subseteq
E` is written as

.. math::

    P(X\in S) = P(\{ \omega \in \Omega \ \|\ X(\omega)\in S \})

Notable Random Variables
------------------------

Some random variables appear more than others, so a few of them are worthy of
their name. You will see those everywhere in nature, economics, populations, and
more.

Bernoulli:

.. math::

    X(\omega)=\{0, 1\}

Rademacher:

.. math::

    Y(\omega)=\{ -1, 1 \}

Binomial :math:`X\sim Bin(n, p)`:

.. math::

    P_x(J)=\{ \binom{n}{k}p^J(1-p)^{n-J},\ j=1...n\ \|\ 0\ otherwise \}

Poissont :math:`X\sim Pois(\lambda)`:

.. math::

    P_x\{\frac{\lambda^xe^{-\lambda}}{x!}, n\in \mathbb{N}\cup \{ 0 \}\ \|\ 0\ otherwise\}

Geometric:

.. math::

    P(y)=\{ p(1-p)^{y-1},\ y\in \mathbb{N}\ \|\ 0\ otherwise \}

Uniform :math:`X\sim Unif[a, b]`:

.. math::

    f_x(x)=\{ \frac{1}{b-a},\ x\in [a, b]\ \|\ 0\ otherwise \}

Normal (Gaussian) :math:`X\sim N(\mu , \sigma^2)`:

.. math::

    f_x(x) = \frac{1}{\sqrt{2\pi \sigma^2}}e^{-\frac{1}{2}\frac{(x-\mu)^2}{\sigma^2}}

Exponential :math:`X\sim Exp(\lambda)`:

.. math::

    f_x(x)=\lambda e^{\lambda x}\mathbb{1}(x>0)

Expected Value
--------------

We define the expected value in a discrete space as:

.. math::

    \mathbb{E}(x) = \sum_{x\in R_x} xp_x(x)

and in the continuous:

.. math::

    \mathbb{E}(x)=\int_{-\infty}^{\infty} xf_x(x)dx

The expected value is a linear function:

.. math::

    E(aX+b) = a\mathbb{E}(x)+b
    E(g(x))=\sum_{x\in R_x} g(x)p_x(x)

Known formulas for notable random variables:

- Bernoulli: :math:`\mathbb{E}(x)=p`
- Binomial: :math:`\mathbb{E}(x)=np`
- Geometric: :math:`\mathbb{E}(x)= \frac{1}{p}-1`
- Normal: :math:`\mathbb{E}(x)=\mu`
- Exponential: :math:`\mathbb{E}(x)=\frac{1}{\lambda}`
- Poisson: :math:`\mathbb{E}(x)=\lambda`

Variance
--------

We define variance as:

.. math::

    \mathbb{V}ar(x)=\mathbb{E}(x^2)-\mathbb{E}(x)^2 = \mathbb{E}[(x-\mathbb{E}[x])^2]

Moreover:

.. math::

    \mathbb{V}ar(x)=\mathbb{E}(\mathbb{V}ar(x|y)) + \mathbb{V}ar(\mathbb{E}(x|y))

Covariance
----------

We define the covariance as:

.. math::

    \mathbb{C}ov(x, y)=\mathbb{E}((x-\mathbb{E}(x))(y-\mathbb{E}(y)))=\mathbb{E}(XY)-\mathbb{E}(x)\mathbb{E}(y)

Standardization
---------------

.. math::

    z=g(x)=\frac{x-\mathbb{E}(x)}{\sqrt{\mathbb{V}ar(x)}}

After this transformation:

- :math:`\mathbb{E}(z)=0`
- :math:`\mathbb{V}ar(z)=1`

The opposite can be achieved:

.. math::

    x=\sigma z + \mu

Markov Inequality
-----------------

Let `Y` be a random variable non negative, then :math:`\forall a>0`:

.. math::

    P(Y\ge a)\le \frac{\mathbb{E}(y)}{a}

Chebyshev Inequality
--------------------

Let `Y` be a random variable, :math:`\mu = \mathbb{E}(y)`,
:math:`\sigma^2=\mathbb{V}ar(y)`, then :math:`\forall \epsilon > 0`:

.. math::

    P(\|Y-\mu\| \ge \epsilon)\le \frac{\sigma^2}{\epsilon^2}

