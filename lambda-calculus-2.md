# Lambda Calculus 2

(To be [read in HackMD](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/SyDa-43BB).)

**Learning Outcomes:** After having worked through the exercises and homework, students will be able to

- explain and perform capture avoiding substitution, 
- interpret (=execute) lambda calculus programs.


## Semantics of the Lambda Calculus

From the previous section, we know how to write a lambda calculus program. In this section, we will learn how to execute it.

### An Example of Substitution

Before getting into the technicalities, let us start with an example. For this, we add addition and multiplication and as many numbers as we want to the lambda calculus.

  $$e ::= \lambda x.e \mid e\, e \mid x \mid e+e \mid e*e \mid 0 \mid 1 \mid 2 \mid 3 \mid 6 \mid 7$$
  
**Exercise:** Write in the syntax above the familiar mathematical function $f(x)=2*x +1$.

Now let us see how a computation in arithmetic would work. If we want to apply the function $f$ from the previous exercise to an argument such as 3, we compute

\begin{align}
f(3) & = 2*3 + 1 \\
& = 6+1 \\
& = 7
\end{align}

In this lecture we are working to generalise the first computation step 

$$f(3) \to 2*3 + 1$$

to lambda calculus. We write $\rightarrow$ now instead of = to emphasise that computation runs in time and that, typically, computations cannot be run backwards. (Btw, reversible computing is a very interesting topic, let me know if you want to know more.) 

**Remark:** The computation step $f(3) \to 2*3 + 1$ merely **substitutes 3 for $x$ in $f$**, which we will write as $f[3/x]$. Next week, we will see that even the computation steps $2*3+1\to 6+1\to 7$ can be performed by substitution only.

So how would the substitution $f(3) \to 2*3 + 1$ look in lambda calculus? 

Not much different actually:

$$(\lambda x. 2*x+1)\, 3 \to 2 * 3 + 1$$

The only visible difference is that we replaced the name $f$ by its denotation $\lambda x. 2*x+1$.

To summarize, substitution so far is is only replacing a placeholder (formal parameter) by an argument.

### An Example of a Function with Two Arguments

The function that adds two numbers can be written as

$$\lambda x. \lambda y. x+y$$

and we apply it to two arguments as follows

$$(\lambda x.\lambda y. x+y) \ 2 \ 3 $$

**Reminder:** According to the rules fordropping parentheses, this is short for $$((\lambda x.(\lambda y. x+y)) \ 2) \ 3$$

**Question:** Do we need a new substitution rule that can deal with simultaneously substituting two arguments? 

No, we just keep everything as it is and apply the  substitution rule twice:

\begin{align}
(\lambda x.\lambda y. x+y) \ 2 \ 3
& \to (\lambda y. 2+y) \ 3\\
& \to 2+3 \\
\end{align}

Note that we applied the "inner substitution" 

$$ (\lambda x.\lambda y. x+y) \ 2 
\to (\lambda y. 2+y) $$

first, while leaving the "3" untouched. 

**Remark:** A familiar idea here is to perform reductions inside bigger expressions. For example, above, in 
\begin{align}
f(3) & \to 2*3 + 1 \\
& \to 6+1 \\
& \to 7
\end{align}
the second "$\to$" reduces $2*3$ to $6$ inside a bigger expression.

**Remark:** A new idea here is that expressions can reduce to functions. For example, above, in 
\begin{align}
(\lambda x.\lambda y. x+y) \ 2 \ 3
& \to (\lambda y. 2+y) \ 3\\
& \to 2+3 \\
\end{align}
the result of the inner substitution is the function $\lambda y.2+y$, which in turn is applied to the second argument.

**Terminology (Currying):** To replace a function in two arguments by a function that takes one argument and returns a function that takes the second argument is called "currying" after the mathematician and logician [Haskell Curry](https://en.wikipedia.org/wiki/Haskell_Curry).

**Exercise:** Reduce the following. 
\begin{gather}
(\lambda x.\lambda y. x+y) \ 2 \ 3 \\
(\lambda x.\lambda y. y+x) \ 2 \ 3 \\
(\lambda x.\lambda y. x+x) \ 2 \ 3 \\
(\lambda x.\lambda y. y+y) \ 2 \ 3 \\
(\lambda x.\lambda y. z+z) \ 2 \ 3 
\end{gather}

### An Example of Capture Avoiding Substitution

The only way two lambda calculus programs $M$ and $N$ communicate with each other is via an application $(\lambda x.M) N$ . But what happens if there are [name clashes](https://en.wikipedia.org/wiki/Name_collision) between $\lambda x.M$ and $N$? Here is an example:

$$(\lambda x.\lambda y. x + y)\ y \ 2$$

The $y$ in $M=\lambda y. x + y$ means something differnt from the $y$ in $N=y$. We say that the $y$ in $M$ is *bound* and the $y$ in $N$ is *free*. We will learn more about free and bound variables later in the course. For now it is enough to understand that bound variables are formal parameters (and thus are mere place holders that do not have a meaning), whereas free variables have a meaning determined by the larger context in which the program exists.

**Exercise:** Keeping in mind that the meaning of the free occurrence of $y$ is determined by the larger context in which the program exists, what is wrong with the following computation? What would be the correct result?

**Example** of a **wrong** computation:
\begin{align}
(\lambda x.\lambda y. x + y)\ y \ 2 
& \to 
(\lambda y. y + y)\ 2 \\
& \to 
2 + 2 \\
& \to 
4
\end{align}

The problem with the computation above becomes apparent if we typeset the free $y$ in bold and compute
\begin{align}
(\lambda x.\lambda y. x + y)\ \mathbf y \ 2 
& \to (\lambda y. {\bf y} + y) \ 2
\end{align}
highlighting that the bold roman $\bf y$ is different from the italic $y$.

The solution to the problem then is to define substitution in such a way that variable $\bf y$ cannot be captured by the $\lambda y$, that is, we want a *capture avoiding substitution*.

But if substitution must be capture avoiding, how do we compute, for example,
$$(\lambda x.\lambda y. x + y)\  y \quad?$$

To answer this question, we recall that we can rename formal parameters. So we compute

\begin{align}
(\lambda x.\lambda y. x + y)\  y 
& = 
(\lambda x.\lambda z. x + z)\  y \\
& \to  \lambda z. y + z
\end{align}

where the first step only renames the formal parameter (=bound variable) $y$ into $z$.

### Renaming Formal Parameters

First, we need to make sure that we know how to rename formal parameters. For example, we have that

$$\lambda x.x=\lambda y.y,$$

that is, the formal parameter $x$ can be renamed to $y$ without changing the meaning of the lambda expression. We also say that $\lambda x.x$ and $\lambda y.y$ are *alpha-equivalent*.

Since formal parameters can be renamed, we can always make them different from all other variables in the program.

This is important to define how lambda calculus programs compute. There is only one computation rule in the lambda calculus. It goes as follows.

### The Computation Rule: $\beta$-Reduction


If $\lambda x. M$ is a lambda term and $N$ is another lambda term, then

$$(\lambda x. M) N$$ 


computes to $$M[N/x]$$ which is our notation for the term $M$ where each occurrence of $x$ is substituted by $N$. 

For this computation step to be allowed, we assume that 

  - the formal parameters of $M$ do not occur in $N$,
  
  - the formal parameters of $M$ are all different.
  
(If this is not the case we can rename the formal prameters.)


In short we write

$$(\lambda x. M) N \ \rightarrow \ M[N/x]$$ 

and say this as

$$\textrm{Replace} \  x \ \textrm{in} \ M \ \textrm{by} N$$

or also 

    Replace the formal parameter in the body of the function
    by the argument.

To remember this as a text can make finding the right pattern matching for the substitution easier:

**Example:** In
$(\lambda x. \lambda y. x) a b$ the formal parameter is $x$ and the argument is $a$. So we replace $x$ in $\lambda y.x$ by $a$ and get $(\lambda y. a) b$ in the first computation step. Now the formal parameter is $y$ and the argument is $b$. Since $b$ does not occur in the body $a$, replacing $y$ in $a$ by $b$ does not change $a$ and the result is simply $a$ itself.







**Exercise:** Reduce the following (where "S" is a new constant (think of $S$ as "successor" or "plus one")):
- $(\lambda x. S x) S0$
- $(\lambda x. S x) Sx$
- $(\lambda x. (\lambda y. x)) y$

**Exercise:** Explain why we need to rename variables before being able to reduce $\ (\lambda x. (\lambda y. x)) y$. 


### Another Example on Capture Avoiding Substitution 

This example illustrates a subtle point about renaming variables. If you find it confusing right now rest assured that we will come back to it later.

\begin{align}
(\lambda x.\lambda y. x)\,M\,N & \to (\lambda y. M)N \\
& \to M
\end{align}

Let us comment on the two reductions in turn.
- The first reduction shows that we are allowed to apply reductions to subterms. In this case, since we can reduce $$(\lambda x.(\lambda y. x))M\to \lambda y. M$$

  we can also do this reduction inside a bigger term such as
$$((\lambda x.(\lambda y. x))M)N\to (\lambda y. M)N$$

- The second reduction is only correct if we can assume that $y$ does not occur in $M$. [^correct] Do we need to make this assumption? No, because the first reduction $(\lambda x.(\lambda y. x))M\to \lambda y. M$ substituted $M$ in a capture avoiding way. Other phrases to express this include
  - the binder $\lambda y$ does not capture free variables in $M$,
  - $y$ is not free in $M$,
  - $y$ is fresh for $M$.
  
## Solution to selected Exercises

$f(x)=2*x +1$ can be written as $\lambda x.2*x+ 1$.

The following computation is correct:
\begin{align}
(\lambda x.\lambda y. x + y)\ y \ 2 
& \to 
(\lambda z. y + z)\ 2 \\
& \to 
y + 2 
\end{align}

## Homework 

- Read the lecture notes carefully. Work through all exercises. I would be grateful if you reported any typos or questions via [the issue tracker](https://github.com/alexhkurz/programming-languages-2019/issues).

- Run the [LambdaNat parser and interpreter](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lab1-Lambda-Calculus/LambdaNat0/README.md) on the following programs, see also [exercises.lc](). Run the program only after predicting the result. Compare your prediction with actual result.

      (\x.x) a         
      \x.x a           
      (\x.\y.x) a b    
      (\x.\y.y) a b    
      (\x.\y.x) a b c  
      (\x.\y.y) a b c  
      (\x.\y.x) a (b c)
      (\x.\y.y) a (b c)
      (\x.\y.x) (a b) c
      (\x.\y.y) (a b) c
      (\x.\y.x) (a b c)
      (\x.\y.y) (a b c)
           




 - (We will answer this next week in detail:) Think about how you would write a program `plus_one.lc` in LambdaNat that adds +1 to a number. 
 

 
