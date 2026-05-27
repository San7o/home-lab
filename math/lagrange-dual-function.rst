The Lagrange dual Funciton
==========================

In this post we will delve into the realm of optimization and in particular we
will look at the Lagrange dual function. I will be using the book "Convex
Optimization" by Stephen Boyd and Lieven Vandenberghe as my reference.

Optimization problems
---------------------

A mathematical optimization problem, or just optimization problem, has
the form:

.. math::

    minimize\ f_0(x)

subject to:

.. math::

    `f_i(x)\le b_i,\ i=1, ..., m
    `h_i(x) = 0,\ i=1, ..., p

Here the vector :math:`x=(x_1, ..., x_n)` is the optimization variable of the
problem, the function :math:`f_0: \mathbb{R}^n \rightarrow \mathbb{R}` is the
objective function, the functions :math:`f_i, h_i: \mathbb{R}^n \rightarrow
\mathbb{R},\ i=1, ..., m` are the constraint functions, and the constants
:math:`b_i, ..., b_m` are the limits, or bounds, of the constraints. A vector
:math:`x*` is called optimal, or a solution of the problem, if it has the
smallest objective value among all vectors that satisfy the constraints.

The optimal value $x*$ of the above problem, also referred to as $p*$,
is defined as:

.. math::

    x* = inf\{ f_0(x) | f_i(x) \le 0,\ i=1, ..., m,\ h_i(x)=0,\ i=1, ..., p \}

The optimal value for a maximization problem would be the greater
value instead.

The types of optimization problems can be divided into:

- `linear programming` where the objective and all constraint functions are
  linear meaning they satisfy the equality :math:`f_i(\alpha x+ \beta y) =
  \alpha f(x) + \beta f(y)` for all :math:`x, y \in \mathbb{R}^n` and all
  :math:`\alpha, \beta \in \mathbb{R}`. There is no simple analytical formula
  for the solution of a linear program, but there are a variety of very
  effective methods including Dantzig's simplex method and interior-point
  methods.

- `convex optimization` where the objective and constraint functions are convex
  meaning they satisfy the equation :math:`f_i(\alpha x+ \beta y) \le \alpha
  f(x) + \beta f(y)` for all :math:`x, y \in \mathbb{R}^n` and all :math:`\alpha
  , \beta \in \mathbb{R},\ \alpha + \beta = 1, \alpha \ge 0, \beta \ge 0`. We
  say a function `f` is `concave` if `-f` is convex. If just the objective
  function is convex but not the constraints, the problem is called
  `quasiconvex`. Similar to linear programming, in general there is no
  analytical formula for solving these problems, but there are effective methods
  to do so like interior-point methods. Fortunately, those are quite efficient
  for computers and we are able to solve them quickly.

- `non linear optimization` for problems with non linear objective or
  constraints which further divides into *local* optimization (finding a local
  best solution) or `global` optimization which is usually slower in terms of
  computation time. There is no general efficient solution.

The Lagrangian
--------------

Consider a minimization problem as defined above, we assume the domain
:math:`D=\prod_{i=1}^m dom(f_i) \cap \prod_{i=1}^p dom(h_i)` is non empty and
denote the optimal value by `p*`.

The idea is to account for the constraints by augmenting the objective function
with a weighted sum of the constraints. We define the `Lagrangian` :math:`L:\
\mathbb{R}^n \times \mathbb{R}^m \times \mathbb{R}^p \rightarrow \mathbb{R}` as:

.. math::

    L(x, \lambda, \nu) = f_0(x) + \sum_{i=1}^m \lambda_i f_i(x) + \sum_{i=1}^p \nu_i h_i(x)

We refer to :math:`\lambda_i` as the `Lagrange multiplier` associated with the
i-th inequality constraint :math:`f_i\le 0` and :math:`\nu_i` as the Lagrange
multiplier associated with the i-th equality constraint :math:`h_i(x)=0`. The
vectors :math:`\lambda` and :math:`\nu` are called the dual variables or
Lagrange multiplier vectors associated with the problem.

We define the `Lagrange dual function` :math:`g: \mathbb{R}^m \times
\mathbb{R}^p \rightarrow \mathbb{R}` as the minimum value of the Lagrangian over
`x` associated to the previous problem: for :math:`\lambda \in \mathbb{R}^n,\
\nu \in \mathbb{R}^p`,

.. math::

    g(\lambda , \nu) = inf_{x\in D} L(x, \lambda , \nu ) = inf_{x\in D}(f_0(x) + \sum_{i=1}^m \lambda_i f_i(x) + \sum_{i=1}^p \nu_i h_i(x))

It is easy to see that :math:`g(\lambda , \nu)` is the lower bound of the
optimal value `p*`, in fact the sum of :math:`f_i(x)` is negative and the sum of
:math:`h_i(x)` is zero for valid solutions, hence we are subtracting from
:math:`f_0(x)` and we are looking for the vectors :math:`\lambda` and
:math:`\nu` that give the smaller valid value (or the greater subtraction),
which is the lower bound.

The dual problem
----------------

We showed that :math:`g(\lambda , \nu)` is the lower bound of the optimal value
`p*`. But to find the optimal value we need to find the highest lower bound.
Hence, we need to maximize the dual function, meaning we need to solve the
problem:

.. math::

    maximize g(\lambda , \nu)

subject to:

.. math::

    \lambda \ge 0

This problem is called the Lagrange dual problem associated with the original
minimization problem. We refer to :math:`(\lambda *, \nu *)` as dual optimal or
optimal Lagrange multipliers if they are optimal for the problem.

The Lagrange dual problem is a `convex optimization problem`, since the
objective to be maximized is concave (because "the dual function is the
point-wise infium of a family of affine functions", gl) and the constraint is
convex (indeed the constraint :math:`f(x) < \lambda_i` has function
:math:`f(x)=0` which satisfies the definition of convex).  This is always the
case whether or not the original problem (sometimes referred to as primal
problem) is convex.

Convex optimization problems
----------------------------

Let's now consider convex optimization problems. A fundamental property of
convex optimization problems is that any locally optimal point is also globally
optimal, this can be proven my contradiction.

The convex optimization problem is called a quadratic program if the objective
function is convex and quadratic, and the constraint functions are affine
(linear). A quadratic program can be expressed in the form:

.. math::

    minimize\ \frac{1}{2}x^TPx + q^Tx+r

subject to:

.. math::

    Gx \le h
    Ax=b

where `P` is a symmetric positive matrix where :math:`x^TPx` is always positive.

There are many techniques to solve these kind of problems. If the problem is
unconstrained, you can use backtracking (move in steps and reduce the step size
incrementally), gradient descent, steepest descent or newton's method. If it is
also very simple, you can calculate the first and second derivatives and equal
them to 0. In equality constrained problems you can use more sophisticated
versions of the Newton step or using barriers.  In general, you can use the
interior-point method.
