# Abstract Reduction Systems 2: Confluence and Normal Forms

(continued from [ARS 1](https://hackmd.io/s/rkk0tgxu7))

Now let us see that even on the abstract level of ARSs, there is a bit of interesting theory that helps to clarify what happens in the examples. 

**Notation:**
We write $\;\stackrel{\ast}{\longrightarrow}\;$ to mean the reflexive and transtitive closure of $\;\stackrel{}{\rightarrow}\;$ and $\;\stackrel{\ast}{\longleftrightarrow}\;$ (or maybe $\equiv$) for the symmetric, reflexive and transitive closure, that is the smallest equivalence relation containing $\;\stackrel{\ast}{\longrightarrow}\;$. 

**Definition:** Let $(A,\to)$ be an ARS and $a,b\in A$.
- $a$ is *reducible* if there is $x\in A$ such that $a\to x$.
- $a$ and $b$ are *equivalent* if $a\stackrel{\ast}{\longleftrightarrow} b$. We also write this as $a\equiv b$.
- $a$ is a *normal form*, or $a$ is in normal form, if $a$ is not reducible. 
- $a$ *reduces to* $b$ if $a\stackrel{\ast}{\longrightarrow} b$.[^reduces]
- $a$ has a normal form $b$, or $b$ is a normal form of $a$, if $a$ reduces to $b$ and $b$ is a normal form.
- If $a$ has exactly one normal form (we also say: the normal form is unique), the normal form of $a$ is denoted by $a{\downarrow}$.
- $a,b$ are *joinable*, written as $a\downarrow b$, if both $a$ and $b$ reduce to the same element. In symbols, $a\downarrow b$ if there is $x\in A$ such that $a\stackrel{\ast}{\longrightarrow} x$ and $b\stackrel{\ast}{\longrightarrow} x$.
- $(A,\to)$ is 
  - *Church-Rosser* if all equivalent elements are joinable. 
  - *confluent* if whenever $x$ reduces to $y$ and $z$, then $y$ and $z$ are joinable.
  - terminating if there is no infinite chain $a_0\to a_1\to\ldots$.
  - normalising if every element has a normal form

**Remark:** Sometimes *canonical form* is used to mean unique normal form. [^canonicalform]

**Exercise:** Write out Church-Rosser and confluence in symbolic notation.

**Exercise:** Does terminating implies normalising? What about the converse?

**Theorem:** An ARS is Church-Rosser if and only if it is confluent.

Is this obvious? Can we prove it?

**Corollary:** Let $\to$ be confluent and $a,b$ be in normal form. Then $a \equiv b$ if and only if $a=b$.

Thus, confluence implies that normal forms are unique as long as they exist in the first place.

Yet another way to say this:

**Corollary:** An ARS is confluent and normalising if and only if there exist unique normal forms.

But how do we show that normal forms exist?

**Theorem:** If an ARS is confluent and terminating then all elements reduce to a unique normal form.

**Remark (local confluence):** Confluence as defined above says that for every "peak" $$b\stackrel{*}{\longleftarrow}\bullet \stackrel{*}{\longrightarrow} c$$ the elemements $b,c$ are joinable. There is a weaker condition, called **local confluence**, which says that for all  $$b\stackrel{}{\leftarrow}\bullet \stackrel{}{\rightarrow} c$$ the elemements $b,c$ are joinable. Local confluence is important, because it is easier to check. Local confluence implies confluence if the ARS is terminating.

The last theorem and remark highlights the importance of termination. But termination is of course a very important topic in programming in general (ever since one learned about the while loop). So this is the topic of the next lecture.

(to be continued at [ARS 3](https://hackmd.io/s/BkXUkyw_Q))

## References:
- Baader, Nipkow. Term Rewriting and All That. 1999
  This is my main reference for ARSs and term rewriting. I will mainly use material from the following sections:
        
        Chapters 
			2.1 confluence, normal forms, etc
			2.3 termination
			2.4 lexicographic ordering

The book above should be in the library now. You may also look at Chapter 1.1 of 

- [Terese Lite](https://www.cs.vu.nl/~tcs/trs/tereselite06.pdf)

which has the advantage of being available online and an abridged version of the standard reference on term rewriting.

Another valuable resource, in particular with an eye to what is coming later on $\labmda$-calculus is Chatper 3 of [Barendregt's Lambda Calculus](https://www.elsevier.com/books/the-lambda-calculus/barendregt/978-0-444-87508-2).

[^reduces]: We also say that $b$ is reachable (or derivable) from $a$.

[^canonicalform]: For example, we may rewrite arithmetic expressions in the language 
`exp ::= 1 | x | exp + exp | exp * exp` 
by expanding expressions of the form `X*(Y+Z)` to `X*Y+X*Z`. This gives us normal forms we know from high-school algebra (think of the familiar expansion of `(x+1)*(x+1)` to `x*x + 2*x + 1`). But these normal forms are not unique as we may write the summands and products in any order (we could, eg, write as well `1 + x*x + x*2`).
Other similar examples of normal forms that may be familiar are the disjunctive and conjunctive normal form in Boolean logic.