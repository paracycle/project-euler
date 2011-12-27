Problem 12
----------

 > The sequence of triangle numbers is generated by adding the natural numbers.
 > So the seventh triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The
 > first ten terms would be:
 >
 > 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
 >
 > The factors of the seventh triangle number 28 are:
 >
 > 1, 2, 4, 7, 14, 28
 >
 > This is the first triangle number to have over five divisors. What is the
 > value of the first triangle number to have over five hundred divisors?

An infinite sequence of triangle numbers is a delight to define in Haskell.
This is a more refined approach than that used for the fibonacci sequence in
problem two.

> triangles = 1:(zipWith (+) triangles [2..])

The prime factorization algorithm from problem three is reused here, though
rather than naively testing all numbers it uses the `primes` generator from
problem seven to reduce the number of tests required.

> primeFactors = primeFactorsFromCandidates primes

The number of divisors a number has can be calculated by multiplying the powers
of each prime factor plus one. For example, the prime factors of 28 are
|2^2 + 7^1| therefore the number of divisors is |(2+1) * (1+1) = 6|.

> numFactors = foldl1 (*) . map ((+ 1) . length) . group . primeFactors

A reasonable lower bound such as |500 * 500| could be specified for the
triangle numbers, but it makes a neglible difference to the running time of the
search.

> euler12 n = head [x | x <- drop 1 triangles, numFactors x > n]

> tests12 =
>   [ "#12 given"    ~: 28       ~=? euler12 5
>   , "#12 problems" ~: 76576500 ~=? euler12 500
>   ]