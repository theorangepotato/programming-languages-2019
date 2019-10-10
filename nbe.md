$\newcommand{\sem}[1]{[\![#1]\!]}$
$\newcommand{\nf}{\mathsf{nf}}$

# Normalisation by Evaluation

## Introduction

[Normalisation by Evaluation](https://en.wikipedia.org/wiki/Normalisation_by_evaluation) is a  technique in programming languages that is complicated through the presence of variables and higher-order functions, features that we have not yet introduced. [^nbe]

But some of the main ideas can be already explained in a very simple situation without variables and function types. This is the purpose of this lecture.

In mathematics, this idea is sometimes known as van der Waerden's trick as explained in [Bergman's course on universal algebra](https://math.berkeley.edu/~gbergman/245/). [^bergman] 

## Learning Outcomes

Students will learn 

- the basic ideas the technique known in programming languages as normalisation by evaluation.
- how to use this technique to prove completeness of an axiomatisation wrt a semantics.

## Aims
- Reinforce the relationship between the lectures about syntax and semantics, [part 1]() and [part2](), on the one hand and abstract reduction systems on the other hand.
- Show how [normal forms](https://hackmd.io/s/B1DPNGEdm) can be used in completeness proofs. This is a general technique that is widely applicable.
- Prove an observation from [our first lecture](https://github.com/alexhkurz/programming-languages/blob/master/lecture-1.2.md) that associativity is enough to prove all equations about expressions in the language given by $1,+$.
- Extend this observation to the language $1,+,*$.
- Link 'semantic' and 'syntactic' normal forms.
- Discuss some subtleties about overloading notation.

## Example

We go back to our lectures on syntax and semantics [Part 1]() and [Part 2]().

One topic of these lectures was in what sense it is justified to say that the meaning of the (purely formal) language


        exp ::= 1 | exp + exp | exp * exp

is captured by the (equally formal) equations

\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X * 1 &\approx X \\
        X * ( Y + Z ) & \approx X * Y + X * Z \\
        X * ( Y * Z ) & \approx ( X * Y ) * Z \\
        X + Y  & \approx Y + X \\
        X * Y  & \approx Y * X
\end{align}


On the one hand, it is important to emphasise that the language and the equations  can be run on a machine without any human interference or intelligence.

On the other hand, the language and the equations make sense to us because they agree with our understanding of the natural numbers.

How do we convince ourselves that the equations capture exactly the familiar $1,+,\cdot$ of the natural numbers?

How do we know that we have enough equations? Can we drop some equations?

The answer will use ideas we learned about when we discussed abstract reduction systems (ARSs).

We defined a normal form in ARS $(A,\to)$ as an element $a\in A$ that cannot be reduced, that is, there is no $b$ such that $a\to b$. This is a purely syntactic notion, at least if the ARS can be described in a finite way.

In this lecture, we will see a semantic way of giving a notion of normal form. And we will also see how to match these two notions up.

## Remark on Overloading 

As we explained above, it is important to separate syntax from semantics. Expressions have operations 1,+,* and numbers have operations $1,+,\cdot$. This situation is very common in programming where we also want to denote different operations by the same symbol. This is called **overloading**. Here we overloaded 1 and + and did not overload multiplication for which we use * and $\cdot$, respectively. Is this a bad or a good idea? Here are some points to consider:

- Making a distinction between * and $\cdot$ helps making clear whether we talk about syntax or semantics.

- Using different symbols for 1,+ would make the lecture more difficult to read 

- Even using the different symbols * and $\cdot$ and, similarly, $\approx$ and $=$, has disadvantages as the equations holds for both syntax and semantics (indeed, that is the crux of this lecture, as we will see). So do we have to write the equations twice now, once with * and $\approx$ and once with $\cdot$ and $=$, or should we better avoid this?

In my experience, there is no one good answer. In programming one tends to not overload and in maths one tends to use overloading a lot, but there are no general rules and one needs to decide on an ad hoc basis, taking into account asthetic considerations, not only objective criteria such as correctness, efficiency, etc

## Normalisation by Evaluation

[Recall]() that the meaning of our language $\mathcal L$ of `exp`'s is given by the semantics (meaning function)

\begin{align}
\sem{-}:\mathcal L&\to \mathbb N\\\hline
\sem{1}& =1\\
\sem{t+t'}& =\sem{t}+\sem{t'} \\
\sem{t*t'}& =\sem{t}\cdot\sem{t'} 
\end{align}

The new idea is to, conversely, define a function

\begin{align}
\nf : \mathbb N&\to \mathcal L\\\hline
\nf(1) & =1\\
\nf(n+1)& = \nf(n)+1\\
\end{align}

For example, $\nf(4) = ((1+1)+1)+1)$, etc. [^one]

**Exercise:** Show that 
- $\sem{-}$ restricted to left-bracketed expressions such as $(1+1)+1$ is an inverse of $nf$.
- $\sem{\nf(n)}=n$

We can now define the *semantic normal form* of an expression $e$ as
$$\nf(\sem{e})$$

**Question:** Which equations between `exp`'s  are needed to guarantee that $$e\approx \nf(\sem{e})$$

for all expressions $e$?

For maximum effect pause the lecture and try to find out yourself.

We reason by induction on the three rules that make the definition of 

        exp ::= 1 | exp + exp | exp * exp

If $e$ is 1 then $1=\nf(\sem{1})$. No equations needed. [^refl]

If $e$ is $e_1+e_2$, we want to reason
\begin{align}
\nf(\sem{e_1+e_2}) 
& = \nf(\sem{e_1}+\sem{e_2})\\
& \approx \nf(\sem{e_1})+ \nf(\sem{e_2})\\
& \approx e_1+ e_2\\
\end{align}

**Exercise:** Justify all steps. Which equations are needed? 
(Bonus question: Which [rules of equational logic]() are used?)

Similarly, if $e$ is $e_1*e_2$, we reason
\begin{align}
\nf(\sem{e_1*e_2}) 
& = \nf(\sem{e_1}\cdot\sem{e_2})\\
& \approx \nf(\sem{e_1})* \nf(\sem{e_2})\\
& \approx e_1* e_2\\
\end{align}

To conclude, we have proved by induction on the definition of $\mathcal L$ that 
$$\nf(\sem{e})\approx e $$

for all $e\in\mathcal L$.

**Exercise:** Can you confirm that the argument above only used the following equations?
\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X \cdot 1 &\approx X \\
        X \cdot ( Y + Z ) & \approx X \cdot Y + X \cdot Z \\
\end{align}

**Theorem 1:** The equations 
\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X \cdot 1 &\approx X \\
        X \cdot ( Y + Z ) & \approx X \cdot Y + X \cdot Z \\
\end{align}

allows us deduce by equational reasoning the equations
$$\nf(\sem{e})\approx e $$

for all expressions $e$ in the language $\mathcal L$ given by 

        exp ::= 1 | exp + exp | exp * exp
        
**Remark:** This theorem has both a logical interpretation and a computational interpretation, as we are going to see next.

## Logical Interpretation: Completeness

In this section, we show that Theorem 1 has a logical interpretation. In fact, we can reformulate Theorem 1 as a so-called completeness result.

Theorem 2 below states that the equations
\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X * 1 &\approx X \\
        X * ( Y + Z ) & \approx X * Y + X * Z 
\end{align}

are sound and complete for the language given by

        exp ::= 1 | exp + exp | exp * exp

and the interpretation in the natural numbers given by 
\begin{align}
\sem{1}& =1\\
\sem{t+t'}& =\sem{t}+\sem{t'} \\
\sem{t*t'}& =\sem{t}\cdot\sem{t'} 
\end{align}

In symbolic notation we write this as

**Theorem 2:** $\quad\quad\quad\quad\quad\quad\quad e_1 \approx e_2 \quad\Longleftrightarrow\quad \sem{e_1}=\sem{e_2}$

**Proof:**  Soundness means that for all expressions $X,Y,Z$, the following equations
\begin{align}
        \sem{X + ( Y + Z )} &= \sem{( X + Y ) + Z} \\
        \sem{X * 1} &= \sem{X} \\
        \sem{X * ( Y + Z )} &= \sem{X * Y + X * Z} 
\end{align}
hold for natural numbers. But these are just properties of numbers we are familiar with.

Completeness is the converse, namely 
$$\sem{e_1}=\sem{e_2} \quad \Longrightarrow \quad e_1\approx e_2$$

This follows from
$$e_1\approx \nf(\sem{e_1}) =\nf(\sem{e_2}) \approx e_2$$

where the "$\approx$" are due to Theorem 1 and "$=$" is due to the assumption.

This finishes the proof.

To summarise, for all expressions $e_1,e_2,e_3$ in the language above there are derivations of the equations
\begin{align}
        e_1 * ( e_2 * e_3 ) & \approx ( e_1 * e_2 ) * e_3 \\
        e_1 + e_2  & \approx e_2 + e_1 \\
        e_1 * e_2  & \approx e_2 * e_1
\end{align}
from the equations 
\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X * 1 &\approx X \\
        X * ( Y + Z ) & \approx X * Y + X * Z \\
\end{align}

One way in which our language $\mathcal L$ is simple is that it does not contain variables. We will see how to add variables later. For now, the next question is an opportunity to think about this point.

**Question:** Can the equations 
\begin{align}
        X * ( Y * Z ) & \approx ( X * Y ) * Z \\
        X + Y  & \approx Y + X \\
        X * Y  & \approx Y * X
\end{align}
be derived from the equations 
\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X * 1 &\approx X \\
        X * ( Y + Z ) & \approx X * Y + X * Z \\
\end{align}
or can they not?

## Computational Interpretation: Rewriting to Normal Form

So far in this lecture all computation happened on the right-hand side of 
$$\sem{-}:\mathcal L\to \mathbb N$$

On the left-hand side, we only have a formal language and a set of equations that guarantee, according to Theorem 2, 
$$e_1 \approx e_2 \quad\Longleftrightarrow\quad \sem{e_1}=\sem{e_2}$$

But we already discussed in one of the first lectures the idea of turning equations into computation rules by reading them from left to right. We pick this idea up now again.

**Exercise:** You showed in a previous exercise that the proof of Theorem 1 only uses the equations
\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X * 1 &\approx X \\
        X * ( Y + Z ) & \approx X * Y + X * Z \\
\end{align}

Show that the proof of the theorem uses these equations only from left to right.

**Exercise:** Show that the previous exercise can be extended to a proof of the following theorem.

Theorem 3 below says that the rewrite rules
\begin{align}
        X + ( Y + Z ) & \to ( X + Y ) + Z \\
        X * 1 &\to X \\
        X * ( Y + Z ) & \to X * Y + X * Z \\
\end{align}

define an ARS $(\mathcal L,\to)$ such that the equivalence relations induced by $\to$ and $\sem{-}$ are the same. 

In symbolic notation we write this as 


**Theorem 3:** $\quad\quad\quad\quad\quad\quad\quad\quad e_1\stackrel{\ast}{\longleftrightarrow}e_2 \ \Leftrightarrow \ \sem{e_1}=\sem{e_2}$

**Activity:** Think about the similarity of Theorem 2 and 3.

**Remark:** The second theorem shows that the semantic normal forms of the first theorem are also syntactic normal forms (ie normal forms of $(\mathcal L,\to)$).

**Questions:** 
- What is needed to turn the ARS $(\mathcal L,\to)$ into an algorithm evaluating arbitary expressions $e$?
- How does the algorithm given by $\to$ compare to the one given by $\sem{-}$?

## Summary

While the example we considered is simple, the method is very general. 

A typical situation is as follows.

We start with a semantic domain $D$, for example, numbers and the task is to represent it in a computational way.

First, one develops a syntax that allows to denote all objects of $D$ by a term in a formal language $\mathcal L$. This denotation gives us a function 

$$\sem{-}:\mathcal L \to D$$

If  we have done our work well, $\sem{-}$ is defined by induction on the structure of $\mathcal L$, which in turn must be discovered from structure already contained in $D$. [^homomorphism] Typically, $\sem{-}$ will be surjective (all elements of $D$ can be represented by some term), but not injective (some elements are denoted by more than one term). 

This means that we do not yet fully capture $D$. What is lacking is to understand when two terms denote the element of $D$.

To solve this problem, we identify special terms, sometimes called "canonical terms" or "semantic normal forms", that we are going to use as "canonical representatives" of elements of $D$. In other words, we identify a function

$$\nf:D\to\mathcal L$$

which preserves the semantics in the sense that $\sem{nf(d)}=d$ for all $d\in D$.

The interesting, and sometimes difficult, step is now to identify a nice set of equations on terms that allows us to prove (using the rules of equational logic) 

$$ \nf(d)\approx d$$

for all $d\in D$.

Since the equations form an [equivalence relation]() on $\mathcal L$, we obtain a bijection, or [isomorphism](), 

$$\mathcal L/{\equiv} \;\longrightarrow \; D$$

which, from left to right is $\sem{-}$ and from right to left is $nf$.

This isomorphism establishes that up to the naming of elements the domain $D$ is the same the language of terms modulo the equations $\equiv$. 

In particular, all computations that can be done in the structure $D$ can be done by rewriting terms using the equations $\equiv$.





[^nbe]: A lot of graduate-level information on application of NBE and related topics is available at the webpage of the Summerschol on Metaprogramming. Already the page of [abstracts](https://www.cl.cam.ac.uk/events/metaprog2016/abstracts.html) is an interesting read, but there are also very good teaching materials. If you want to go deeper into this the [paper](http://homepages.inf.ed.ac.uk/wadler/papers/qdsl/pepm.pdf), available from [Wadler's homepage](http://homepages.inf.ed.ac.uk/wadler/) on how to apply these ideas to implement domains specific languages could be a good starting point. Elsewhere, [Dybier](http://www.cse.chalmers.se/~peterd/slides/Leicester.pdf) presents an introduction and [Abel](http://www.cse.chalmers.se/~abela/habil.pdf) gives an advanced treatment that also contains some historical and other remarks of general interest. 

[^bergman]: I found his discussion [starting after the proof on page 37](https://math.berkeley.edu/~gbergman/245/3.3.pdf) particularly insightful.

[^one]: The symbol "1" is overloaded as we use it both for a term of type `exp` and for the number $1\in \mathbb N$; similarly for "+".

[^refl]: The [rule of logic](https://hackmd.io/s/H1panO_um#Excursion-on-Equational-Logic) used here is (refl).

[^homomorphism]: We will learn later that this means that $\sem{-}$ is a [homomorphism]().


