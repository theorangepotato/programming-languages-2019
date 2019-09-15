## Syntax of LambdaNat 

(Read in [HackMD](https://hackmd.io/JIrbYii2QteCRrxPP-Dxqw).)

Later in the course we will see why lambda calculus is Turing complete. Despite only having abstraction and application, a rich repertoire of data and control can be encoded, including data types such as Booleans, numbers, and lists as well as control flow operations such as if-then-else and loops/recursion.

For now, we go into a different direction. Instead of encoding the above in the lambda calculus, we extend the lambda calculus by further primitives. 

We start by extending the lambda calculus by natural numbers and we call this programming language **LambdaNat**.

The idea of how to add numbers is simple. If we restrict ourselves to the natural numbers, that is, the non-negative integers, we simply add one basic program and one rule to our definition of the lambda calculus. 

Numbers are special programs but not every program is a number. Numbers are defined as follows. 

- **Zero:** There is one basic number which we write as $0$ and pronounce as "zero". 
- **Successor:** If $n$ is a number, then $S n$ is a number.

**Remark:** It is important to understand that at the moment $0$ does not mean zero. It is just a symbol, which we could replace by any other symbol. We are defining a language here and are free to choose the syntax that we like. Similarly, $S$ is not a function that computes "plus one", even if we can think of it like this from the point of view of a user. From the point of view of the programming language, or from the point of view of the machine, $S$ is just a symbol and $S 0$, $SS0$, $SSS0$ etc are just a strings (or trees rather).

Now we can define the syntax of the programming language LambdaNat via the BNFC grammar

    EAbs.   Exp ::= "\\" Id "." Exp ;  
    EApp.   Exp2 ::= Exp2 Exp3 ; 
    EVar.   Exp3 ::= Id ;
    ENat.   Exp4 ::= Nat ; 
    Nat0.   Nat ::= "0" ;
    NatS.   Nat ::= "S" Nat ; 

    coercions Exp 4 ;
    
The full BNFC grammar is in the file [LambdNat.cf](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/grammar/LambdaNat.cf). 

