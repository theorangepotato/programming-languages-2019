# Excursion on the rules of logic

[Last lecture](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/rkX-t-HdH) we looked in some detail at a proof stating that if a program is finitely branching then termination can always be shown by a measure function to the natural numbers. 

I want to use the opportunity to show you the patterns that arise when establishing an argument and then formalise them as rules of logic.

## Learning Outcomes

- To understand better how proofs work, to learn how to navigate a proof without getting lost.

- To understand that proofs are structured in the same way as programs, by nesting blocks:

  - In the same way as a new block in programming may introduce new local variables, a new block in a proof introduces new assumptions.
  - An inner block can refer to all variables/assumptions declared in the outer blocks.
  - Closing a block makes the variables/assumptions that are local to the block invisible to the outside.
  - While a program computes outputs from inputs, a proof computes a proof of the conclusion from proofs of assumptions.

- To train ourselves in the "double-think" between formalism (just following the rules) and meaning (being guided by what we want to achieve and understand). This double-think is as valuable a skill in programming as it is in maths.

- To learn the [rules of logic](https://github.com/alexhkurz/programming-languages-2019/blob/master/Gentzen-natural-deduction-rules.png), in the form of Gentzen's natural deduction.

- To explain the idea that all of formal, deductive reasoning can be reduced to [this small set of rules](https://github.com/alexhkurz/programming-languages-2019/blob/master/Gentzen-natural-deduction-rules.png). 

- We will see later that [this small set of rules](https://github.com/alexhkurz/programming-languages-2019/blob/master/Gentzen-natural-deduction-rules.png) is an inductive definition of the set of all provable statements in (as far as we know) all of mathematics.[^principia]


## Analysing a proof in detail

In the following I will provide a "director's commentary" on the proof from the [previous lecture](https://hackmd.io/s/S1KcSWeYQ).

While going along reading the commented proof, you may want to guess which steps are justified by which of [this small set of rules](https://github.com/alexhkurz/programming-languages-2019/blob/master/Gentzen-natural-deduction-rules.png). 

> Show: If $A$ is finitely branching and terminating, then there is a measure function $\phi:A\to\mathbb N$.

The next step needs no understanding, it is purely formal: To prove an implication, you assume the assumptions and show the conclusion.

> Assume: that $A$ is finitely branching and terminating.
>> Show that there is a measure function $\phi:A\to\mathbb N$. 
>> 

Here we need an idea as we have to show an existential statement ("there is"). You cannot come up with the definition wihtout understanding what is going on.

>> Define: $\;\phi(a)=|\{\,b\in A \mid a\stackrel{\ast}{\longrightarrow} b\}|$. 
>> 
>> Show: that $\;a\to b\Rightarrow\phi(a)>\phi(b)$.

Implication again, purely formal reasoning.

>> Assume: $\;a\to b$.
>>> 
>>> Show: $\;\phi(a)>\phi(b)$.
>>> 
>>>
>>>  This, in turn, means that we have to show the following two statements.


The next step consists of several smaller steps. The first one is still formal, but we need to know the definition of $|...|$. The second one is more subtle as we replace $>$ by $\supsetneqq$ and this only works if we know that the sets involved are finite. So compressing all of this in one step needs some mathematical experience. Finally, there is another purely formal reasoning step: We use that $\supsetneqq$ is really a conjunction of two statements and that proving a conjunction means to prove each conjunct separately.

>>> (One) $\{\,c\in A \mid a\stackrel{\ast}{\longrightarrow} c\}\supseteq \{\,d\in A \mid b\stackrel{\ast}{\longrightarrow} d\}$ 
>>> 
>>> This follows from $\stackrel{\ast}{\longrightarrow}$ being transitive.
>>>
>>> We showed (One).
>>> 
The last line above could be expanded with more detail. 

>>> (Two) There is $\;x\in \{\,c\in A \mid a\stackrel{\ast}{\longrightarrow} c\}$ and $x\notin \{\,d\in A \mid b\stackrel{\ast}{\longrightarrow} d\}$.
>>> 
>>> To show that such an $x$ exists means to show that
>>> there is $\; x \in A$ such that $a\stackrel{\ast}{\longrightarrow}x$ and not $b\stackrel{\ast}{\longrightarrow} x$. 

An existential statement again. Again we need an idea. Here we see a good example of double-think. One can guess that it is $x=a$ that is needed both by looking at the data available and by understanding what is going on. If you can combine both ways of thinking you have a clear advantage.

>>> Define: $\; x=a$.[^thereisx] We need to check two statements.
>>>
>>> (First) Show: $a\stackrel{\ast}{\longrightarrow}a$.
>>> 
>>>  This follows because $\stackrel{\ast}{\longrightarrow}$ is  reflexive by definition.
>>>
>>> We showed (First).
>>> 
>>> (Second) Show: not $b\stackrel{\ast}{\longrightarrow}a$.
>>> 
>>> We argue by contradiction.

To show a negation, one reasons by contradiction.

>>> Assume: $b\stackrel{\ast}{\longrightarrow}a$.
>>>> Show: contradiction.
>>>> 
>>>>  We have $a\stackrel{+}{\longrightarrow}a$.
>>>> 
>>>>Which contradicts that $(A,\to)$ is terminating.
>>>>
>>> We showed (Second): not ($b\stackrel{\ast}{\longrightarrow}a)$.
>>>

The rest is easy. As in programming, we should just check that all blocks close properly.

>>> We showed (First) and (Second).
>>>
>>> We showed (Two).
>>> 
>>> We showed $\;\phi(a)>\phi(b)$.
>>
>> We showed $\;a\to b\Rightarrow\phi(a)>\phi(b)$. 
>>
>> We showed that there is a measure function $\phi:A\to\mathbb N$.
>> 
> We showed the theorem.

**Remark:** It is interesting to speculate whether the more concise proof or the proof with more detail is easier to understand. The short proof leaves more details for the reader to fill in. The longer proof drowns the ideas in lots of "bureaucracy". Ultimately, I believe, the answer must be to master the double-think: To be able to switch between a high and a low level of abstraction effortlessly. This is similar to listening to polyphonic music: Our brains are not made for following several tunes at the same time. Maths and programming need a similar effort if one wants to appreciate their beauty.


## The rules of logic

The purely formal, idea-free content of the above proof can be condensed into a set of formal rules, the [rules of logic](https://github.com/alexhkurz/programming-languages/blob/master/Gentzen-natural-deduction-rules.png).

Let us go over a few of them.

### Universal quantifier

The following explains the rule called $\forall$-$I$ in [Gentzen](https://github.com/alexhkurz/programming-languages/blob/master/Gentzen-natural-deduction-rules.png). Suppose the claim we want to prove is of the form [^forall]
$$\forall x \,.\, F(x)$$ 

where $F(x)$ is a property that depends on $x$.

For example, if $A$ and $B$ are sets, we may want to prove $\;A\subseteq B\;$, that is, $$\forall x\,.\, x\in A \Rightarrow x\in B$$

The rule of reasoning in this case is simple: 

|$\quad$$\quad$$\quad$$\quad$$\quad$ Assume that we have an $a$, then show $F(a)$ $\quad$$\quad$$\quad$$\quad$$\quad$|
|:---------------------------------------------:|

Or in symbolic notation:

$$\frac{F(a)}{\forall x\,.\, F(x)}$$

Notice that there is an important side-condition, namely that we need to choose a name $a$ that has not been used before. We say that $a$ is ***fresh***.




### Implication

The following explains the rule called $\supset$-$I$ in [Gentzen](https://github.com/alexhkurz/programming-languages/blob/master/Gentzen-natural-deduction-rules.png). Suppose the claim is $$A\Rightarrow B$$

The rule is:

| $\quad$$\quad$$\quad$$\quad$ Assume $A$,  then show $B$ $\quad$$\quad$$\quad$$\quad$|
|:---------------------------------------------:|

Or in symbolic notation:


$$\frac{\stackrel{[A]}{B}}{A\Rightarrow B}$$


### Existential quantifier

Suppose the statement is $$\exists y\,.\,P(y)$$

The rule in this case asks us to identify (define) a particular $a$ and then show that $a$ has property $P$, that is, that $P(a)$.

| $\quad$$\quad$$\quad$$\quad$ Define $a$,  then show $P(a)$ $\quad$$\quad$$\quad$$\quad$|
|:---------------------------------------------:|

Or in symbolic notation:

$$\frac{F(a)}{\exists x\,.\,F(x)}$$

## Exercises

**Exercise**: Find examples of applications of these rules in the proof of the theorem. 

**Exercise**: Which of the other rules of [Gentzen](https://github.com/alexhkurz/programming-languages-2019/blob/master/Gentzen-natural-deduction-rules.png) can you identify in the proof of the [previous lecture](https://hackmd.io/s/S1KcSWeYQ)?

**Exercise:** Think about the following: Is it possible to reduce all steps in [this proof](https://hackmd.io/s/S1KcSWeYQ) to an application of one of [this rules](https://github.com/alexhkurz/programming-languages-2019/blob/master/Gentzen-natural-deduction-rules.png)? What about other proofs or even all proofs?

**Exercise**: Give a formal proof, using [Gentzen rules](https://github.com/alexhkurz/programming-languages-2019/blob/master/Gentzen-natural-deduction-rules.png), that every number divisible by 4 is divisible by 2. You may use the laws of arithmetic freely. [Hint: $x$ is divisible by $n$ can be formalised as $\exists y\,.\, x=n\cdot y$.]


## References

[All rules](https://github.com/alexhkurz/programming-languages/blob/master/Gentzen-natural-deduction-rules.png) as given by Gentzen. The [original paper](https://gdz.sub.uni-goettingen.de/download/pdf/PPN266833020_0039/PPN266833020_0039.pdf) and a link to an [English translation](https://www.cs.cmu.edu/~crary/819-f09/Gentzen35.pdf).

The style of writing proofs with indentation is due to [Fitch](https://en.wikipedia.org/wiki/Fitch_notation), a summary of the rules is [here](http://www.math.mcgill.ca/rags/JAC/124/Rules-Strategy-b.pdf) and there are also [latex macros for writing Fitch style proofs](https://www.mathstat.dal.ca/~selinger/fitch/).

An excellent (maybe the best ever (?)) popular science book on formal systems is [Goedel Escher Bach](https://en.wikipedia.org/wiki/G%C3%B6del,_Escher,_Bach).

[^principia]: The idea that mathematics can be reduced to logic (in the sense discussed here) is the central message of Russel and Whitehead's [Principa Mathematica](https://en.wikipedia.org/wiki/Principia_Mathematica). But it was Gentzen who found this beautifully simple set of rules called ***Natural Deduction***.

[^forall]: $\forall x$ is short for "forall $x$". 


