

$\newcommand{\sem}[1]{[\![#1]\!]}$
# Meaning in Syntax

In [a previous lecture]() we gave meaning to a formal language by mapping it to a structure we were familiar with, in our case the natural numbers or a computing machine.

Is there way of capturing the meaning that resides in the mapping $\sem{-}$ by staying completely on the syntactic side?

Obviously impossible?

Yes, when we think eg about sending DNA into outer space. Even if a superintelligence would discover our DNA, they would not be able to learn much about us from it. The meaning of DNA relies on a sophisticated environment surrounding it.

But maths could be different. I believe we have some evidence that the maths is the same throughout the universe. So there is some hope to represent maths in some objective way ... I am speculating here and we can come back to the question later ... 

But the speculations of the previous paragraph are relevant to our endeavour of making machines perform meaningful tasks: How do we make machines perform meaningful tasks, if the machines cannot understand the meaning of what they  should do? The basic idea is that we make the machines follow rules that are clearly specified. But then the question is: How do we make sure that the rules capture what we mean? One big idea tackling this question is our topic here.

To simplify the big question, let us concentrate on one example:

Can we capture the maths of numbers by pure syntax? [^first]

Let us [recall](https://hackmd.io/hILQksyiTUW4mXxxOSF7eQ)  the formal language [^second]

        exp ::= num | exp + 1 | exp + exp | exp * exp
        
and its semantics

$$\sem{-} :\mathcal L \to \mathbb N$$

which maps an expression to the corresponding number. For example, $(1+1)+1$ and $1+(1+1)$ are mapped the same number 3, but are different expressions. 

We will now revisit our discussion of [syntax, semantics, soundness, complete](https://hackmd.io/hILQksyiTUW4mXxxOSF7eQ) in the light of what we learned about [equivalence relations](https://hackmd.io/s/B1gOX4lO7). The crux of the matter is the following

**Exercise:** 
- Let $f:A\to B$ be a function. Show that 
$$a\equiv a' \ \stackrel{\rm def}{=} \ f(a)=f(a')$$  
defines an equivalence relation, the ***equivalence relation induced by*** $f$.

- Show that if $f$ is onto, then the induced function $$A/{\equiv}\to B$$ is a bijection.

Why is it important to know that we get a bijection? Because this says that there is a perfect correspondence (one-to-one and onto) between $A/{\equiv}$ and $B$. In other words, up to naming conventions, $A/{\equiv}$ are exactly the same $B$ sets.


We now apply this to the meaning-function

$$\sem{-} :\mathcal L \to \mathbb N$$

and we see that the set $\mathcal L/{\equiv}$ of equivalence classes is, up to renaming of the elements, the same as $\mathbb N$. 

In other words, if we are able to describe $\equiv$ by a set of rules, then we have captured the semantics $\mathbb N$ by pure syntax, amenable to computations by a machine.

So can we describe $\equiv$ by a set of rules?

Yes, we can!


Because ... the equivalence relation induced by $\sem{-}$ is given by the familiar equations

\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X \cdot 1 &\approx X \\
        X \cdot ( Y + Z ) & \approx X \cdot Y + X \cdot Z \\
        X \cdot ( Y \cdot Z ) & \approx ( X \cdot Y ) \cdot Z \\
        X + Y  & \approx Y + X \\
        X \cdot Y  & \approx Y \cdot X
\end{align}

**Question:** Are all equations above needed? Is there one missing?

**Remark:** In the [discrete maths lecture](https://hackmd.io/s/B1gOX4lO7) we not only learned about equivalence relations but emphasised equivalence relations that are the equivalence closure $\stackrel{\ast}{\leftrightarrow}$ of a "one-step-computation" relation $\to$. During the next lectures, we will investigate when such a relation can be used to "rewrite to unique normal form". This is important: If every equivalence class has a unique normal form, then this normal form can be used to represent every element in the class. For example, write $n$ for  the normal form of the equivalence class of elements $e$ such that $\sem{e}=3$. We then can identify $n$ with $3$, or, in other words, we can consider $n$ just as a different notation, or encoding, of 3 itself. Thus, as a slogan, what was syntax has become semantics. We have found meaning in syntax.

[^first]: Of course, everybody who has ever used a calculator knows that the answer is yes. But let us forget for a moment that we know the answer in this example. Let us start thinking from scratch and discover a big idea that also applies to much more difficult examples.

[^second]: I slightly simplified the grammar by putting everything in one line. It is safe to ignore this difference for the current discussion.