# Lambda Calculus

## The Syntax of Lambda Calculus

We will use what we learned in our [Short Introduction to Parsing]() in order to define our first programming language, the ***$\lambda$-calculus*** or ***lambda calculus***.

To this end we first have to give a grammar, which specifies all the legal programs that can be written in lambda calculus.

### Recaps

Recall from the [introduction](), that lambda calculus has only three programming constructs:

- **Abstraction:** If $e$ is a program (also called an expression in lambda calculus), possibly containing a variable $x$, then
$$\lambda x.e$$ is the program (or function), which has as a formal parameter $x$. This is called abstraction, because the program $\lambda x.e$ does not depend on $x$ anymore, $x$ is abstracted away. We will explain this in more detail below.

- **Application:** If $e_1$ and $e_2$ are programs then $$ e_1 e_2$$ is the program which applies the function $e_1$ to the argument $e_2$.

- **Variables:** The basic programs are just the variables.


Recall from the [Short Introduction to Parsing]() how to use define a language using BNF.

### The Grammar of Lambda Calculus

In textbooks and articles, one often finds the following 

**Definition 1:** The $\lambda$-calculus is the language defined by the grammar

$$ e ::= \lambda x.e \mid e\, e \mid x$$

where $x$ ranges over an infinite set, the elements of which are called variables.

**Exercise:** Compare the three bullet points above with $$ e ::= \lambda x.e \mid e e \mid x.$$ Both have the same meaning. What are the advantages of the shorter notation? 

In BNFC, we write down the same definition slightly differently. Each rule gets a name and goes on a separate line. This then looks as follows.

**Definition 2:** The lambda calculus is the language defined by the grammar

    EAbs.   Exp ::= "\\" Id "." Exp ;  
    EApp.   Exp ::= Exp Exp1 ; 
    EVar.   Exp1 ::= Id ;
    
**Remark:** Most of the notation has been explained before. But some comments are in order. 

- Since $\lambda$ is not an ASCII character, we write `\` instead.

- Accordingly, we would have liked to write, in the first line, `Exp ::= "\" Id "." Exp`. But `\` is a special character that needs to be escaped, so writting `\\` in the BNF grammar has the effect that you can write `\` in the programs. 

- The reason for writing `Exp ::= Exp Exp1` instead of the simpler `Exp ::= Exp Exp` is the same why we wrote `Exp ::= Exp "+" Exp1` instead of `Exp ::= Exp "+" Exp` when defining a grammar for arithmetic expressions.

The differences between the mathematical notation and BNFC stem from the following observations. The mathematical notation is optimised for human readers and pen and paper mathematics. BNFC is written by humans but also processed by machines. 


