# Lambda Calculus

Read [this lecture in HackMD](https://hackmd.io/eIL-haCIS7-q1ja8LAXy-Q?view).

**Learning Outcomes:** After having worked through the exercises and homework, students will be able to

- check that a string is a lambda calculus program,
- construct the abstract syntax tree of a lambda calculus program,
- interpret (=execute) a lambda calculus program.

**Remark:** A program is by definition syntactically correct (otherwise it is not a program in the first place). But we sometimes say "syntactically correct program" or 
"legal program" or "well-formed program" for emphasis. 


## The Syntax of Lambda Calculus

We will use what we learned in our [Short Introduction to Parsing](https://github.com/alexhkurz/programming-languages-2019/blob/master/lecture-1.2.md) in order to define our first programming language, the ***$\lambda$-calculus*** or ***lambda calculus***.

To this end we first have to give a grammar, which specifies all the legal programs that can be written in lambda calculus.

### Recaps

Recall from the [introduction](https://github.com/alexhkurz/programming-languages-2019/blob/master/lecture-1.1.md), that lambda calculus has only three programming constructs:

- **Abstraction:** If $e$ is a program (also called an expression in lambda calculus), possibly containing a variable $x$, then
$$\lambda x.e$$ is the program (or function), which has as a formal parameter $x$. This is called abstraction, because the program $\lambda x.e$ does not depend on $x$ anymore, $x$ is abstracted away. We will explain this in more detail below.

- **Application:** If $e_1$ and $e_2$ are programs then $$ e_1 e_2$$ is the program which applies the function $e_1$ to the argument $e_2$.

- **Variables:** The basic programs are just the variables.



Recall from the [Short Introduction to Parsing](https://github.com/alexhkurz/programming-languages-2019/blob/master/lecture-1.2.md) how to use define a language using BNF.

### The Grammar of Lambda Calculus

In textbooks and articles, one often finds the following 

**Definition 1:** The $\lambda$-calculus is the language defined by the grammar

$$ e ::= \lambda x.e \mid e\, e \mid x$$

where $x$ ranges over an infinite set, the elements of which are called variables.

**Exercise:** Compare the three bullet points above with $\ e ::= \lambda x.e \mid e e \mid x\ .$ Both have the same meaning. What are the advantages of the shorter notation? 

In BNFC, we write down the same definition slightly differently. Each rule gets a name and goes on a separate line. This then looks as follows.

**Definition 2:** The lambda calculus is the language defined by the folloing BNFC grammar

    EAbs.   Exp ::= "\\" Id "." Exp ;  
    EApp.   Exp ::= Exp Exp1 ; 
    EVar.   Exp1 ::= Id ;
    
    coercions Exp 1 ;
    
**Remark:** Most of the notation has been explained before. But some comments are in order. 

- Since $\lambda$ is not an ASCII character, we write `\` instead.

- Accordingly, we would have liked to write, in the first line, `Exp ::= "\" Id "." Exp`. But `\` is a special character that needs to be escaped, so writting `\\` in the BNF grammar has the effect that you can write `\` in the programs. 

- The reason for writing `Exp ::= Exp Exp1` instead of the simpler `Exp ::= Exp Exp` is the same why we wrote `Exp ::= Exp "+" Exp1` instead of `Exp ::= Exp "+" Exp` when defining a grammar for arithmetic expressions.

The differences between the mathematical notation and BNFC stem from the following observations. The mathematical notation is optimised for human readers and pen and paper mathematics. BNFC is written by humans but also processed by machines. 

**Remark:** At the moment, it looks like we cannot write very interesting programs as we have neither data types nor constructs like assignment or if-then-else or while. We will come back to this question soon. But we can ask which strings are legal programs and which are not, see the next

**Exercise:** Show that any of the following are lambda calculus expressions

    x
    x x
    x y
    x y z 
    \x.x
    \x.x x
    (\x (\y . x y)) (\x.x) z
    
What are the abstract syntax trees? 

**Exercise:** Show that the following are not lambda calculus expressions (according the BNFC grammar above)

    \ . x
    \ x y. x -- this will be a legal abbreviation later
    x \ y

What error message would you suggest a parser could return to the programmer? 

**Exercise:** Are the following lambda caclulus programs? If yes, write down the abstract syntax tree.
    
    x
    (x)
    x \ y . z
    x \y . z
    x \y.z
    \\ x . z
    x \ y \ z. z
    \x.\y. x y z
   
   
**Exercise:** Do the following expressions e1 and e2 have the same abstract syntax tree?
    
| e1| e2|
|:--:|:---:|
|\x.y|\ x . y |
|( x y ) | (x y)|
|( x y ) | (xy) |
|( x y ) z  |   x y z |
|x (y z)  |   x y z |
| x | (x) |
| \ x.x | \ y. y|

## Syntax of LambdaNat

Later in the course we will see why lambda calculus is Turing complete. Despite only having abstraction and application, a rich repertoire of data and control can be encoded, including data types such as Booleans, numbers, and lists as well as control flow operations such as if-then-else and loops/recursion.

For now, we go into a different direction. Instead of encoding the above in the lambda calculus, we extend the lambda calculus by further primitives. 

We start by extending the lambda calculus by natural numbers and we call this programming language **LambdaNat**.

The idea of how to add numbers is simple. If we restrict ourselves to the natural numbers, that is, the non-negative integers, we simply add one basic program and one rule to our definition of the lambda calculus. 

Numbers are special programs but not every program is a number. Numbers are defined as follows. 

- **Zero:** There is one basic number which we write as $0$ and pronounce as "zero". 
- **Successor:** If $n$ is a number, then $S n$ is a number.

**Remark:** It is important to understand that at the moment $0$ does not mean zero. It is just a symbol, which we could replace by any other symbol. We are defining a language here and are free to choose the syntax that we like. Similarly, $S$ is not a function that computes "plus one", even if we can think of it like this from the point of view of a user. From the point of view of the programming language, or from the point of view of the machine, $S$ is just a symbol and $S 0$, $SS0$, $SSS0$ etc are just a strings.

Now we can define the syntax of the programming language LambdaNat via the BNFC grammar



## Semantics of the Lambda Calculus

From the previous section, we know how to write a lambda calculus program. 

In this section, we will learn how to execute a well-formed lambda calculus program.

First, we need to make sure that we know how to rename formal parameters. For example, we have that

$$\lambda x.x=\lambda y.y,$$

that is, the formal parameter $x$ can be renamed to $y$ without changing the meaning of the lambda expression.

Since formal parameters can be renamed, we can always make them different from all other variables in the program.

This is important to define how lambda calculus programs compute. There is only one computation rule in the lambda calculus. It goes as follows.

If $\lambda x. e$ is a lambda term and $e'$ is another lambda term, then

$$(\lambda x. e) e'.$$ 


computes to $$e[e'/x]$$ which is our notation for the term $e$ where each occurrence of $x$ is substituted by $e'$.

For this computation step to be allowed, we assume that $x$ does not occur in $e'$. (If it did, we could rename $x$ in $\lambda x. e$ as $x$ is a formal parameter.)

To summarise, if $x$ does not occur in $e'$, then
$$(\lambda x. e) e' \ \rightarrow \ e[e'/x]$$


**Example:** 
- $(\lambda x. S x) S0 \ \rightarrow \ SS0$
- $(\lambda x. S x) Sx \ \rightarrow \ SSx$
- $(\lambda x. (\lambda y. x)) y \ \rightarrow \ \lambda z.y$

**Exercise:** Explain $\ (\lambda x. (\lambda y. x)) y \ \rightarrow \ \lambda z.y$. (Hint: Note that the formal parameter $y$ in $(\lambda x. (\lambda y. x))$ needs to be renamed.)



## Homework (to be revised)

- Read the lecture notes carefully. Work through all exercises. I would be grateful if you reported any typos or questions via [the issue tracker](https://github.com/alexhkurz/programming-languages-2019/issues).

- Read the [BNF Converter Tutorial](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) up to and including Section "The deeper semantics of precedence levels: dummy labels". Explain again why we use different levels of expressions in the grammar of the lambda calculus.
  
 - Run some programs in the [LambdaNat language](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lambda-Calculus/LambdaNat) (this needs Haskell installed, see the homework of the previous lecture). In particular, solve the exercises of this lecture with the help of the tool.


 - Write a program `plus_one.lc` in LambdaNat that adds +1 to a number. Test your program using the interpreter as in the previous item.
 
 - [Install BNFC](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md),  and parse some lambda expressions as in the [BNFC Self Check](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-example.md). Compare the abstract syntax trees produced by the parser with the parsing you have done by hand in the exercises above.

 
