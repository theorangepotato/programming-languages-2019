# Lambda Calculus

If you are accessing this file in GitHub, read instead [this lecture in HackMD](https://hackmd.io/eIL-haCIS7-q1ja8LAXy-Q?view).

**Learning Outcomes:** After having worked through the exercises and homework, students will be able to

- check that a string is a lambda calculus program,
- construct the abstract syntax tree of a lambda calculus program,
- interpret (=execute) a lambda calculus program.

**Remark:** A program is by definition syntactically correct (otherwise it is not a program in the first place). But we sometimes say "syntactically correct program" or 
"legal program" or "well-formed program" for emphasis. 

**Warning:** Parsing and Lambda Calculus may well be the most difficult concepts we will meet in the course. So bear with me. I put a lot of "easy" exercises. Work through them. Let me know if you have questions about them.

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


**Remark:** We will comment on the three clauses in turn.
- (Function definition.) $\lambda x.e$ is a function. If we compare this with a C-like language 

      int plus_one(int x) { return x+1 }
     
  we note the following differences:
    - No types, that is, `plus_one(x){ return x+1 }`
    - No need for `return`, we just return the last value as in `plus_one(x){x+1}`
    - No functions names which leaves us with `(x){x+1}` which we write as $\lambda x. x+1$

  We will see later what to do about the `+ 1`.
  
   Function definition is called abstraction since in the same way as the definitions 

      int plus_one(int x) { return x+1 }

  and
  
      int plus_one(int y) { return y+1 }
     
  denote the same function, so do 
  
  $\lambda x.e$ and $\lambda y.e'$
  
  denote the same function if $e'$ arises from $e'$ by replacing every occurrence of $x$ by $y$. In other words, the meaning of $\lambda x.e$ does not depend on $x$, the name $x$ has been abstracted.
  

  
- (Function Application.) In a C-like language we would write function application as 

      plus_one(2)
      
  whereas we would write
  
      plus_one 2 
     
  in other words, we juxtapose (write next to each other) the function and its argument.
  
- (Variables.) Variables are mere names. The only operation we will use on names will be testing whether two names are equal or not. In particular, there will be no assignment of values to variables. In other words, the variables of lambda calculus are not memeory cells.





**Remark:** The grammar $\ e ::= \lambda x.e \mid e e \mid x$ defines the syntax of lambda expressions as trees. We add parenthesis if we want to disambiguate a string as in $$(\lambda x. (\lambda y. (x y z))) ((a b) c)$$

**Exercise:** Write $(\lambda x. (\lambda y. ((x y) z))) ((a b) c)$ as a tree.

**Rules for dropping parenthesis:**
To make writing and reading easier on the eye there are additional rules that allow us to drop parentheses. For example, we can abbreviate $(a b) c$, but not $a (b c)$, to $a b c$. And we abbreviate $\lambda x. (\lambda y. z)$ to $\lambda x. \lambda y. z$ and $\lambda x. (a b)$, but not $(\lambda x. a ) b$, to $\lambda x. a b$. 

**Exercise:** Use the convention on parentheses described in the previous remark in order to eliminate as many parentheses as possible from $(\lambda x. (\lambda y. (x y z))) ((a b) c)$ without changing the tree denoted by the expressions.

**Remark:** For a human reader it is fine to think of the grammar as describing trees. But programs are meant to be read by humans and by machines. And machines read strings, not trees. So we need to complicate notation in order to tell the machine precisely how to transform a string into a tree. In particular, we need to be more precise about the rules that allow us to drop parentheses. This is achieved, as in the example of arithmetic expressions in the previous lecture, by putting this information directly into the grammar.

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
   
   
**Exercise (IMPORTANT):** Do the following expressions e1 and e2 have the same abstract syntax tree?
    
| e1| e2|
|:--:|:---:|
|\x.y|\ x . y |
|( x y ) | (x y)|
|( x y ) | (xy) |
|( x y ) z  |   x y z |
|x (y z)  |   x y z |
| x | (x) |
| x | ((x)) |
| \ x.x | \ y. y|

## Homework 

- Read the lecture notes carefully. Work through all exercises. I would be grateful if you reported any typos or questions via [the issue tracker](https://github.com/alexhkurz/programming-languages-2019/issues).

- (Optional, for additional background on parsing.) Read the [BNF Converter Tutorial](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) up to and including Section "The deeper semantics of precedence levels: dummy labels". Explain again why we use different levels of expressions in the grammar of the lambda calculus.

 - (Optional, for now): [Install BNFC](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md),  and do the [BNFC Self Check](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-example.md). 

 - **(IMPORTANT)** Parse some programs in the [LambdaNat language](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lambda-Calculus/LambdaNat). 
   - Solve the exercises of this lecture with the help of the tool as explained [here](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/grammar/README.md). 
   - Compare the abstract syntax trees produced by the parser with the parsing you have done by hand in the exercises above.
   - Most interesting is perhaps to check, using the tool, whether e1 and e2 as in the table 
 
     | e1| e2|
     |:--:|:---:|
     |\x.y|\ x . y |
     |( x y ) | (x y)|
     |( x y ) | (xy) |
     |( x y ) z  |   x y z |
     |x (y z)  |   x y z |
     | x | (x) |
     | x | ((x)) |
     | \ x.x | \ y. y|

     have the same abstract syntax trees.


 
 - (Optional, for now): [Install BNFC](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md),  and do the [BNFC Self Check](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-example.md). 

 