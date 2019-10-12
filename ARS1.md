$\newcommand{\sem}[1]{[\![#1]\!]}$

# Abstract Reduction Systems 1 : Examples

(in this lecture, we start learning the basic maths that is needed for our main model of computation; this material will be examinable in the "midterm" and the December exam)

## Learning Outcomes

Students will be able to 
understand (and illustrate with simple examples) that an ARS with a computable reduction relation in which each equivalence class has a unique normal form, can be understood as a non-deterministic algorithm for solving the computational problem of determining when two elements of the ARS are equivalent.

This is quite a mouthful, so ask me about it again, if you are not sure ... 

## Recap from Lambda Calculus

If we run a `LambdaNat` program on our computer it is impossible for us to understand what exactly is going on in our machine. There are too many complicated mechanism involved: the Haskell compiler, CPU, Cache, memory management, etc. 

Therefore, we need a model of computation, or a virtual machine, that allows us to execute programs on a higher level of abstraction.

Recall that we can describe the semantics of `LambdaNat` as a function

$$\sem{-}:\cal L \to \cal L$$

on lambda expressions $\cal L$ (recall that $\cal L$ is defined by the grammar of `LambdaNat` as the set, or language, of all legal programs). This function is the interpreter of `LambdaNat`, which is defined by a set of equations, written in Haskell as the by now familiar (recall that Haskell manipulates abstract syntax)


    evalCBN (EApp e1 e2) = case (evalCBN e1) of (EAbs i e1') -> evalCBN (subst i e2 e1') e1' -> EApp e1' e2
    evalCBN (EIf e1 e2 e3 e4) = if (evalCBN e1) == (evalCBN e2) then evalCBN e3 else evalCBN e4
    evalCBN (ELet i e1 e2) = evalCBN (EApp (EAbs i e2) e1) 
    evalCBN (ERec i e1 e2) = evalCBN (EApp (EAbs i e2) (EFix (EAbs i e1)))
    evalCBN (EFix e) = evalCBN (EApp e (EFix e)) 
    evalCBN (EMinusOne e) = case (evalCBN e) of ENat0 -> ENat0 (ENatS e) -> e
    evalCBN (ENatS e') = ENatS (evalCBN e')
    evalCBN x = x



Reading the equations from left to right, they define a rewrite relation. In the light of the previous lecture, the equations can also be understood as an equivalence relation identifying all lambda expressions with the same meaning.

## Introduction

The characterisation of the interpreter of `LambdaNat` as a virtual machine rewriting lambda-expressions, raises some important questions. In particular, there are many expressions in which more than one rule can be applied. In other words, the rewriting as defined by the equations is non-deterministic. This raises a number of questions, the most important of which is:

- Does the order in which we apply the rules matter?

In a good rewrite system the answer will be "No". This is important both for understanding and for efficiency. If we know that the result is independent of the order, then 

- we can understand the computation using the order that looks easiest to us and

- we can implement the computation using the order that runs fastest.

Abstract Reduction Systems will allows us to examine such questions at the right level of abstraction. In particular, we will abstract away from

 - the syntax of programs and
 - computability questions
 
and only be concerned with a set (of elements we want to rewrite) and a relation (we think of as defining the one-step rewrites).

## Models of computation

What is most fundamental feature shared by all models of computation?

All models of computation, I would say, must have a set $A$ with a binary relation that models one-step computations. 

This is sometimes called Abstract Reduction System.[^ARS] Other names that may be used for the same mathematical structure include graph, dynamical system, transition system, automaton, ... [^automaton]

**Definition:** An abstract reduction system (ARS) is a set $A$ together with a relation ${\to}\subseteq A\times A$.

This doesnt look very interesting at first sight. Just a relation on a set? What can we do with this? In fact, there is an extremely simple virtual machine, which turns any ARS into an algorithm.

**The virtual machine running ARSs:** Let $(A,\to)$ be an ARS. Let $a\in A$. The virtual machine runs on input $A$ and $a$ as follows.

1. **If** there is no $b\in A$ such that $a\to b$ **then** stop (and output $a$) **else** replace $a$ by $b$ and go to 1.



Certainly there are many ARSs $(A,\to)$ for which the virtual machine will not compute anything interesting. In this lecture, we will exhibit some general structural properties of an ARS that guarantee that the ARS does compute something interesting.



**Data:** To understand on what kind of data an ARS runs, note that the elements of $A$ can be all kind of different things: numbers, strings, lists, multisets, trees, ... all kind of data ... I am working with a graduate student on an example where $A$ is a set of diagrams ... but $A$ could also contain the memory of a computer or the cells of a cellular automata.

**Properties of ARSs:** There are a number of important properties that we can express about ARSs in general. We already have seen the notion of a normal form, which is defined purely in terms of $(A,\to)$. Indeed, $a\in A$ is a ***normal form*** if there is no $(a,b)\in{\to}$, or, if there is no $a\to b$. Let us make a list of some interesting questions to ask (precise definitions follow the examples):

- which elements are in normal form?
- which elements reduce to normal form?
- are normal forms unique?
- which elements are joinable?
- which elements are equivalent?
- is the reduction system confluent?
- does reduction terminate?

**Terminology:** If $a\to b$ in an ARS, we say that $a$ *reduces* to $b$. This is a way of speaking that indicates that we think of $a\to b$ as a one-step computation that, as in equational reasoning, simplifies, or reduces, $a$ to $b$. But this expectation is not part of the definition of ARSs, which include examples where $b$ is "more complicated" than $a$. 

## Examples and Exercises

The examples below are not necessarily meant to illustrate the idea of an ARS as a model of computation. Rather they serve at illustrating what is captured by the definitions as they are. While it is not too much of an exaggeration to say that all models of computations are ARSs, the notion of an ARS is too abstract to make sure that all ARSs are models of computation. We will later refine ARSs to TRSs and then to lambda-calculus to get to a narrower class of mathematical models which can be considered satisfactory answers to the question "What is computation?".

- Answer the following questions

  - what are the normal forms?
  - are normal forms unique?
  - when are two numbers are joinable?
  - which numbers are equivalent?
  - is it confluent?
  - is it terminating?

for each of the examples below.

The first two illustrate unique normal forms, but are not interesting from a computational point of view.

- $A$ is the set of integers $> 1$ and  $m\to n$ is defined to hold if $m>n$ and $n$ divides $m$.

- $A$ is the set of integers $\ge 1$ and  $m\to n$ is defined to hold if $m>n$ and $n$ divides $m$.

The next one can be seen as implementing a non-determinstic algorithm. Which one?

- A is the set of finite lists (aka words) over $\{a,b\}$, $wbav\to wabv$

**Remark:** Running the ARS of the last bullet point on our virtual machine, we see that the ARS as an algorithm is a non-deterministic, highly parallizable version of bubble sort. Compare how simple the definition of the ARS is as opposed to its [implementation in pseudocode](https://en.wikipedia.org/wiki/Bubble_sort#Pseudocode_implementation).


**Exercise:** Here is another variation on the previous example. A is the set of multisets[^multisets] over $\{a,b\}$, $aa\to a$, $bb\to a$, $ab\to b$, $ba\to b$. Answer again the quesitons above.

The next one seems very different at first sight as the coordinate plane is similar to the tape of a Turing machine, in other words, the rules of how the ant move modify external memory.

- [Langton's Ant](https://kartoweb.itc.nl/kobben/D3tests/LangstonsAnt/). Exercise: Can you formalise what $(A,\to)$ is? 

## Some Answers to the Examples and Exercises

- $A$ is the set of integers $> 1$ and  $m\to n$ is defined to hold if $m>n$ and $n$ divides $m$.
  - terminating (because numbers get smaller and are positive)
  - normal forms are primes
  - normal forms are not unique
  - two numbers are joinable iff they share a prime number (iff they are not relatively prime)
  - all numbers are equivalent
  - not confluent
  
- $A$ is the set of integers $\ge 1$ and  $m\to n$ is defined to hold if $m>n$ and $n$ divides $m$.
  - terminating
  - unique normal form is 1
  - all numbers are equivalent
  - confluent

- A is the set of finite lists (aka words) over $\{a,b\}$, $wbav\to wabv$
  - normal forms are sorted lists (if we say that $a$ comes before $b$)
  - normal forms are unique
  - two lists are joinable iff they are equivalent iff they have the same number of $a$'s and the same number of $b$'s
  - confluent
  - terminating



In the next lecture we will see that even on the abstract level of ARSs, there is a bit of interesting theory that helps to clarify what happens in the examples.

**Notation:** We write $\to^\ast$ to mean the reflexive and transtitive closure of $\to$ and $\leftrightarrow^\ast$ (or maybe $\equiv$) for the symmetric, reflexive and transitive closure, that is the smallest equivalence relation containing $\to$. 

## Homework

- Read the notes carefully and make sure that you can do all the exercises.

- Describe in your won words the virtual machine that runs an ARS.

- Under what conditions on the ARS can we say that the ARS represents an algorithm?

- Check for yourself whether you achieved the learning outcomes.


[^ARS]: When we looked at equational reasoning as in high-school algebra, we studied how equational reasoning progresses by term rewriting. This involved pattern matching in order to determine which rule (or equation) can be applied to any given term. An ARS $(A,\to)$ abstracts from this situation by forgetting the term structure and the pattern matching: While we may still think of the elements of $A$ as terms and of $\to$ as a set of rewrite rules, what we need now can be formulated just in terms of an "abstract" set $A$ and a relation $\to$.

[^automaton]: Transition systems and automata usually have a set of labels (the alphabet) and a relation $\to_a$ for each label $a$ in the alphabet. Much of the same mathematics applies to this generalisation and we may see some of it later.

[^multisets]: Intuitively, multisets are sets in which an element can appear multiple times. So while the sets $\{a,a,b\}$ and $\{a,b\}$ are the same (because they contain the same elements), $\{a,a,b\}$ and $\{a,b\}$ are different as multisets. Multisets can also be understood as lists where the order of elements does not matter, that is while the lists $[a,a,b]$ and $[a,b,a]$ are different as lists, they are the same as multisets (because they contain the same elements the number of times). Mathematically, a multiset is a set $A$ (of elements) together with a function $A\to\mathbb N$ (determining how often the element is in $A$).
