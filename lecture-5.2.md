
$\newcommand{\sem}[1]{[\![#1]\!]}$ 

# Currently planned as Lecture 5.2
# Syntax, Semantics, Soundness, Completeness

"In a rough and ready sort of way it seems to me fair to think of the semantics as being what we want to say and the syntax as how we have to say it." 

Christopher Strachey, a pioneer of programming languages, in his seminal paper [Fundamental Concepts in Programming Languages
](https://www.cs.cmu.edu/~crary/819-f09/Strachey67.pdf)

## Learning Outcomes

Students will be able to explain two concepts central to the field of Programming Languages, namely *denotational and operational semantics*, at hand of the simple example of the language of arithmetic.

## Questions
- What is meaning?
- Where does meaning come from?
- How do we give meaning to a sequence of (apparently meaningless) symbols?
- If computation consists of the blind application of formal rules, then how can computations mean anything?

## Recap from the previous lecture

**Homework from the last lecture:** For the grammar with multiplication 

       exp ::= num | exp + exp | exp * exp

we can do the computation 

      (1+1)*((1+1)+1) = (1+1)*(1+1)+(1+1)*1
                      = (1+1)*(1+1)+(1+1)
                      = ((1+1)*1+(1+1)*1)+(1+1)
                      = ((1+1)*1+(1+1))+(1+1)
                      = ((1+1)+(1+1))+(1+1)
                      = (((1+1)+1)+1)+(1+1)
                      = ((((1+1)+1)+1)+1)+1

if we have the equations/computation rules/rewrite rules

	X * 1 = X
	X * ( Y + Z ) = X * Y + X * Z
    
Can you think of an example that needs the following equation?

    X + Y = Y + X
    X * Y = Y * X
    X * ( Y * Z ) = ( X * Y ) * Z 

How do we know when we have enough equations? What equations need to be added if we want a unary operation `+1`?


## Syntax
 
Recall the grammar 

        exp ::= 1 | exp + exp | exp * exp
         

## Equations and Computations

Next we added equations ... we now take the full list for `+` and `*`

        X + ( Y + Z ) = ( X + Y ) + Z
        X * 1 = X
        X * ( Y + Z ) = X * Y + X * Z
        X * ( Y * Z ) = ( X * Y ) * Z
        X + Y  = Y + X
        X * Y  = Y * X
        
We have seen how to use the equations to compute. We have also seen that we can give a direction to the equations to implement an interpreter. 

**Remark:** Note that the variables `X, Y, Z` are not part of our language of arithmetic. They are merely place holders for the terms (ie expressions) of the language. 

**Question:** Equations introduce a philosophical problem. On the one hand, 3+2=5. On the other hand, 3+2 and 5 are certainly different expressions. How can we make sense of these different notions of equality?

And can we make sense of the following two questions:

        Are the equations true? (soundness of the equations)
        Did we write down enough equations? (completeness of the equations)

Of course, we learned in high-school maths that the equations are true. But, so far, we are just talking about a formal language. So if we can write

        X * 1 = X
        
then why not

        X + 1 = X ?

## Semantics

The big idea that is missing so far is how to give meaning to a language. We also say: What is the semantics of our formal language, what is the semantics of the syntax? 

Meaning comes from talking about something that everybody has agreed upon or understands. For us, there are two possibilities: We all understand (at least to some degree that should suffice for this course)

- discrete mathematics

- computing machines

In the first case we speak about mathematical or denotational semantics, in the second case of operational semantics. Both are two different but equivalent ways of explicating the meaning of a programming language.

### Denotational Semantics

Let us write $\mathcal L$ for the formal language of expressions given by the grammar for `exp` above.

Let $\mathbb N = \{1,2,3,\dots\}$ be the natural numbers.

The meaning function, or semantics,

$$\color{black}{\sem{-} :}\color{blue}{\mathcal L} \color{black}{\to} \color{red}{\mathbb N}$$

involves three different languages and we use, just for now, three different colours to help keeping them apart. $\color{blue}{\textrm{Blue}}$ to denote the formal language, $\color{red}{\textrm{red}}$ for the language of  mathematics (in our example just the natural numbers with addition and multiplication) and black for the informal "meta"-language in which we freely mix English with mathematical notation.

We can now define the meaning function $\sem{-}$ as

\begin{align}
\sem{\color{blue}1}& =\color{red}1\\
%\sem{\color{blue}{t+1}}& =\sem{\color{blue}t}\color{red}{+1 }\\
\sem{\color{blue}{t+t'}}&=\sem{\color{blue}t}\color{red}+\sem{\color{blue}{t'} }\\
\sem{\color{blue}{t*t'}}&=\sem{\color{blue}t}\color{red}\cdot\sem{\color{blue}{t'} }
\end{align}

To understand this definition, remember what you learned about induction on natural numbers in discrete mathematics. For natural numbers, we have two operations, the constant "0" and the successor "+1". In our case, the first equation is the base case, wherease the 2nd and 3rd are the ones that build bigger terms. Since expressions `exp` have two binary operations, an inductive definition over expressions  needs to have two cases for those. 

<!--(For more details see [the lecture on induction](https://hackmd.io/s/H1panO_um).)-->

**Remark:** Note that the definition of the function $\sem{-}$ is what we call ***structure preserving***: The $\color{blue}{+}$ on the left is mapped to a $\color{red}{+}$ on the right, etc. This principle is key to all of engineering in general. It is what allows us to build big systems from small systems and to control how the small systems interact. Here this general principle is visible in the simple fact that an equation such as $\quad\sem{\color{blue}{t+t'}}=\sem{\color{blue}t}\color{red}+\sem{\color{blue}{t'} }\quad$ explains the meaning of the "big system" $\;\sem{\color{blue}{t+t'}}\;$ as a function of the meanings of the "small systems" $\;\sem{\color{blue}t}\;$ and $\;\sem{\color{blue}{t'} }\;$. This principle is also called ***compositional semantics***. It plays a major role not only in computer science and other engineering disciplines but also in linguistics to explain the meaning of natural languages.


To get a feeling for how such an inductive definition works we do a little computation where we inductively/recursively decompose terms (**Exercise:** fill in the dots in the equational reasoning below.) until we can apply the base case and finally add up in the natural numbers.

\begin{align}
\sem{\color{blue}{((1+1)+1)+(1+1)}} 
& = \sem{\color{blue}{((1+1)+1)}}\color{red}{+}\sem{\color{blue}{1+1}} \\
& = \dots \\
& = \sem{\color{blue}{1}}\color{red}{+}
\sem{\color{blue}{1}}\color{red}{+}
\sem{\color{blue}{1}}\color{red}{+}
\sem{\color{blue}{1}}\color{red}{+}
\sem{\color{blue}{1}} \\
& = \color{red}{1}\color{red}{+}
\color{red}{1}\color{red}{+}
\color{red}{1}\color{red}{+}
\color{red}{1}\color{red}{+}
\color{red}{1} \\
& = \color{red}{5}\\
\end{align}

### Operational Semantics

We can also read the definition of $\sem{-}$ above as a program, a so-called interpreter, that evaluates expressions to numbers.

Here, blue is the programming language for which we write the interpreter, black is the programming language in which we write the interpreter, and red is the language of the machine on which the interpreter is running. 

In the operational interpretation of the equations, we read them from left-to-right as rules for rewriting expressions. Since the interpreter is running on the same machine that is adding the numbers, we do not need to distinguish black and red anymore and replace black by red.

Let us illustrate this with the example above again:

\begin{align}
\color{blue}{((1+1)+1)+(1+1)}
&  \color{red}{\to} \color{blue}{((1+1)+1)}\color{red}{+}\color{blue}{1+1} \\
& \color{red}{\to} \dots \\
& \color{red}{\to} \color{blue}{1}\color{red}{+}
\color{blue}{1}\color{red}{+}
\color{blue}{1}\color{red}{+}
\color{blue}{1}\color{red}{+}
\color{blue}{1} \\
& \color{red}{\to} \color{red}{1}\color{red}{+}
\color{red}{1}\color{red}{+}
\color{red}{1}\color{red}{+}
\color{red}{1}\color{red}{+}
\color{red}{1} \\
& \color{red}{\to} \color{red}{5}\\
\end{align}


## Soundness and Completeness

Having put in the work of making precise the meaning of our formal language, we can now also make precise our two quesitons from the beginning of the lecture. 

First recall the equations

\begin{align}
        X + ( Y + Z ) & \approx ( X + Y ) + Z \\
        X \cdot 1 &\approx X \\
        X \cdot ( Y + Z ) & \approx X \cdot Y + X \cdot Z \\
        X \cdot ( Y \cdot Z ) & \approx ( X \cdot Y ) \cdot Z \\
        X + Y  & \approx Y + X \\
        X \cdot Y  & \approx Y \cdot X
\end{align}

We now replace `=` by $\approx$ in order to emphasise that these equations are equations we impose on syntax. And on syntax 3+2 is different from 2+3. Nevertheless we can impose as a requirement that $3+2\approx 2+3$ and then use this knowledge to compute with or reason about the syntax.

A consequence of the equations above is that the syntax "modulo the equations" agrees exactly with semantics. 

For example, while $((1+1)+1)+(1+1)$ is different, as a string or a tree, from $(1+1)+((1+1)+1)$, we can now use the equation $X + Y \approx Y + X$ to compute/reason that 

$$((1+1)+1)+(1+1) \approx (1+1)+((1+1)+1)$$

which we know to be true for natural numbers.

In programming languages jargon, this agreement between syntax and semantics is formulated by saying that the equations are sound and complete.

But we still need to say what precisely we mean by equations being sound and complete:


##### Soundness: $\quad t\approx t' \ \Longrightarrow \ \sem{t}=\sem{t'} \quad$ for all $\ t,t'\in\mathcal L$.

##### Completeness: $\quad \sem{t}=\sem{t'} \ \Longrightarrow \ t\approx t' \quad$ for all $\ t,t'\in\mathcal L$.

##### Exercise:  
Convince yourself that the equations are sound.

##### Remark on Completeness:  

Remember how we came up with the language and the equations. We started from our knowledge of natural numbers and defined the formal language accordingly. Then we discovered the equations by needing them for computations/proofs. For example, we needed associativity to get 3+2=5. After adding multipliction, we also needed distributivity. And then we added some more equations we knew that were true. But how do we know that we have enough? How can we be sure that we can now do all computations in our language with this small number of equations? Or can we do with fewer equations? 

## Conclusion

**Activity:** Discuss inhowfar the following answers the questions from the beginning of the lecture.

If we need to bootstrap meaning from nothing, the best we can do is to find ways to directly represent the  structure of interest. 

For example, we can define numbers by saying that 0 is a number and if $n$ is a number then $Sn$ is a number (and nothing else is a number). 

Then we can give meaning to expressions `exp ::= 1 | exp + exp | exp * exp` by mapping them into numbers.

Alternatively, we can give meaning  to expressions by axiomatising their structure, that is, by writing out the equations for + and *.

Computations then capture meaning, because computations rely on the same equations that axiomatise the structure. 

## Homework: 

- (Essential.) Read the notes carefully and check that you can do all of the exercises.

- (Recommended.) Write a grammar and an interpreter for the language

        exp ::= 1 | exp + exp | exp * exp




