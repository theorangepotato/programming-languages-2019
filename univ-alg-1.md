$\newcommand{\sem}[1]{[\![#1]\!]}$

# Universal Algebra 1: Abstract Data Types

In this lecture, we will learn two notions from universal algebra: signature and algebra. Roughly speaking, a signature is an interface and an algebra an implementation of the interface.

## Introduction

Universal algebra is an area of mathematics that is important to programming languages for many reasons.

- Universal algebra provides the mathematical environment to talk about
  - mathematical variables
  - terms (and functions)
  - equations (and inequations)
  - induction
 
- Universal algebra provides the easiest examples for important ideas in the semantics of programming languages such as types, homomorphisms, free constructions, syntax, semantics, soundness, completeness, term rewriting, normal forms and many more
 
- Universal algebra has many ramifications in computer science (we will hear more about abstract data types in this lecture and maybe more about process algebras in a later lecture):
  - Abstract Data Types
    - data types as algebras
    - for example, how to describe the difference of a LIFO-queue and a FIFO queue without referring to an implementation of programming language
  - [Process Algebras](https://en.wikipedia.org/wiki/Process_calculus) are one of the main techniques to model concurrency and influenced the design of many programming languages such as Erlang, Occam, Go, ...
  - The [constraint satisfaction problem] (https://en.wikipedia.org/wiki/Constraint_satisfaction_problem) is important for many programming implementations (think of time tabling or DNA sequencing). There is also an important conjecture, related to the $\mathbf P\not=\mathbf{NP}$ conjecture, about constraint satisfaction problems and the most likely path to a solution translates them into an equivalent algebraic problem. A taste of what is involved is availabe on this [poster](https://lib.dr.iastate.edu/cgi/viewcontent.cgi?article=1088&context=honors_posters). I am not claiming that I understand the details myself, so I give you the link just as an example for some of the deep and fascinating math out there that has direct impact on questions coming from everyday programming problems. 
  - ...
 
## Table of Contents

- [Part 1](): Introduction -- What is an algebra? -- Abstract Data Types 
- [Structure Preserving Maps](https://hackmd.io/s/HkYir7AiQ)
- [Part 2](https://hackmd.io/s/Bymo_vCj7): Term Algebras, Homomorphisms, Initiality, Induction 
- [Part 3](https://hackmd.io/s/By3OtPAsQ): Variables, Free Algebras
- [Part 4](https://hackmd.io/s/HyMesfK3Q): Equations, Completeness of Equational Logic


## Introduction

### Aims

The aim of this lecture is to introduce some mathematical notions that provide useful tools for what is to follow later in the course. 

If we look at what we have done so far, we find that our mathematical tools are not powerful enough to go further. I point out two areas of limitations.

- The example language we studied 

        exp ::= 1 | exp + exp | exp * exp 
    
  is not even the full language o arithmetic. Most importantly, variables are missing. 
  
- So far the methods we developed for "rewriting as a model of computation" only deal with abstract reduction systems $(A,\to)$ in which we view $A$ as a set without further structure. On the other hand, in some of the more interesting examples such as [sorting](https://hackmd.io/s/HJQNfRbtX#Exercise-Sorting), the set $A$ in question is a set of terms built from  operation symbols (such as `min`, `max`, `sort`, `insert`) and variables. 

We therefore should be interested in the area of mathematics that deals with variables, terms, and equations. It is called Universal Algebra.

Later we will consider directed equations, leading us from Universal Algebra to Term Rewriting. After this, we will then add functions as first-class citizens, which gives us $\lambda$-calculus, the simplest Turing complete programming languages. From there we will go to typed lambda calculus and type theory, which is based on extending the product types of universal algebra by more powerful types (actually we have seen examples on this in the [lecture on Idris](https://hackmd.io/s/HyV1IYYd7)).


### Universal Algebra

Universal Algebra is the area of mathematics that studies, from a general point of view, sets with operations.

There are many reasons why universal algebra is interesting, even foundational, for computer science and we discussed some of them. Most important for this lecture are the following.

Universal algebra

- is the simplest theory in which variables are "first class citizens"
- is the simplest type theory (in which we only have product types)
- is a theory of data types
- provides the important inductive types as so-called initial algebras
- dualises to account for infinite data types via so-called final co-algebras

## What is an algebra?

We already know many algebras.

- The natural numbers $\mathbb N$ with 0 and $+$
- The integers $\mathbb Z$ with 0 and $+$
- The integers $\mathbb Z$ with 0 and $+$ and $-$
- The natural numbers $\mathbb N$ with 1 and $\cdot$
- The natural numbers $\mathbb N$ with $0,1,+,\cdot$
- The rational numbers $\mathbb Q$ with ...
- The real numbers $\mathbb R$ ...
- ...
- Powersets $\mathcal PX$ with union $\cup$, intersection $\cap$, and complementation
- Boolean algebras with or $\vee$, and $\wedge$, and negation $\neg$
- ...

**Notation:** For brevity, we write the above algebras as
- $(\mathbb N,0,+)$
- $(\mathbb Z,0,+,-)$
- $(\mathbb N,1,\cdot)$
- $(\mathbb N,0,1,+,\cdot)$

What do they all have in common?

From a general point of view (and universal algebra is indeed called general algebra by many authors), we say that an algebra is any set equipped with a number of operations. 

Above, all operations are either constants (which take 0 arguments) or binary operations (which take 2 arguments). 

But in general, we want to allow operations with any number $n$ of arguments. This number $n$ is then called the arity of the operation and the operation is also called an $n$-ary operation.


Universal algebra does not study particular algebras, such as the integers with addition and multiplication, but classes of algebras. To get a handle of this one starts with the notion of signature.

**Def:** A ***signature*** is a set $\Sigma$ of 'operation symbols' together with an assignment $\Sigma\to\mathbb N$ of an arity to each operation symbols. 

**Example:** In most of the examples above the signature consists of one constant (= 0-ary operation symbol) and one binary operation symbol. In some cases, there are two constants and/or two binary operation symbols. But in general a signature can contain any number of operation symbols of any arity.

Each signature gives rise to a class of algebras that "implement" the operation symbols specified by the signature.

**Def:** An ***algebra*** for a  signature $\Sigma$, or a $\Sigma$-algebra, consists of a set $A$ together with an $n$-ary function $A^n\to A$, also called an $n$-ary operation,  for each $n$-ary operation symbol of $\Sigma$.

**Notation:** Conceptually, it is important to distinguish syntax from semantics and to distinguish the operation symbols of the signature form the operations of the algebra. In more detail, if $f\in\Sigma$ is an operation symbol and $A$ is an algebra, we may write $f^A$ to denote the operation on $A$ named by $f$. On the other hand, too many super and subscripts make heavy reading, so most of the time one does not make a notational distinction between the operation symbols in the signature and the operations on an algebra.

**Example:** The algebras $A=(\mathbb N,0,+)$ and $B=(\mathbb N,1,\cdot)$ are two different algebras for the same signature consisting of one constant $c$ and one binary operation symbol $f$. In the notation explained above, we have that $c^A=0$, $\;f^A=+$, $\;c^B=1$, $\;f^B=\cdot$.

So what makes these two algebras different? 

Certainly that the symbols $0$ and $1$ are different and that the symbols $+$ and $\cdot$ are different should not be important.

The interesting difference is that they satisfy different equations. For example, $2+3=5$ but $2\cdot 3 = 6$.

So could we say that the meaning of the operations is defined by the equations they satisfy?

This is certainly the point of view taken by universal algebra.

Actually, this is not a new idea for us, we encountered it already in the lectures on syntax and semantics, see here for the [first](https://hackmd.io/hILQksyiTUW4mXxxOSF7eQ), [second](https://hackmd.io/s/B1gOX4lO7) and [third](https://hackmd.io/s/SyIA3Lx_Q).

And this connection is one reason why are interested in universal algebra.

But what are equations?

As we know from high-school algebra equations contain variables. So we first must answer

What are variables?

But before we come to that I want to present the idea of 

## Abstract Data Types

For a mathematician, algebras are sets with operations. To a computer scientist, **algebras are abstract data types**. We first present an example of a data type as a set and then argue that this set only becomes a proper data type after we "upgraded" it to an algebra.

### Data types as sets

First we need a set of data. Let us assume that we have a set $$Elem$$ of data elements. Could be integers or floats are strings or anything really. Now we want to collect elements together in pairs $(e_0,e_1)$ or triples $(e_0,e_1,e_2)$ or etc. Mathematicians have a name for the data we get if we allow any number $n$ of elements as in $$(e_0,\ldots e_{n-1})$$

Such data is then called an $n$-tuple, or also just a tuple. The set of $n$-tuples is also called the set of finite sequences. One also speaks about "words" or "lists" but I want to reserve these for later when we upgrade the set of finite sequences to various different data types.

What is a short way of writing down the set of all tuples?

First note that 

\begin{align}
(e_0,e_1) &\in Elem^2 \\ 
(e_0,e_1,e_2)&\in Elem^3\\ 
&\ldots\\
(e_0,\ldots e_{n-1})&\in Elem^n\\
&\ldots\\
\end{align}

where $Elem^2$ is an abbrevitation for the [cartesian product](https://hackmd.io/s/B1gOX4lO7#Cartesian-Product) $Elem\times Elem$, etc.

So the set of all tuples is the union (or sum) of all $Elem^n$ over $n\in\mathbb N$. A common notation in the literature for this is
$$\sum_{n\in\mathbb N}Elem^n$$

**Remark:** You know a similar notation from high-school algebra. For example, the [geometric series](https://en.wikipedia.org/wiki/Geometric_series) is written as $\sum_{n\in\mathbb N} a^n$ where $a$ is ususally taken to be a number $0<a<1$. The difference is that, instead of a number $a$ we have a set $Elem$, instead of multiplication we have cartesian product and instead of summation of numbers we have union of sets.[^geometricseries]

To summarise, we presented an example of a data type, the type of tuples of arbitrary length,  as a set and took some time to introduce standard notation from set theory/type theory to describe it in succinct notation.

Next we explain why data types are more than sets, why it is useful to think about them as algebras.

### Data types as algebras

The set 
$$\sum_{n\in\mathbb N}Elem^n$$

may not look much like a data type to you. But this is why I have chosen this notation. We will see that there are many different data types that are based on this same set of elements.

Let us think about datatypes you know that are based on $\sum_{n\in\mathbb N}Elem^n$:

- lists
- vectors
- arrays
- stacks
- fifo-queues
- lifo-queues

and there must be many more.

So what distinguishes these datatypes if they all have the same set of data?

One answer could be that, for example, linked lists and arrays are implemented in very different ways. In class we discussed this in some detail and here is a [video](https://www.youtube.com/watch?v=lC-yYCOnN8Q) I found on the internet which roughly covers the same points.

But in a course on "Programming Langauges" it is interesting to find ways of distinguishing lists and arrays, or other data types, in a way that is indpendent of particular implementations and languages.

Our first answer, then, is that we can distinguish different data types on the same underlying set of data by the different operations they provide to the programmer. 

Let us run through some examples.

Lists have basic operations

        nil: List
        cons: Elem x List -> List
        
and then everything that can be defined by induction on `nil` and `cons` such as

        isempty: List -> Bool
        append: List x List -> List
        
and much more.
        
Arrays have basic operations

        get: Array x Nat -> Elem
        put: Array x Nat x Elem -> Array
    
Stacks have basic operations [^partial]

        pop: Stack -> Stack
        top: Stack -> Elem
        
and more that can be defined from them such as [^coinduction]

        nil: Stack
        push: Stack x Elem -> Stack

        
As these examples show, many different datatypes can have the same underlying set, but are distinguished by the operations they support, or, in algebraic terms, by their signature.

The above signature for stacks could also be used for fifo-queues. The fact that we might want to name the operations then differently is not important. Let us agree that, when talking about queues, fifo or lifo, we name the operations

        nil: Queue
        enqueue: Queue x Elem -> Queue
        dequeue: Queue -> Queue
        head: Stack -> Elem
        
The operation `head` may also be called `front` (for fifo) or `end` (for lifo), but here we want to emphasize that both lifo and fifo are based on the same set and the same signature.

Nevertheless, their difference does show up in an implementation-independent, purely algebraic way, namely in the equations that hold for them.

For example, for lifo we have

        dequeue(enqueue(s,e)) = s
        head(enqueue(s,e)) = e

which do not hold for fifo.

To summarise, we see that the notions of signature, algebras and equations all make sense for data types. 

One benefit we get from this is that we can distinguish different data types abstractly without having to consider any particular programming language or implementation.

This approach to data structures is called ***abstract data types***.
        
The only, very small, modification we need to make to our definitions of signature and algebra to accommodate abstract data types is to allow, instead of just one set, a family of sets. For example, the type array was based on sets `Array`, `Nat`, `Elem`. 

This leads to **many-sorted universal algebra**, but many-sorted universal algebra is both conceptually and technically so similar to (one-sorted) universal algebra that it is not worth to elaborate this point in this course. 

After this excursion on abstract data types, let us go back to the main thread of thought. We said that we first have to understand variables.


## References and Further Reading

To see how to implement abstract data types as Java classes, the following book contains all the details about arrays, vectors, hash tables, lists, stacks, queues, and various forms of trees:

[Jenkins: Abstract Data Types in Java (1998)](https://www.e-reading.club/bookreader.php/138175/Abstract_Data_Types_in_Java.pdf)

We will later learn about algebraic data types, see for an interesting

[discussion about algebraic data types at stackexchange](https://softwareengineering.stackexchange.com/questions/159804/how-do-you-encode-algebraic-data-types-in-a-c-or-java-like-language).

This seems all quite complicated compared to the simplicity of algebraic data types in languages such as Haskell, so it is no surprise that there are extensions of Java with algebraic data types, for example Pizza. The following page also contains a tutorial of how to implement algebraic data types in Java.

[Pizza Tutorial](http://pizzacompiler.sourceforge.net/doc/tutorial.html)

Pizza is not developed any more, but the [generics](https://en.wikipedia.org/wiki/Generics_in_Java) introduced by Pizza, and then [Generic Java](http://homepages.inf.ed.ac.uk/wadler/gj/) are  part of Java 5 since 2004, see the official Java tutorial on generics:

[Generics in Java](https://docs.oracle.com/javase/tutorial/java/generics/index.html) (Recommended reading for Java programmers.)

A further [tutorial with examples of generics in Java](https://www.journaldev.com/1663/java-generics-example-method-class-interface).






[^geometricseries]: This analogy is not a coincidence but at the heart of a deep connection between combinatorics and set theory (via category theory). Let me know if you are interested to hear more about this ...

[^partial]: Actually, taking a closer look, we find that `pop` and `top` are not functions, but only partial functions as they are not defined if the stack is empty. There are various ways, to extend the universal algebra we present by allowing for partial functions, but we will ignore this for our treatment. But there is no principled reason why one couldn't account for partiality.

[^coinduction]: While both `List` and `Stack` can be considered as supporting the four operations of `nil`, `cons`, `pop`, `top` one can argue that they differ in the sense that lists have basic operations `nil` and `cons` with `pop` and `top` defined inductively, while stacks have basic operations `pop` and `top` with `nil` and `cons` define *co-inductively*. Unfortunately, we will probably not have time to explain the difference of induction and co-induction.

<!--

-->