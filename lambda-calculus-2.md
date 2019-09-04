# Lambda Calculus 2

**Learning Outcomes:** After having worked through the exercises and homework, students will be able to

- explain and perform capture avoiding substitution, 
- interpret (=execute) lambda calculus programs.

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

    EAbs.   Exp ::= "\\" Id "." Exp ;  
    EApp.   Exp2 ::= Exp2 Exp3 ; 
    EVar.   Exp3 ::= Id ;
    ENat.   Exp4 ::= Nat ; 
    Nat0.   Nat ::= "0" ;
    NatS.   Nat ::= "S" Nat ; 

    coercions Exp 4 ;
    
The full BNFC grammar is in the file [LambdNat.cf](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/grammar/LambdaNat.cf). 


## Semantics of the Lambda Calculus

From the previous section, we know how to write a lambda calculus program. 

In this section, we will learn how to execute a well-formed lambda calculus program.

First, we need to make sure that we know how to rename formal parameters. For example, we have that

$$\lambda x.x=\lambda y.y,$$

that is, the formal parameter $x$ can be renamed to $y$ without changing the meaning of the lambda expression. We also say that $\lambda x.x$ and $\lambda y.y$ are *alpha-equivalent*.

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


## Homework 

- Read the lecture notes carefully. Work through all exercises. I would be grateful if you reported any typos or questions via [the issue tracker](https://github.com/alexhkurz/programming-languages-2019/issues).


 - **(IMPORTANT)** Write a program `plus_one.lc` in LambdaNat that adds +1 to a number. Test your program using the interpreter as described [here](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/README.md).
 

 
