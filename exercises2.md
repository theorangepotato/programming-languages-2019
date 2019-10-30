# Exercises: Program Verification, Hoare Logic, Loop Invariants

## Euclidean Algorithm

(One of the oldest algorithms still in use)

We present the simplest version of Euclid's algorithm in three different formalisms. 

In each case prove partial correctness by using an invariant and prove termination by using a measure function.

#### With a while loop

    function gcd(a, b)
        while a ≠ b 
            if a > b
                a := a − b; 
            else
                b := b − a; 
        return a;

#### In Haskell

    gcd :: Int -> Int -> Int
    gcd x y | x > y = gcd (x-y) y
            | x < y = gcd x (y-x)
            | otherwise = x

#### As a term rewriting system

Let  $(\mathbb N\times \mathbb N,\to)$ be defined as follows:

    (a,b) -> (a-b,b)  if a>b
    (a,b) -> (a,b-a)  if b>a


## Partial correcteness of while loops

The next two exercises are similar to the ones in the lecture notes. They should be easy, once you worked through the notes.

**Exercise:** What do the following two programs compute? What pre and postconditions can be used to formalise this? Find a loop invariant and use it to prove the partial correctness of this program.

1)

        while (i < 100 ) do
            y := y+x
            i := i+1  
        done

2)

        while  (i < k ) do
            i := i+1 
            y := y*i
        done


The next exercise is essentially the same as the one above on Euclid's algorithm. But this time you also need to point out which rule of Hoare logic is used to justify which step in the reasoning.

**Exercise:** Given positive integers $n,a$, we write $n|a$ for $n$ divides $a$.

Using the rules of Hoare logic, show that $\{n|a \ \wedge \ n|b\}$ is an invariant of

    while a ≠ b 
        if a > b
            a := a − b; 
        else
            b := b − a; 

Conclude that the algorithm computes the greates common divisor of $a$ and $b$.

