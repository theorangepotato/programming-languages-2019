# Abstract Reduction Systems 2: Confluence and Normal Forms 

(continued from [ARS 1](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/r1D5VMedS))

## Learning Outcomes

The student will be able 

- to define what is meant by: ARS, reducible, equivalent, normal form, reduces to, joinable, Church-Rosser, confluent, terminating, normalising

- to discuss whether a given ARS has unique normal forms by applying the relevant mathematical results

## Recap and Introduction

One of the main reasons to be interested in ARSs is that they provide the right level of abstraction to discuss the relationship between meaning (in the form of an equivalence relation $\approx$) and computation (in the form of a reduction relation $\to$). 

More formally, for any relation $\to$ on a set $A$, we can define $\approx$ as the smallest equivalence relation containing $\to$. Concretely this means that $a\approx b$ holds if and only iff there is a (possibly empty) "zig zag" built from $\to$ connecting $a$ and $b$.

So far we have seen examples illustrating these ideas. In this section we will see what conditions on $\to$ are needed to make this work. 

The best possible situation is that every equivalence class contains a unique normal form. Assuming that $\to$ is itself computable, we can then understand an ARS $(A,\to)$ as an algorithm implementing the specification $\approx$.

## Example

**Activity:** Write a program to check that two lists have the same elements. 

**Outcome:** The naive algorithm has time complexity $O(n^2)$. It is faster to first sort, which is $O(n\log n)$, and eliminate duplicates and to compare the two lists, which is $O(n)$. 

(This assumes that we have an order for the elements.)

The solution that works by sorting and eliminating duplicates can be seen as a rewriting-to-normal-form solution. It can be described as a term rewriting system by the rules

$$\frac{x<y}{yx\to xy}$$

$$xx\to xx$$

The first rule implements a bubble sort, which has O(n^2), but feel free to replace it by a faster sorting algorithm.

The second rule eliminates duplicates.

This term rewriting system defines an ARS that we can run on the virtual machine. 

**Remark (rules to build rules):**  If the set of possible elements of the lists is $\{0,1,2\}$, then the first rule can be seen as an abbreviation for the three rules $10\to 01$, $20\to 02$ and $21\to 12$. Similarly, the second rule can be seen as an abbreviation for the rules $00\to 0$, $11\to 1$ and $22\to 2$. (In other words, from the point of view of ARSs, the two rules above can be seen as rules to build rules.)

**Remark (notation):** Since ARSs are abstract, we are free to choose any notation we like for lists. Here I just write lists as a sequence of symbols without seperator, but you may prefer to write [2,0,1,1,1] or something else instead of 20111.


**Example:** We can show that the lists 20112 and 122220 have the same elements by computing their normal forms as follows

\begin{align}
20112 & \to 02112\\
& \to 0212\\
& \to 0122\\
& \to 012
\end{align}

and

\begin{align}
122220 & \to 12220\\
 & \to 1220\\
 & \to 120\\
 & \to 102\\
 & \to 012
\end{align}

Since the lists have the same normal form they must have the same elements.

**Exercise:** Conversely, do all lists that have the same elements reduce to the same normal form?

**Exercise:** Justify each of the computation steps above by pointing out which rule was applied.


**Exercise:** Does the result of the computation (ie the normal form) depend on the order in which we apply the rules?

**Takeaway:** If an ARS is terminating and has unique normal forms, the ARS can be seen as an algorithm.

In particular, the two rules

$$\frac{x<y}{yx\to xy}$$

$$xx\to xx$$

are a program that we can run on our virtual machine in order to decide whether to lists have the same elements. Moreover, we can refine the sorting part of the algorithm in order to achieve $O(n\log n)$ time complexity (if we have to sort) or even $O(n)$ if we keep lists sorted to start with.

## Definitions

Now let us see that even on the abstract level of ARSs, there is a bit of interesting theory that helps to clarify what happens in the examples. 

**Notation:**
We write $\;\stackrel{\ast}{\longrightarrow}\;$ to mean the reflexive and transtitive closure of $\;\stackrel{}{\rightarrow}\;$ and $\;\stackrel{\ast}{\longleftrightarrow}\;$ (or maybe $\equiv$) for the symmetric, reflexive and transitive closure, that is the smallest equivalence relation containing $\;\stackrel{\ast}{\longrightarrow}\;$. 

**Definition:** Let $(A,\to)$ be an ARS and $a,b\in A$.
- $a$ is ***reducible*** if there is $x\in A$ such that $a\to x$.
- $a$ and $b$ are ***equivalent*** if $a\stackrel{\ast}{\longleftrightarrow} b$. We also write this as $a\equiv b$.
- $a$ is a ***normal form***, or $a$ is in normal form, if $a$ is not reducible. 
- $a$ ***reduces to*** $b$ if $a\stackrel{\ast}{\longrightarrow} b$.[^reduces]
- $a$ ***has a normal form*** $b$, or $b$ is a normal form of $a$, if $a$ reduces to $b$ and $b$ is a normal form.
- If $a$ has exactly one normal form (we also say: $a$ has a ***unique normal form***), the normal form of $a$ is denoted by $a{\downarrow}$.
- If every element has a unique normal form, we say that $A$ has unique normal forms.
- $a,b$ are ***joinable****, written as $a\downarrow b$, if both $a$ and $b$ reduce to the same element. In symbols, $a\downarrow b$ if there is $x\in A$ such that $a\stackrel{\ast}{\longrightarrow} x$ and $b\stackrel{\ast}{\longrightarrow} x$.
- $(A,\to)$ is 
  - ***Church-Rosser*** if all equivalent elements are joinable. 
  - ***confluent*** if whenever $x$ reduces to $y$ and $z$, then $y$ and $z$ are joinable.
  - ***terminating*** if there is no infinite chain $a_0\to a_1\to\ldots$.
  - ***normalising*** if every element has a normal form.

**Remark:** Sometimes *canonical form* is used to mean unique normal form. [^canonicalform]

**Exercise:** Write out Church-Rosser and confluence in symbolic notation.

**Remark:** In an ARS with Church-Rosser, we can show that two elements are equivalent by reducing them to the same element.


**Exercise:** Show that terminating implies normalising. What about the converse?

**Theorem:** An ARS is Church-Rosser if and only if it is confluent.

Is this obvious? Can we prove it?

**Corollary:** Let $\to$ be confluent and $a,b$ be in normal form. Then $a \equiv b$ if and only if $a=b$.

Thus, confluence implies that normal forms are unique as long as they exist in the first place.

Yet another way to say this:

**Corollary:** An ARS has unique normal forms if (and only if) it is confluent and normalising.

But how do we show that normal forms exist? By putting together the results from above we obtain:

**Theorem:** If an ARS is confluent and terminating then all elements reduce to a unique normal form.

**Remark (local confluence):** Confluence as defined above says that for every "peak" $$b\stackrel{*}{\longleftarrow}\bullet \stackrel{*}{\longrightarrow} c$$ the elemements $b,c$ are joinable. There is a weaker condition, called **local confluence**, which says that for all  $$b\stackrel{}{\leftarrow}\bullet \stackrel{}{\rightarrow} c$$ the elemements $b,c$ are joinable. Local confluence is important, because it is easier to check. Local confluence implies confluence if the ARS is terminating.

The last theorem and remark highlights the importance of termination. But termination is of course a very important topic in programming in general (ever since one learned about the while loop). So this is the topic of the next lecture.

## Conclusion

Recall that we can execute every ARS $(A,\to)$ on our virtual machine $\textsf{VM}$, where $\textsf{VM}$ is defined as follows.

1. **If** there is no $b\in A$ such that $a\to b$ **then** stop (and output $a$) **else** replace $a$ by $b$ and go to 1.

If the ARS is **terminating**, this is an algorithm and we can write $\textsf{VM}_{(A,\to)}(a)$ or simply $\textsf{VM}(a)$ for the result. 

We also learned that if, in addition, the ARS is **confluent**, then we have an algorithm that decides whether two elements are equivalent. 

Inputs are $(A,\to)$ and $a,b\in A$. 

1. If $\textsf{VM}(a)=\textsf{VM}(b)$ then True else False.

Note that while we cannot say anything in general about the time needed for the computation of $\textsf{VM}(a)$, we can say that the equality test "=" itself will typically be linear (or less) in the size of $a$.

---

(to be continued at [ARS 3](https://hackmd.io/JwKRqY1aSOa-bzxHnWZe0Q))

---



## References:
- Baader, Nipkow. Term Rewriting and All That. 1999
  This is my main reference for ARSs and term rewriting. I will mainly use material from the following sections:
        
        Chapters 
			2.1 confluence, normal forms, etc
			2.3 termination
			2.4 lexicographic ordering

The book above should be in the library. You may also look at Chapter 1.1 of 

- [Terese Lite](https://www.cs.vu.nl/~tcs/trs/tereselite06.pdf)

which has the advantage of being available online and an abridged version of the standard reference on term rewriting.

Another valuable resource, in particular if you are interested in a more thorough understanding of the $\lambda$-calculus is Chatper 3 of [Barendregt's Lambda Calculus](https://www.elsevier.com/books/the-lambda-calculus/barendregt/978-0-444-87508-2).

[^reduces]: We also say that $b$ is reachable (or derivable) from $a$.

[^canonicalform]: For example, we may rewrite arithmetic expressions in the language 
`exp ::= 1 | x | exp + exp | exp * exp` 
by expanding expressions of the form `X*(Y+Z)` to `X*Y+X*Z`. This gives us normal forms we know from high-school algebra (think of the familiar expansion of `(x+1)*(x+1)` to `x*x + 2*x + 1`). But these normal forms are not unique as we may write the summands and products in any order (we could, eg, write as well `1 + x*x + x*2`).
Other similar examples of normal forms that may be familiar are the disjunctive and conjunctive normal form in Boolean logic.