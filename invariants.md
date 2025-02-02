# Invariants

Invariants are one of the most important problem solving techniques. They play a major role in all parts of science. In physics, conservation of energy, momentum, etc is both a powerful device in calculations and an important conceptual tool. Modern chemistry started with [Lavoisier](https://en.wikipedia.org/wiki/Antoine_Lavoisier)'s law of [Conservation of Mass](https://en.wikipedia.org/wiki/Conservation_of_mass). But invariants are not only at the heart of [Stoichiometry](https://en.wikipedia.org/wiki/Stoichiometry) in chemistry but also of many other areas of science. See the concept [Clade](https://en.wikipedia.org/wiki/Clade) in biology for one more example. If you find an important new invariant, you can found a whole new area of science. In mathematics invariants are pervasive and I will try to convince you in a later lecture that while loops and recursion can only be properly understood via invariants.

## Learning Outcomes

Students will be able to answer the following questions.

- How to show that something is impossible?
- How do you show that two elements of an ARS are not equivalent?
- What is meant by a "nice description" of equivalence classes in the exercises?
- What is an invariant?
- How to build more complicated invariants from simpler ones in a compositional way?
- How to describe equivalence relations and partitions by invariants?

## Examples of Invariants

Let us take the example from the first exercise. 

        ab -> ba
        ba -> ab
        aa ->
        b ->
     

What, intuitively, are some invariants? Which properties do not change when we apply the rules?

Here is a list we came up with in class, can you find more?

If we only have 

        ab -> ba
        ba -> ab

invariants are

        length
        number of a's
        number of b's
        number of a's + number of b's
        number of a's = number of b's
        ...

We can split this list into two different groups. In the first group, $P$ is a function to the integers
    
        length
        number of a's
        number of b's
        number of a's + number of b's
        ...

in the second group $P$ is a function to the booleans (truth values)

        number of a's = number of b's
        number of a's + number of b's = length

Notice that one can build larger invariants from smaller ones as we have done in

        number of a's + number of b's

Of particular interest is the invariant $P:A\to\mathbb N\times \mathbb N$ given by the pair

        (number of a's, number of b's)

We will see later that this is a so-called complete invariant. That is, it gives us a complete characterisation of $\stackrel{\ast}{\longleftrightarrow}$ without referring to $\to$.


## Definition of Invariant

**Definition:** A function $P:A\to B$ is an ***invariant*** for an ARS $(A,\to)$ if 
$$ a\to b \ \Longrightarrow \ P(a)=P(b)$$ for all $a,b\in A$.

**Remark:** We call $P$ a property of $(A,\to)$ if $P$ is a function from $A$ to the Booleans.

**Exercise:** Find invariants for 

        ab -> ba
        ba -> ab
        aa ->
        b ->
     


## The Partition Induced by an Invariant

We have seen that every function $f:X\to Y$ induces a [partition](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/SJ1cc-dDr) on $X$. So does an invariant.

Being an invariant of $(A,\to)$ means that the partition induced by $P$ on $A$ is an 'abstraction' of the partition induced by $\to$. Or, in other words, that the partition induced by $\to$ 'refines' the partition induced by $P$.

## Proving the Impossible

How do you prove that there is no path in an ARS that leads from $a$ to $b$?

How do you prove a statement of the form "not $a\stackrel{\ast}{\longrightarrow}b$" or "not $a\stackrel{\ast}{\longleftrightarrow}b$"?

How do you prove that $a$ and $b$ are in different equivalence classes?

Such reasoning typically cannot be done by applying a mechanical method (or algorithm) to the available data. Some insight is often needed. 

But there is a direction in which to look for a solution.

The method says that the required insight can be formulated as  an invariant property $P$ on the $A$ such that
$$P(a)=true \quad\quad P(b)=false$$

**Remark:** If $P$ is an invariant property of the ARS $(A,\to)$ and $P(a)=true$ and $P(b)=false$ then
- not $a\stackrel{\ast}{\longrightarrow}b$
- not $a\stackrel{\ast}{\longleftrightarrow}b$
- $a$ and $b$ are in different equivalence classes


## Building Complete Invariants

We have seen that one can combine invariants. 

Here we show how to build from invariant properties a complete set of invariants, or also, one complete invariant.

**Definition:** An invariant is ***complete*** for an ARS $(A,\to)$ if $$a\stackrel{\ast}{\longleftrightarrow} b \ \ \Longleftrightarrow \ \ P(a)=P(b)$$ for all $a,b\in A$.

**Exercise:** Going back to the introductory example, show that 

        (number of a's, number of b's)
        
is a complete invariant for the ARS given by the schema of rules

        ab -> ba
        ba -> ab


**Example:** Let $(A,\to)$ be the ARS generated by the schemas of rules

        ab -> ba
        ba -> ab
        aa ->
        b -> bbb

There are two invariant properties that come to mind immediately and one more that is needed to distinguish "no b" from "at least one b".

- $P_a(w)\;$ if the number of `a` in $w$ is even
- $P_b(w)\;$ if the number of `b` in $w$ is odd
- $P_1(w)\;$ if the number of `b` in $w$ is $\ge 1$

These three invariants are **complete** in the sense that they disinguish all words that are not equivalent. In other words, if two words agree on $P_a$ and $P_b$ and $P_1$, then they must be equivalent. This can be stated more formally as follows.

- If $P_a(w)=P_a(v)$ and $P_b(w)=P_b(v)$ and $P_1(w)=P_1(v)$, then $w\stackrel{\ast}{\longleftrightarrow}v$.

The converse also holds by virtue of the the properties being invariant.

**Exercise:** 
- Show that the invariants being complete implies that $(A,\to)$ has at most $2^3$ equivalence classes.
- A closer analysis reveals that $P_b(w)=true$ and $P_1(w)=false$ is impossible. (Because $w$ having an odd number of b's and $w$ having no b's cannot hold simultaneously.) How many equivalence classes does $(A,\to)$ have?


We can also combine the three invariants into one invariant
$$P:A\to\mathbb B\times\mathbb B\times\mathbb B$$ 

where $\mathbb B$ stands for the set $\{true,false\}$ of Booleans by defining
$$P(w) = (P_a(w),P_b(w),P_1(w)).$$

**Exercise:** Show that $P$ is complete for $(A,\to)$ in the sense that $w\stackrel{\ast}{\longleftrightarrow}v$ if and only if $P(w)=P(v)$.

[Hint: To show "only if", it is enough to verify that $P$ is an invariant, that is, that for all rules $w\to v$ we have $P(w)=P(v)$. For "if", you need to enumerate all equivalence classes and show that $P$ can distinguish all of them.]


## A Final Challenge

This is a well-known puzzle, don't look up the answer on the internet.

Take a chess board and tiles (or dominoes) that cover exactly two squares of the board. 
- Is it possible to cover the board with the dominoes? If I explained the situation properly the answer should be an obvious yes. [^cover] 
- Now replace the chess board by a board that has 9 rows and columns. What is the answer now? What is the invariant you use to prove your answer? (Hint: First simplify the question and look at a 3x3 board.)
- Now go back to the 8x8 chess board but remove two diagonally opposite squares. Can you cover it with dominoes now?

This puzzle indicates that invariants have a much wider range of  applications than our ARS examples. [^chesspuzzle] Invariants are one of the most powerful problem solving techniques.

**Generalisation as Problem Solving Technique:** Notice how we thought about the chess board puzzle by making it more general. Instead of just looking at one board shape and asking whether it can be tiled, we used at a range of different board shapes. Generalising a problem in such a way is an important problem solving technique. 

## Summary

From a mathematical point of view, an invariant on $A$ is just a function $f:A\to B$. 

As any function, $f$ induces a partition on $A$ given by the equivalence relation $a_1\equiv a_2  \Leftrightarrow f(a_1)=f(a_2)$. 

We sometimes say that $f$ classifies the elements of $a$ up to the equivalence relation. 

In our examples the equivalence relation is the equivalence closure $\stackrel{\ast}{\longleftrightarrow}$ of the relation $\to$ of an ARS $(A,\to)$.

And the function $f:A\to B$ is called an invariant if $a\to b\Rightarrow f(a)=f(b)$, or, equivalently, if $a\stackrel{\ast}{\longleftrightarrow}b \Rightarrow f(a)=f(b)$.



[^cover]: By "covering the board" or "tiling the board" I mean that every square of the board is under exactly one dominoe (tile) and that every dominoe (tile) is over exactly two squares.

[^chesspuzzle]: In fact, one can formulate the chess puzzle as an ARS where an element of the ARS is a configuration of dominoes on the board and the relation $\to$ is the relation given by adding one dominoe to a given configuration.