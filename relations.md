# Discrete Mathematics: Relations

So far we talked a lot about "rewriting to normal form" as a model of computation. We also discussed how to give meaning to formal languages by mapping them to a semantics. All these notions can be connected, clarified and formalised with the help of a little discrete maths, which we will review now.  [^discretemath]


 
In fact, we only need to understand the concept of  reflexive and transitive (and symmetric) closure of a relation. So lets get started.

## Sets
I assume that we all understand what a set is, so feel free to jump to the [next section](https://hackmd.io/s/B1gOX4lO7#Relations). 

### The elementship-relation

The basic statement about a set $A$ we can make is that it contains an element $a$, which is written as

$$a\in A.$$

### The subset-relation

We also need to be able to say that $A$ is a subset of $B$, which can be written in set-theoretic notation as

$$A\subseteq B \quad \stackrel{\rm def}{\Leftrightarrow}\quad \forall a \ (a\in A \ \Rightarrow \ a\in B).$$

### The "curly bracket notation"

We also need to review different ways of defining sets. The simplest one is just to list the elements of a set as in

$$\{1,2,3\}$$

To illustrate the notation reviewed so far, we have $1\in\{1,2,3\}$ and $\{1,2,3\}\subseteq\mathbb N$, where 

$$\mathbb N = \{0,1,2,3,4,\ldots\}$$

is the standard notation for the natural numbers. 

### Inductive definitions

Above, I am taking $\mathbb N$ for granted, but we can also define it ourselves by saying that $0\in\mathbb N$ and if $n\in\mathbb N$ then also $n+1\in\mathbb N$. Note that this definition avoids the $\ldots$ and instead uses only two rules. We say then say that $\mathbb N$ is the smallest set *closed* under the rules. This style of defining sets is called definition by induction and we will see more about this in a [later lecture](https://hackmd.io/s/H1panO_um).

Defining infinite sets inductively is very common and we have seen another example of this when we defined the language `exp` of arithmetic expressions. 

### Set-comprehension
Another way of defining sets is called *comprehension*. A definition by comprehension has the form

$$A \ \stackrel{\rm def}{=} \ \{ \ldots \mid \ldots \}$$

For example, we may define the set of even numbers as

$$Even \ \stackrel{\rm def}{=} \ \{ n\in\mathbb N \mid \exists m\in\mathbb N\,.\, 2\cdot m = n \}.$$

Here $\;\exists m\,.\,\ldots\;$ is short for "there is $m$ such that $\dots$"

**Exercise:** Define the set of odd numbers in the same style.

### Cartesian Product

We can also use comprehension to define the so-called *cartesian product*  [^cartesian]

$$A\times B \ \stackrel{\rm def}{=} \ \{ (a,b) \mid a\in A, b\in B \}$$

which is just the set of pairs that can be built by taking elements of $A$ in the first component and elements of $B$ in the second.

**Example:** Fractions $n/m$ are pairs $(n,m)$ where we use the special notation "$/$" just to indicate that we want to think of this pair of numbers as a fraction and not, eg, as the coordinates of a point in the plane.

**More Notation** (not so important now, but useful later):  If in the above definition we have $A=B$ then we may abbreviate $A\times A$ as $A^2$. Similarly, we abbreviate $(A\times A)\times A$, usually written just as $A\times A\times A$, by $A^3$. This notation extends to $A^n$ for any $n\in\mathbb N$. The set $A^0$ is called the empty product and has exactly one element, often called the empty word. The empty word has not standardized notation and one may find different symbols for it such as $()$ and $[]$ and $\langle\rangle$ and $0$ and $\epsilon$ (epsilon) and $\lambda$ (lambda). The set $A^0$ always has exactly one element, whatever $A$ is. For this reason, $A^0$ is sometimes written just as $1$. We then obtain the equation $A^0=1$, which is similar to a familiar equation for numbers, namely that $a^0=1$ for all numbers $a$ (possibly restricted to $a\not=0$).

## Relations

If you are familiar with databases then a relation is really very nuch the same as a table in a database. For our purposes, we actually only need tables that have two columns (attributes).

Anyway, we don't need to think about databases at all. The mathematical definition is that a **relation**[^relation] $R$ on a set $A$ is a subset of $A\times A$, in symbols

$$R\subseteq A\times A.$$

**Notation:** By convention, we also write $aRb$ instead of $(a,b)\in R$, or also $R(a,b)$, which in turn may be abbreviated to $Rab$. When drawing pictures we also write this as

$$a\stackrel{R}{\longrightarrow} b$$
 
which we abbreviate to 

$$a\stackrel{}{\longrightarrow} b$$

if there is only one relation discussed at that moment.

**Remark:** Later we will take $R$ to be the relation of "one-step computation", or rewriting, as we called it, but for now we make no assumptions on $A$ and $R$.

We need to know what it means for a relation to be reflexive, symmetric, and transitive.

**Defininition:** Assume that $R\subseteq A\times A$.

- is ***reflexive*** if 
$$ xRx $$
for all $x\in A$.

- is ***symmetric*** if 
$$ xRy  \ \Rightarrow \ yRx$$
for all $x,y\in A$.

- is ***transitive*** if 
$$ xRy  \ \& \ yRz \ \Rightarrow \ xRz$$
for all $x,y,z\in A$.

**Example:** 
- The $<$-relation on numbers is transitivie but neither reflexive nor symmetric.
- The $\le$-relation on numbers is reflexive and transitive but not symmetric.
- A relation that is symmetric and transitive but not necessarily reflexive is called a [partial equivalence relation](https://en.wikipedia.org/wiki/Partial_equivalence_relation). The linked article contains some references to applications to the semantics of programming languages.
- The relation $a\equiv b\ ({\rm mod} \  n)$ of [modular arithmetic](https://en.wikipedia.org/wiki/Modular_arithmetic) is reflexive, transitive and symmetric.
- The relation of "being siblings" is symmetric but not reflexive (hence also not transitive).

**Exercise:** Make up your own examples. Family relationshiops are a great source. Try parent, child, ancestor, etc and check each of them for reflexivity, transtivity and symmetry.

## Equivalence Relations

Without any doubt, equivalence relations and equivalence classes are one of the most important concepts in all of mathematics. It was discovered surprisingly late, as far as I know by Dedekind around 1880. [^Dedekind]

**Definition:** An  ***equivalence relation*** is a relation that is reflexive, transitive and symmetric. 

If $R$ is an equivalence relation on $A$, then every $R$ partitions $A$ into equivalence classes. For $a\in A$, the **equivalence class** of $a$ is denoted by $[a]$ or $[a]_R$ and defined as 

$$[a]_R = \{b\in A \mid aRb\}$$

To say that the equivalence classes partition $A$ is to say that equivalences classes are disjoint and cover all of $A$. We will come back to this below.

We can now form the set of equivalence classes which is written as $A/R$ and defined as

$$A/R \ \stackrel{\rm def}{=} \ \{[a]_R \mid a\in A \}$$

**Remark (Partition):** Equivalence relations on $A$ are in bijective correspondence with partitions of $A$. A ***partition*** of $A$ is a set of subsets of $A$ that are pairwise disjoint and cover all of $A$.[^partition] Given an equivalence relation, its equivalence classes form a partition. Conversely, every partition defines the equivalence relation of "being in the same part".

**Remark (Equivalence relation/partition of a function):** Every function $f:A\to B$ defines an equivalence relation via $aRa' \Leftrightarrow f(a)=f(a')$. In other words, $f$ partitions $A$ into the subsets of elements that are identified by $f$.  

**Example:** Equality is an equivalence relation. In fact, equality is the smallest equivalence relation. There is also a largest equivalence relation (which is it?).

**Notation and Terminology:** If $R$ is an equivalence relation it is often written as $\equiv$ or $\approx$ or any other symbol that emphasises the analogy with equality. The set $A/R$ is also called $A$ ***modulo*** $R$ or *$A$ quotiented by $R$* or ****the quotient of*** $A$ by $R$*. 

**Example:** On the integers $\mathbb Z$, the relation $a\equiv b\ ({\rm mod} \  n)$ of congruence modulo $n$ is an equivalence relation. The set of equivalence classes is denoted by $\mathbb Z/n\mathbb Z$. The operation of "dividing by $n\mathbb Z$" has some properties similar to division, see eg the [Chinese Remainder Theorem](https://en.wikipedia.org/wiki/Chinese_remainder_theorem)  which explains some of the terminology just introduced.



**Example of fractions and integers:** Two famous examples of sets that are sets of equivalence classes are the integers and the fractions. 
- The set of non-negative fractions $\mathbb Q$ is a set of equivalence classes. The set $A$ is $\mathbb N\times\mathbb N_+$ where $N_+$ is the positive integers and the equivalence relation in question is the one which takes care of the fact that, eg, 1/2 = 2/4.
- How would you implement integers $\mathbb Z$ if you had only natural numbers? One way is to define the integers as equivalence classes where $A=\mathbb N\times\mathbb N$ and $(m,n)R(k,l)$ if $m+l=k+n$. (**Exercise:** Can you figure out why this works? Can you find a rewriting system in which these equivalence classes have nice normal forms? How would you define addition, etc on these integers?)

The following exercise is crucial to understand equivalence classes.

**Exercise:** Show that every equivalence relation $R$ on $A$ partitions $A$, that is,
- A is the union of its equivalence classes, symbolically, $A = \bigcup_{a\in A} A/R$
- any two different equivalence classes are disjoint, ie, $[a]\not=[b] \Rightarrow [a]\cap[b]=\emptyset$

## Transitive Closure

We are almost done. Before we can relate the last lecture about syntax and semantics to the idea of computation as rewriting to normal form, we still need to define the notions of transitive closure and equivalence closure.

The idea of transitive closure is easily explained. Transitive closure is an operation on relations. Given a relation $R$, two elements $a,b$ are in the transitive closure $R^+$ of $R$ if there is a sequence of elements $a_1,\ldots a_n$ such that

$$ aRa_1, a_1Ra_2,\ldots a_n R b$$

or, shorter,

$$ aRa_1Ra_2\ldots a_n R b$$

There is an elegant way to define the transitive closure $R^+$ that does not require the use of $\ldots$.

**Definition:** Assume that $R\subseteq A×A$. 
- The transitive closure $R^+$ of $R$ is the smallest transitive relation containing $R$.
- The reflexive and transitive closure $R^*$ of $R$ is the smallest reflexive and transitive relation containing $R$.
- The equivalence closure $\equiv_R$ of $R$ is the smallest reflexive, symmetric, transitive relation containing $R$.

**Remark:** Let us now think of $R$ as a relation of "one-step computation". To indicate this intention we write now $\to$ instead of $R$ and $\stackrel{\ast}{\to}$ for the reflexive and transitive closure and $\stackrel{\ast}{\leftrightarrow}$ for the equivalence closure. The  good situation we are interested in, and which we will explore in the next lecture, is where $\stackrel{\ast}{\leftrightarrow}$ reflects the  equations that hold on the semantic side and where $\stackrel{\ast}{\to}$ allows us to rewrite any element into a unique normal form. We then can compute with equivalence classes, even though they are sets, by instead computing with the normal forms they contain.

**Exercise:** Make sense of the last sentence, by reviewing the laws of fractions you learned at school. Explain in our terminology why you were asked at school to cancel fractions.

## Functions

As I said, I assume that the notion of a function is familiar, either form high-school or from a first semester discrete maths course. But we can review some terminology quickly.

To begin at the beginning, a function $f:A\to B$ is often defined to be a relation $f\subseteq A\times B = \{(a,b)\mid a\in A,b\in B\}$, which, moreover, is 
- *single-valued*, that is, $(a,b)\in f$ and $(a,b')\in f$ implies $b=b'$ and is 
- *total*, that is, for all $a\in A$ there is $b\in B$ such that $(a,b)\in f$. 

These two properties together say that for all $a\in A$ there is one and only one related $b\in B$ and this is the element that is, by convention, written as $f(a)$. 

We will also need further properties that functions may have. A function is called
- ***injective***, or *one-to-one*, if $f(a)=f(a')$ implies that $a=a'$,
- ***surjective***, or *onto*, if for all $b\in B$ there is $a\in A$ such that $f(a)=b$,
- ***bijective***, if it is injective and surjective.

If we have a bijection between two sets, then the two sets can be considered equal up to the names of their elements. Intuitively, a bijection is like a dictionary that relates every word in one language to exactly one corresponding word in the other.

We will also need that a function 
$$f:A\to B$$ 

can be extended to subsets of $A$ and $B$. We define
- the ***direct image of $X\subseteq A$ under $f$*** as $\ \ f[X]\ \stackrel{\rm def}{=}\ \{f(x) \mid x\in X\}$
- the ***inverse image of $Y\subseteq B$ under $f$*** as $\ \ f^{-1}(Y)\ \stackrel{\rm def}{=}\ \{a\in A \mid f(a)\in Y\}$ 

**Remark (Partition of a function):** Every function $f:A\to B$ defines a partition $f^{-1}(b)_{b\in B}$ on $A$. The sets $f^{-1}(b)$ are sometimes known as the fibres over $b$.


[^discretemath]: I assume that students had a one semester course on discrete maths. But in many discrete-maths-texts relations only appear in the "second semester" part. For example in the widely used book "Discrete Mathematics and Its Application" by Rosen, relations only start on page 374. Btw, the book could be a good place to review some discrete maths.

[^cartesian]: This is called "cartesian" product in honour of Descartes, who, in his "Geometry", about which we talked already, invented the represenation of points in the plane by $x$ and $y$-coordinates, that is, the representation of points as elements of $\mathbb R\times \mathbb R$.

[^relation]: It is common to abbreviate $A\times A$ by $A^2$. If we need to emphasise that $R$ is a susbset of  $A^2$ as opposed to a subset of $A^n$ for some other $n\in\mathbb N$, we call $R$ a "2-ary" relation or a **binary relation**.

[^Dedekind]: More information is available in this article on [The Early Development of Set Theory](https://plato.stanford.edu/entries/settheory-early/#Emer). By the way, Dedekind was also the guy who defined integers and rationals as equivalence classes. You are asked to work on this in [this exercise](https://hackmd.io/_Ut9-vaCSsOpn9UFPf6agw#Exercise-Fractions).

[^partition]: In symbolic notaion, a partition of $A$ is a collection $(A_i)_{i\in I}$ of subsets of $A$ such that $i\not=j \ \Rightarrow A_i\cap A_j=\emptyset$ and $\bigcup_{i\in I} A_i = A$.