Intersection of two (straight) lines
====================================

Existence of intersection?
--------------------------

-   The lines should be non-parallel, non-vertical and non-coincidental.
-   If they do intersect, it’s at a [unique
    point](https://brilliant.org/wiki/linear-equations-intersection-of-lines/).
    At the point where the two lines intersect, both lines have the same
    y coordinates.

Find point of intersection
--------------------------

Given the equations of the two lines, the point of intersection ((x, y)
coordinates) of two lines can be found by simultaneously solving the two
line equations—using substitution method or linear algebra.

Suppose the equations of the two lines are

$$\\begin{align}
y = ax + c \\qquad(1) \\\\
y = bx + d \\qquad(2)
\\end{align}$$

where `a` and `b` are the `slopes` and `c` and `d` are the
`y-intercepts` of the two lines.

We can rewrite them as

$$\\begin{align}
y-ax = c\\\\
y-bx = d
\\end{align}$$

In a matrix form, we can write the system as below.

$$
\\overbrace{\\begin{bmatrix}
1 & -a \\\\
1 & -b 
\\end{bmatrix}}^A 
\\underbrace{\\begin{pmatrix} 
y \\\\ x 
\\end{pmatrix}}\_X = \\underbrace{\\begin{bmatrix} c \\\\ d\\end{bmatrix}}\_D
$$

Then, we can solve for **X** by pre-multiplying both sides by
**A**<sup> **−** **1**</sup>:
$$\\mathbf{X} = \\begin{pmatrix}y^\* \\\\x^\*\\end{pmatrix} = \\mathbf{A}^{-1} \\mathbf{d}$$
given det **A** ≠ 0, **A** should be **non-singular**.

For a 2x2 matrix, the *determinant* is the difference between the
product of the diagonal elements, i.e., product of the main diagonal
elements subtracted off the product of the `secondary diagonal`
elements. Thus, in our case $det A = (1 \\dot (-b) - (-a) \\dot 1)$
which simplifies to *a* − *b*.

Next, given the non-singularity of A, its inverse is:

$$
\\mathbf{A}^{-1} = \\frac{1}{\\det A}\\begin{bmatrix}
-b & a \\\\
-1 & 1 
\\end{bmatrix}.
$$

Then,

$$\\begin{gather}
\\begin{aligned}
\\mathbf{X} 
&= \\frac{1}{a-b}\\begin{bmatrix}
-b & a \\\\
-1 & 1 
\\end{bmatrix} \\begin{bmatrix} c \\\\ d\\end{bmatrix} \\\\
&= \\frac{1}{a-b}\\begin{bmatrix}
-bc + ad \\\\
-c + d  
\\end{bmatrix}\\\\
&= \\begin{bmatrix}
\\frac{ad - bc}{a-b} \\\\
\\frac{d -c}{a-b}
\\end{bmatrix}
\\end{aligned}
\\end{gather}$$

Therefore, the point of intersection is $x = \\frac{d -c}{a-b}$ and
$y = \\frac{ad - bc}{a-b}$ or $y=a{\\frac {d-c}{a-b}}+c$ by (1).

``` r
source("intersection.R")
source("plot_intersection.R")
```

Note if *a* = *b* it means the two lines are parallel, hence no
intersection. If *c* ≠ *d* as well, the lines are different and there is
no intersection, otherwise the two lines are identical.

``` r
plot_intersection(2, 1, 1, 2)
```

<img src="solve-linear-equations_files/figure-markdown_github/unnamed-chunk-1-1.png" alt="Intersection of Two Lines: when $a \ne b$"  />
<p class="caption">
Figure 1: Intersection of Two Lines: when *a* ≠ *b*
</p>

Let’s try to answer a question asked on
[twitter](#%20https://twitter.com/PaoloAPalma/status/1317336137996881927?s=20)

``` r
eqns <- list(
  main.fun = function(x) abs(2 * x) + 4,
  A = function(x) x - 2,
  B = function(x) x + 3,
  C = function(x) 2 * x - 2,
  D = function(x) 2 * x + 3,
  E = function(x) 3 * x - 2
)

params = data.frame(slope = c(1, 1, 2, 2, 3), 
                    yintercept = c(-2, 3, -2, 3, -2))
```

``` r
pp = ggplot() + 
  geom_function(fun = eqns$main.fun) + 
  lims(x = c(-20, 20))

pp + 
  lapply(1:5, function(i) geom_function(fun = eqns[-1][[i]], col = i))
```

![](solve-linear-equations_files/figure-markdown_github/plotting-1.png)

``` r
# solution
Map(lines_intersect, 
a = 2, c = 4, 
b = params$slope, 
d = params$yintercept) # case 1: y = 2x + 4, if x>0
```

    ## System is exactly singular: det A = 0.

    ## No intersection!

    ## System is exactly singular: det A = 0.

    ## No intersection!

    ## [[1]]
    ## [1] -6 -8
    ## 
    ## [[2]]
    ## [1] -1  2
    ## 
    ## [[3]]
    ## NULL
    ## 
    ## [[4]]
    ## NULL
    ## 
    ## [[5]]
    ## [1]  6 16

``` r
Map(lines_intersect, a = -2, c = 4, 
b = params$slope, 
d = params$yintercept) # case 2: y = -2x=4, if x<0
```

    ## [[1]]
    ## [1] 2 0
    ## 
    ## [[2]]
    ## [1] 0.3333333 3.3333333
    ## 
    ## [[3]]
    ## [1] 1.5 1.0
    ## 
    ## [[4]]
    ## [1] 0.25 3.50
    ## 
    ## [[5]]
    ## [1] 1.2 1.6

``` r
# main equation: y = abs(2*x) + 4
## case 1
a = 2; c = 4
## case 2
a. = -2; c. = 4

# choice A -> y = x-2
b = 1; d = -2 
plot_intersection(a, c, b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-1.png)

``` r
plot_intersection(a., c., b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-2.png)

``` r
# choice B -> y = x + 3
b = 1; d = 3  
plot_intersection(a, c, b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-3.png)

``` r
plot_intersection(a., c., b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-4.png)

``` r
# C -> y = 2 * x - 2
b = 2; d = -2 
plot_intersection(a, c, b, d, gg = pp)
```

    ## System is exactly singular: det A = 0.
    ## No intersection!

![](solve-linear-equations_files/figure-markdown_github/solution-5.png)

``` r
plot_intersection(a., c., b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-6.png)

``` r
# D -> y = 2 * x + 3
b = 2; d = 3   
plot_intersection(a, c, b, d, gg = pp)
```

    ## System is exactly singular: det A = 0.
    ## No intersection!

![](solve-linear-equations_files/figure-markdown_github/solution-7.png)

``` r
plot_intersection(a., c., b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-8.png)

``` r
# E y = 3 * x - 2 
b = 3; d = -2  
plot_intersection(a, c, b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-9.png)

``` r
plot_intersection(a., c., b, d, gg = pp)
```

![](solve-linear-equations_files/figure-markdown_github/solution-10.png)
