# Abstract Reduction Systems 1 : Examples

(in this lecture, we will learn the basic maths that is needed for our first model of computation; this material will be examinable in the "midterm" and the December exam)

## Models of computation

What is most fundamental feature shared by all models of computation?

All models of computation, I would say, must have a set $A$ with a binary relation that models one-step computations. 

This is sometimes called Abstract Reduction System.[^ARS] Other names that may be used for the same mathematical structure include graph, dynamical system, transition system, automaton, ... [^automaton]

**Definition:** An abstract reduction system (ARS) is a set $A$ together with a relation ${\to}\subseteq A\times A$.

This doesnt look very interesting at first sight. Just a relation on a set? What can we do with this? Certainly not all binary relations are models of computation, so we will be interested in the following in properties of binary relations that are interesting for relations that can be thought of as modelling some form of one-step comptuations.

First note that the elements of $A$ can be all kind of different things: numbers, strings, lists, multisets, trees, ... all kind of data ... I am working with a graduate student on an example where $A$ is a set of diagrams ... but $A$ could also contain the memory of a computer or the cells of a cellular automata.

Second, there are a number of important properties that we can express about ARSs in general. We already have seen the notion of a normal form, which is defined purely in terms of $(A,\to)$. Indeed, $a\in A$ is a normal form if there is no $(a,b)\in{\to}$, or, if there is no $a\to b$. Let us make a list of some interesting questions to ask (precise definitions follow the examples):

- which elements are in normal form?
- which elements reduce to normal form?
- are normal forms unique?
- which elements are joinable?
- which elements are equivalent?
- is the reduction system confluent?
- does reduction terminate?

**Terminology:** If $a\to b$ in an ARS, we say that $a$ *reduces* to $b$. This is a way of speaking that indicates that we think of $a\to b$ as a one-step computation that, as in equational reasoning, simplifies, or reduces, $a$ to $b$. But this expectation is not part of the definition of ARSs, which include examples where $b$ is "more complicated" than $a$. 

## Examples

The examples below are not necessarily meant to illustrate the idea of an ARS as a model of computation. Rather they serve at illustrating what is captured by the definitions as they are. While it is not too much of an exaggeration to say that all models of computations are ARSs, the notion of an ARS is too abstract to make sure that all ARSs are models of computation. We will later refine ARSs to TRSs and then to lambda-calculus to get to a narrower class of mathematical models which can be considered satisfactory answers to the question "What is computation?".

- $A$ is the set of integers $> 1$ and  $m\to n$ is defined to hold if $m>n$ and $n$ divides $m$.
  - normal forms are primes
  - normal forms are not unique
  - two numbers are joinable iff they share a prime number (iff they are not relatively prime)
  - all numbers are equivalent
  - not confluent
  - terminating

- A is the set of finite lists (aka words) over $\{a,b\}$, $wbav\to wabv$
  - normal forms are sorted lists (if we say that $a$ comes before $b$)
  - normal forms are unique
  - two lists are joinable iff they are equivalent iff they have the numbers of $a$'s and $b$'s
  - confluent
  - terminating

- A is the set of multisets[^multisets] over $\{a,b\}$, $aa\to a$, $bb\to a$, $ab\to b$, $ba\to b$
  - normal form?
  - joinable iff ?
  - equivalent iff both an odd number of b's or both an even numbers of b's (CHECK)
  - not confluent
  - terminating

- [Langton's Ant](https://kartoweb.itc.nl/kobben/D3tests/LangstonsAnt/). Exercise: Can you formalise what $(A,->)$ is?
  - normal form?
  - joinable iff?
  - confluent?
  - terminating?


[In the next lecture](https://hackmd.io/s/B1DPNGEdm) we will see that even on the abstract level of ARSs, there is a bit of interesting theory that helps to clarify what happens in the examples.

**Notation:** We write $\to^\ast$ to mean the reflexive and transtitive closure of $\to$ and $\leftrightarrow^\ast$ (or maybe $\equiv$) for the symmetric, reflexive and transitive closure, that is the smallest equivalence relation containing $\to$. 

[^ARS]: When we looked at equational reasoning as in high-school algebra, we studied how equational reasoning progresses by term rewriting. This involved pattern matching in order to determine which rule (or equation) can be applied to any given term. An ARS $(A,\to)$ abstracts from this situation by forgetting the term structure and the pattern matching: While we may still think of the elements of $A$ as terms and of $\to$ as a set of rewrite rules, what we need now can be formulated just in terms of an "abstract" set $A$ and a relation $\to$.

[^automaton]: Transition systems and automata usually have a set of labels (the alphabet) and a relation $\to_a$ for each label $a$ in the alphabet. Much of the same mathematics applies to this generalisation and we may see some of it later.

[^multisets]: Intuitively, multisets are sets in which an element can appear multiple times. So while the sets $\{a,a,b\}$ and $\{a,b\}$ are the same (because they contain the same elements), $\{a,a,b\}$ and $\{a,b\}$ are different as multisets. Multisets can also be understood as lists where the order of elements does not matter, that is while the lists $[a,a,b]$ and $[a,b,a]$ are different as lists, they are the same as multisets (because they contain the same elements the number of times). Mathematically, a multiset is a set $A$ (of elements) together with a function $A\to\mathbb N$ (determining how often the element is in $A$).
