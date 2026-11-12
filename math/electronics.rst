Electronics
===========

Charge
------

Charge is a fundamental property of matter, which is made out of
fermions including electrons. An electron has charge :math:`e =
-1,602*10^{-14}`. Charge in all matter is quantized to be multiples of `e`.

We denote charge with the letter `Q` or sometimes `q`. We measure charge in
Coulomb `C`.

Electric Current
----------------

*Electric current* is the total charge that passes through some cross-sectional
area *A* per unit time. If :math:`\Delta Q` is the amount of charge passing
through an area in a time interval :math:`\Delta t`, then the average current
:math:`I_{ave}` is defined as:

.. math::

   I_{ave} = \frac{\Delta Q}{\Delta t}

If the current changes over time, we define the *instantaneous current*
:math:`I` by tracing the limits as :math:`\Delta t \rightarrow 0`, so that the
current is the instantaneous rate at which charge passes through an area:

.. math::

   I =^{def} \lim_{\Delta t \rightarrow 0} \frac{\Delta Q}{\Delta t} =
   \frac{d Q}{d t}

We measure current as coulombs per second, also called Amperes `A` where
:math:`1 A = \frac{1 C}{1 s}`.

Notice that the Coulomb number of an electron is negative! Does that mean that
:math:`I` represents a negative flow of electrons? To make sense of this, we can
interpret, by convention, that the current flows the opposite way as the
electrons movement.

Voltage
-------

To get electrical current to flow from one point to another, a *voltage* must
exist between the two points. A voltage placed across a conductor gives rise to
an *electromotive force* (EMF) that is responsible for giving all *free
electrons* within the conductor a push.

Voltage or sometimes called "potential difference" or just "potential", but note
that this is not the same thing as "potential energy". Think about the idea of
"electrical pressure": electrons further from the source of pumped-in electrons
have low potential energy relative to the electrons that are closer. The voltage
represents the difference in potential energy of a charge.

Voltage is defines as:

.. math::

   \Delta V = \frac{\Delta U}{Q}

It is measured in Volts `V` where :math:`1 V = \frac{1 joule}{1 C}`.

This difference depends on where we set the extremes. Usually its value depends
on the transformation of energy to heat or light.

You can think about voltage with the classic example of *water flow in a pipe*.

Generalized Power Law
---------------------

Since Power is defined as :math:`P = \frac{d W}{d t}`, from the definition of
voltage it follows that:

.. math::

   P = \frac{d W}{d t} = \frac{d VQ}{d t} = d V I

Ohm's Law
---------

Free electrons in a copper wire at room temperature undergo frequent collisions
with other electrons, lattice ions, and impurities withing the lattice that
limit their forward motion. We associate these microscopic mechanisms that
impede electron flow with electrical resistance.

We define Resistance as:

.. math::

   R \equiv \frac{V}{I}

We measure it in Ohms :math:`\Omega = \frac{1 V}{1 A}`.

Note that Ohm's law isn't really a law, but rather an empirical statement about
the behaviour of materials. In fact, there are some materials for which Ohm's
law actually doesn't work. Materials that follow Ohm's law are called *ohmic
materials*.

If we assume a perfect resistor (100% ohmic in nature) we can substitute Ohm's
law into generalized power equation:

.. math::

   P = VI = V ( \frac{V}{R} ) = \frac{V^2}{R} \\
   P = VI = I (RI) = I^2 R

Resistivity and Conductivity
----------------------------

The resistance of a conducting wire of a given material varies with its shape:
doubling the length of a wire doubles the resistance, doubling the
cross-sectional area has the opposite effect.

To explain how a material's "chemistry" affects its resistance, regardless of
the dimensions of the material, we adopt the concept of resistivity. We define
Resistivity as:

.. math::

   \rho = R \frac{A}{L}

Where :math:`A` is the cross sectional area, :math:`L` is the length of a wire,
and :math:`R` is the overall resistance of the material, as measured across its
length.

We define conductivity as :math:`\sigma = \frac{1}{\rho}`, which represents how
"good" something is at passing current. The units of conductivity are Siemens
:math:`S`.

Then it follows that:

.. math::

   V = IR = \rho \frac{L}{A} I

Different materials have different conductivity.

An important feature of resistivity (or conductivity) is its temperature
dependency. Generally, within a certain temperature range, the resistivity for a
large number of metals obeys the following equation:

.. math::

   \rho = \rho_0 [ 1 + \alpha (T - T_0 ) ]

where :math:`\rho` is the calculated resistivity based on a set reference
resistivity :math:`\rho_0` and temperature :math:`T_0`. Alpha :math:`\alpha` is
called the *temperature coefficient of resistivity.

Example resistivity of some materials:

* Pure water: :math:`2.5 * 10^5`

* Salt water: :math:`0.2`

* Human skin: :math: `5.0 * 10^5`

* Air: considered an insulator since it is fairly void of free electrons.
  However, air often contains concentrations of positive and negative airborne
  ions, such as oxigen and nitrogen, which rapidly attracts polar molecules.

* Vacuum: considered a perfect insulator.

At the quantum level, different materials have different restistivity because
electrons stay in quantized, discrete values. If there is a big gap between the
possible energy levels, then it requires a lot of energy to move from one level
to the other. Semiconductors have a small gap between a band and the next.
