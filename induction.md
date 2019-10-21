# How does induction really work?

Our aim is to understand better something we already know how to do. Namely how to reason. This understanding will then allow us to put on a machine something that used to be the reserve of humans: automated reasoning. From the point of view of programming languages the most important application is program verification, but you can imagine that this is of broader interest to databases, artificial ingelligence, mathematics, and even has applications in economics, psychology and philosophy.

## Learning Outcomes

- Understand Induction
- Understand Equational Reasoning

## Examples of Induction

Induction can come in many different forms:

### Numbers

(I assume that students have seen this in a discrete maths or logic or problems solving course.)

We can show, to give just one example, that the equation 
$$1+2+\ldots n = 1/2\cdot n\cdot (n+1)\tag{bb}$$

holds for all positive integers as follows. If $n=1$ then the LHS is 1 (you start and end at 1, so 1 is all you have) and the RHS is 1 as well (just plug in 1 for $n$ and calculate). If $ n$ is not 1, then it is bigger than one and we can write $n=k+1$. In this case we can reason

\begin{align*}
1+2+\ldots n & = 1+2+\ldots (k+1) \\
& = (1+2+\ldots k) +(k+1)\\
& \stackrel{\mathrm{IH}}{=} 1/2\cdot k\cdot (k+1) + (k+1) \\
& \stackrel{\phantom{\mathrm{IH}}}{=} (1/2\cdot k +1)\cdot(k+1) \\
& = 1/2\cdot (k+2)\cdot(k+1) \\
& = 1/2\cdot (n+1)\cdot n \\
& = 1/2\cdot n\cdot (n+1)
\end{align*}

**Exercise:** Go through the equational reasoning above. Can you justify/explain each step? What happens in the step labelled IH?

**Remark:** Why is it correct to apply the equation we want to prove in the proof of the equation itself? Isn't circular reasoning unsound? It depends ... some forms of circularity are justifiable, others are not. In the example above, we prove the equation for $n=k+1$ by using the equation for $n=k$. This is ok, because $k$ is *smaller* than $k+1$. One way to understand this better is by making an analogy with programming. If I define the factorial function `sum` by 

    sum(n) = if n=0 then 0 else sum(n-1)+n 
    
I made a circular definition. But is this a definition? Does it actually define a function ? Or, in other words, does `sum` terminate on all inputs? Yes, `sum` does terminate on all inputs ... because each recursive call `sum(n-1)` calls `sum` with a *smaller* argument `n-1`.

### Expressions

We defined a class of arithmetic expressions in BNF as

        exp ::= 1 | exp + exp | exp * exp
        
This is an inductive definition. The parser that shows that

    1*(1+(1+1))
    
is a valid expression can be understood as generating an inductive proof that the expression `1*(1+(1+1))` is an element of the set inducutively defined by `exp ::= 1 | exp + exp | exp * exp`.

On the other hand, the parser will also be able to establish that `1**` is not a valid expression. This can be understood as the parser establishing that there is no proof that `1**` is an element of the language inducutively defined by `exp ::= 1 | exp + exp | exp * exp`.


### Transitive Closure

We defined the transitive closure of a relation $R$ as the smallest relation $T$ such that

- $R \subseteq T$ and
- $xTy \ \& \ yTz \ \Rightarrow \ xT z$

This is an inductive definition. We often write $R^+$ instead of $T$ to denote the transitive closure of $R$.

### Equational Reasoning

We added to the `exp` above some equations. For example,

    X + ( Y + Z ) = ( X + Y ) + Z

and then showed that for all expressions `n` and `m` in the language defined by `exp ::= 1 | exp + exp | exp * exp` the equation

    n + m = m + n
    
follows already, even without having an equation for commutativity.

What do we mean when we say that an equation follows from some others?

Given a set of equations $E$, can we define the set $E'$ of all equations that follow from $E$?

Yes: An equation is in this set $E'$ if you can derive the equation from the equations in $E$ using the usual rules of equational reasoning from high-school algebra.

This is an inductive definition.

## What is Induction?

Numbers, context-free grammars, transitive closure, equational reasoning $\ldots$ all look different. 

Can we explain how they all are instances of the same general phenomenon called induction?

In all four examples, we define a set of elements: $\mathbb N$, $R^+$, `exp`, $E'$. 

In all cases, the set is infinite, so writing it down with a finite number of rules is doing something clever.

**Example:** In case of numbers we can define the set $\mathbb N$ of natural numbers with two rules as

$$
\frac{}{0 \in \mathbb N} \quad\quad\quad\quad 
\frac{n\in\mathbb N}{Sn\in \mathbb N}
$$

The horizontal bar can be read as "implies". Above the bar are the assumptions, below the bar is the conclusion.

The trick that allows us to define an infinite set with a finite set of rules is that the rule on the right has a free variable $n$ that can be instantiated with any element of $\mathbb N$.

What is inductive about this definition?

This is the crucial point:

When we say that the two rules above "define $\mathbb N$ inductively" or "are an inductive definition of $\mathbb N$", we are really saying that $\mathbb N$ consists of all elements, **and only those**, that can be formed according to the rules.

In other words, $\mathbb N$ is the **smallest set** closed under the two rules. [^tworules] 


**Exercise:** What are the rules for the example of arithmetic expressions and for transitive closure? Write them in a form that resembles as much as possible the two rules for the natural numbers.

For a solution see the footnote. [^bnfrules]

The case of equational reasoning is important for too many reasons to start making a list. We will discuss it in some detail in the next section.

## Equational Reasoning

We define inductively the set of all equations 

$$e_1\approx e_2$$

that we want to study for expression. We write $n,m,\dots$ to denote `num`s and $e$'s to denote `exp`s.

$$
\frac{}{1\in\tt num}
\quad\quad\quad\quad
\frac{n\in\tt num}{Sn \in\tt num}
$$

I write now $Sn$ instead of $n+1$ to distinguish the $+1$ from addition. And for expressions are given by

$$
\frac{n\in\tt num}{n\in\tt exp}
\quad\quad\quad\quad
\frac{e_1\in{\tt exp} \quad\quad e_2\in\tt exp}{e_1+e_2 \in\tt exp}
$$

I omit the rule for multiplication because it is not needed in the following.


As an axiom on expressions we want to have for now only

$$
e_1+(e_2+e_3) \approx (e_1+e_2)+e_3
$$

and we want to show that 
$$ n+m \approx m+n $$
follows already from associativity. Of course, this is only an example. What we are really interested in is to understand what it means for one equation **to follow** from other equations.

As indicated above, the idea is to inductively define the set of all equations that follow. For this, we need to write out the rules of equational reasoning. They are as follows:

$$
\frac{}{e\approx e}{\ \rm (refl)\ }
\quad\quad\quad\quad
\frac{e_1\approx e_2}{e_2\approx e_1}{\ \rm (sym)\ }
\quad\quad\quad\quad
\frac{e_1\approx e_2\quad\quad e_2\approx e_3}{e_1\approx e_3}{\ \rm (trans)\ }
$$
and
$$
\frac{e_1\approx e_1'\quad\quad e_2\approx e_2'}{e_1+e_2\approx e_1'+e_2'}{\ \rm (cong)\ }
$$
To these rules of equational reasoning we want to add, as we said, in our example, the axiom 
$$
\frac{}{e_1+(e_2+e_3) \approx (e_1+e_2)+e_3}{\ \rm (assoc)\ }
$$

To warm up, and to understand how equational reasoning is inductive, let us prove something even simpler then $n+m\approx m+n$, namely
$$1+n \approx n+1$$

The most important idea to understand in this note is the following.

***To say that the equation ${\ 1+n \approx n+1\ }$ follows from ${\ \rm (assoc)\ }$ by equational reasoning is to say that ${\ 1+n \approx n+1\ }$ is an element of the set inductively defined by the rules***
$${\ \rm (refl)\ },
\quad
{\ \rm (sym)\ },
\quad
{\ \rm (trans)\ },
\quad
{\ \rm (cong)\ },
\quad
{\ \rm (assoc)\ }.
$$

If you have any doubts about this statement, stop and think ... come to my office hours ... this is a new and powerful concept.

How do we show that $1+n \approx n+1$ is an element of that set? 

How would we do this in high-school algebra style?

If $n=1$, then $1+1=1+1$.

If $n=Sk$, then
$$ 1+Sk = 1+ (k+1) = (1+k)+1 = (k+1)+1 = Sk +1$$

**Exercise:** Can you justify all the steps in the chain of reasoning above?

**Exercise:** Write the chain of reasoning out in way that one can see at each step which rule among ${\ \rm (refl)\ }
, 
{\ \rm (sym)\ }
, 
{\ \rm (trans)\ }
,
{\ \rm (cong)\ }
,
{\ \rm (assoc)\ }$ is applied in the reasoning.

This last exercise, if done properly, means that we understand in all detail how equational reasoning works. This should mean that we can implement it on a machine.

The next section will look at two programming languages, Isabelle and Idris, in which these proofs can be implemented.

## Excursion on Equational Logic

The topic of the current lecture is not logic but the more general phenomenon of induction. Nevertheless, while analysing familiar reasoning with equations from the point of view of induction, we discovered almost all the rules of equational logic. So we may as well give them here.

Equational logic is the part of logic that is only concerned with proving new equations from old. The rules of equational logic are the one we have seen above (we use now $t$ for "term" where we used $e$ for "expression" before)

$$
\frac{}{t\approx t}{\ \rm (refl)\ }
\quad\quad\quad\quad
\frac{t_1\approx t_2}{t_2\approx t_1}{\ \rm (sym)\ }
\quad\quad\quad\quad
\frac{t_1\approx t_2\quad\quad t_2\approx t_3}{t_1\approx t_3}{\ \rm (trans)\ }
$$
and, for all $n$-ary operations $f$ a congruence rule
$$
\frac{t_1\approx t_1'\quad\ldots\quad t_n\approx t_n'}{f(t_1,\ldots t_n)\approx f(t_1',\ldots t_n')}{\ \rm (cong)\ }
$$
and a rule for substitution of terms into variables that we won't explain now but encounter later again
$$
\frac{t_1\approx t_2}{t_1[x\mapsto t]\approx t_2[x\mapsto t]}{\ \rm (subst)\ }
$$

## Summary of what we learned so far

- An inductive definition defines a smallest set closed under a finite set of rules
- This accounts for such different examples as
  - the set of natural numbers
  - the set of programs of a programming language specified in BNF (ie by a context-free grammar)
  - the set of equations that can be derived from a given set of assumptions

Thus we have a set of analogies

| mathematics | computer science | logic |
| ------------|-------------|-------|
| numbers | programs | theorems |

with the sets of numbers/programs/theorems being defined inductively. [^lambek] Of course, there is much more defined inductively, for example we could also define a set of proofs inductively.

So can we compute with programs and theorems as we can compute with numbers?



## Arithmetic Expressions in Isabelle and Idris

[See the next lecture](https://hackmd.io/s/HyV1IYYd7)



[^tworules]: You could say that $\frac{}{0 \in \mathbb N}$ does not look like a rule, because it does not have premises. I'd rather say that it has an empty set of premises.

[^lambek]: As often in research, what starts out as a curious analogy can be turned into an important research programme. So let us take, for a moment, the analogy program vs theorem seriously. If programs are like theorems, then parsing is like proving. This is the basic idea of two papers by Lambek (1958, 1961) that spawned whole research areas in both linguistics and in logic.

[^bnfrules]: The context-free grammar

        num ::= 1 | num +1
        exp ::= num | exp + exp | exp * exp

    can be written as a set of rules as follows.
$$
\frac{}{1\in\tt num}
\quad\quad\quad\quad
\frac{n\in\tt num}{n+1 \in\tt num}
\ \\
\ \\
\ \\
\frac{n\in\tt num}{n\in\tt exp}
\quad\quad\quad\quad
\frac{e_1\in{\tt exp} \quad\quad e_2\in\tt exp}{e_1+e_2 \in\tt exp}
\quad\quad\quad\quad
\frac{e_1\in{\tt exp} \quad\quad e_2\in\tt exp}{e_1*e_2 \in\tt exp}
$$
The mathematical definition of transitive closure
    - $R \subseteq R^+$ and
    - $xR^+y \ \& \ yR^+z \ \Rightarrow \ xR^+ z$

    can be written as a set of rules as
$$\frac{(x,y)\in R}{(x,y)\in R^+}
\quad\quad\quad\quad
\frac{(x,y)\in R \quad\quad (y,z)\in R^+}{(y,z)\in R^+}$$