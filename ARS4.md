# Abstract Reduction Systems 4: Termination (Finitely Branching Systems)


## Learning Outcomes

- to understand that the methodology underlying the construction and verification of a mathematical proof is very similar to the methodology behind the design and execution of programs. It consists of 
  
  - analysing the problem into its basic constituents
  - solving/translating the basic constituents
  - synthesizing the solution from solutions of the smaller problem

- to recognize that this pattern of (i) analysis, (ii) base case, (iii) synthesis is exactly the pattern that is used in recursion as a programming technique.

-  to appreciate that this pattern corresponds to items 2 to 4 of [Descartes' scientific method](https://en.wikipedia.org/wiki/Discourse_on_the_Method#Part_II:_Principal_rules_of_the_Method), see also our [Excursion on Algebra](https://github.com/alexhkurz/programming-languages-2019/blob/master/lecture-5.1.md#algebra) for some background.

## Finitely Branching ARSs

We continue from the [previous lecture]().

**Definition:** An ARS $(A,\to)$, or sometimes its relation $\to$, is called finitely branching if for all $x$ there are only finitely many $y$ such that $x\to y$.

**Theorem:** Let $(A,\to)$ be a finitely branching ARS. The ARS is terminating if and only if there is a measure function $\phi: A \to \mathbb N$ .

*Proof:* "if" has been discussed in a previous lecture. 

"only if:" That is the interesting direction here.

Let us first look at an argument as you might find it in a textbook.[^baader-nipkow]

[^baader-nipkow]: See also Lemma 2.2.3 in Baader-Nipkow.

>We have to find a measure function $\phi:A\to\mathbb N$. Define $\phi(a)=|\{\,b\in A \mid a\stackrel{\ast}{\longrightarrow} b\}|$. This is well-defined since $\{\,b\in A \mid a\stackrel{\ast}{\longrightarrow} b\}$ is finite due to $A$ being finitely branching and terminating. It remains to show that $a\to b$ implies $\phi(a)>\phi(b)$. Since $\stackrel{\ast}{\longrightarrow}$ is transitive, we have $\phi(a)\ge\phi(b)$. Now suppose $\phi(a)=\phi(b)$. Then $b\stackrel{\ast}{\longrightarrow} a$ in contradiction to $(A,\to)$ being terminating.

Sometimes a more concise write-up can be easier to understand than an argument that provides all details. On the other hand, one cannot claim to fully understand an argument without being able to provide all details. I show you how such a more detailed write-up could look like.[^markdown] It is also an opportunity to learn the patterns that are used in proofs. And it is closer to what we have done in class.

> Show: If $A$ is finitely branching and terminating, then there is a measure function $\phi:A\to\mathbb N$.
>
> Assume: that $A$ is finitely branching and terminating.
>> Show that there is a measure function $\phi:A\to\mathbb N$. [^thereisphi][^defphi]
>> 
>> Define: $\;\phi(a)=|\{\,b\in A \mid a\stackrel{\ast}{\longrightarrow} b\}|$. [^lemma]
>> 
>> Show: that $\;a\to b\Rightarrow\phi(a)>\phi(b)$.
>>
>> Assume: $\;a\to b$.
>>> 
>>> Show: $\;\phi(a)>\phi(b)$.
>>> 
>>>  This, in turn, means that we have to show the following two statements.[^bydefofphi]
>>>
>>> (One) $\{\,c\in A \mid a\stackrel{\ast}{\longrightarrow} c\}\supseteq \{\,d\in A \mid b\stackrel{\ast}{\longrightarrow} d\}$ [^one]
>>> 
>>> We showed (One).
>>> 
>>> This follows from $\stackrel{\ast}{\longrightarrow}$ being transitive.[^bytransitivity]
>>>
>>> (Two) There is $\;x\in \{\,c\in A \mid a\stackrel{\ast}{\longrightarrow} c\}$ and $x\notin \{\,d\in A \mid b\stackrel{\ast}{\longrightarrow} d\}$.
>>> 
>>> To show that such an $x$ exists means to show that
>>> there is $\; x \in A$ such that $a\stackrel{\ast}{\longrightarrow}x$ and not $b\stackrel{\ast}{\longrightarrow} x$. 
>>>
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
>>> We argue by contradiction.[^contradiction]
>>> 
>>> Assume: $b\stackrel{\ast}{\longrightarrow}a$.
>>>> Show: contradiction.
>>>> 
>>>>  We have[^nontermination] $a\stackrel{+}{\longrightarrow}a$.[^plustoo]
>>>> 
>>>>Which contradicts that $(A,\to)$ is terminating.
>>>>
>>> We showed (Second): not $b\stackrel{\ast}{\longrightarrow}a$.
>>>
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

**Remark:** Note how this is similar to programming.
- First, the structure of the proof follows the structure of the parse-tree of the statement. For example, the parse-tree has $\Rightarrow$ at the top, so we start the proof with an assumption.
- Second, the rules of logic we apply are similar to the rules of lambda calculus defining the interpreter of `LambdaNat`. For example, the rule for $\Rightarrow$ tells us that after assuming the assumptions, we need to prove the conclusion, which is in case of the outer $\Rightarrow$ the statement that there is a measure function.
- Implications ($\Rightarrow$) are similar to function definitions in that we use indentation to mark assumptions. 
- The "We showed P" statements are similar to return statements.

We will have a look at the logic behind this argument in the [next lecture]().

[^markdown]: In a pen and paper proof, I would not normally use indentation as below, but markdown conveniently provides this feature and I think it helps emphasizing the analogy with programming.

[^thereisphi]: We need an idea. In class, we drew a picture, picking an element $a\in A$, and drawing an example relation $\to$. After a while we found the idea that it follows from finitely branching and terminating that there are only finitely many elements reachable from $a$. This gave us the idea to define $\phi(a)$ as the number of elements reachable from $a$. That is, $\phi(a)=|\{\,b\in A \mid a\stackrel{\ast}{\longrightarrow} b\}|$.

[^lemma]: Lemma: If $(A,\to)$ is finitely branching and terminating, then $\{b\mid a\stackrel{\ast}{\longrightarrow} b\}$ is finite for all $a\in A$.

[^defphi]: Defining a function $\phi$ that satisfies $a\to b\Rightarrow\phi(a)>\phi(b)$ is analogous to implementing a program that satisfies that requirement. But notice how much simpler it is to define $\phi$ in mathematical notaion rather than implementing a function that actually computes the set of reachable elements. This is a nice  example of the power of mathematics as a specification language. 

[^bydefofphi]: By definition of $\phi$. We use that $|C|>|B|$ if and only if $C\supsetneqq B$ if and only if $C\supseteq B$ and $\exists x\in C\,. x\notin B$. (We assume here that $B$ is finite. )

[^one]: In words: Everything reachable from $b$ is reachable from $a$.

[^bytransitivity]:  The general pattern to show a statement of the form $D\subseteq C$ is to assume $d\in D$ and to show $d\in C$. Here, we assume $b\stackrel{\ast}{\longrightarrow}d$. We also know $a\to b$. Then $a\stackrel{\ast}{\longrightarrow} d$ by transitivity. 

[^plustoo]: The notation $a\stackrel{+}{\longrightarrow} a$ means exactly that there is cycle from $a$ to $a$.

[^contradiction]: The general pattern to prove a negative statement such as "not $b\stackrel{\ast}{\longrightarrow}a$" is to assume the statement and derive a contradiction.

[^thereisx]: How do we find such an $x$? I would suggest to draw a picture of the situation. But also if just make a guess, $x=a$ is an obvious one to try.

[^nontermination]:  We assumed (see further above) that $\; a\to b\;$ and also assumed that $\;b\stackrel{\ast}{\longrightarrow} a$. Now use transitivity.
