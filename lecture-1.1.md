# Introduction

The course will have a practical and a theoretical component.

- *The theoretical component* will teach some of the discrete mathematics that forms the background to understand principles of programming languages. These include the very basics of logic, rewriting, ordered structures, universal algebra, type theory, etc. 

- *The practical component* will be about building a small programming language. We will start with the smallest practical programming language known as lambda calculus and then extend it with features. There will be room for invention and adventure there if you feel like it. But there will also be guided exercises.

**Assessment:** The theoretical component will be assessed by a final exam worth 30% and a number of tests during the semester worth together 20%. The practical component will be assessed by a short essay and presentation worth 20% and a number of programming exercises during the semester worth together 30%. There may also be unnannounced short quizzes at the beginning of a lecture to provide feedback to students and lecturer. These quizzes do not contribute to the final grade.

**Creating our own little programming language** will be an important part of the course. This will involve using the tool BNFC as well as learning some of the programming Haskell. 

**BNFC**: BNFC is a tool that helps creating your own programming language. A more in depth study of the tool will be part of the Compiler Construction Course. For this course, for most of the exercises you will get template files. But later, or if you want to conduct your own developments and experiments, you will have to have BNFC installed, so why not start right now. Here are the instructions to follow:

- [BNFC: basic installation instructions](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md)  

**Haskell** is the leading functional programming language and will be of interest to the course for a number of reasons:

 - Haskell, even though a powerful general purpose language, has been  called a domain specific language for creating programming languages for a good reason.
 
 - Haskell is the langauge in which many tools (such as BNFC) in the area of Programming Languages are implemented.
 
 - Haskell is a lazy functional programming language and, thus, a prime example of an important paradigm in Programming Languages.
 
 - Haskell is an elaboration of the lambda calculus, which also forms the basis for our own small programming language that we will consider in the exercises of this course.
 
 - Haskell is the language in which we will write the interpeter used to execute our programming language.
 
 - Haskell's semantics is based on rewriting, which forms one of the central theoretical concept of the course.
 
 - Last but not least, Haskell is gaining popularity in industry applications for a number of important reasons, such as self-documenting code, a strong type system, side-effect free parallelizable code, ... so some of you may be interested in adding Haskell to the portfolio of your programming languages.
 
 **Lambda Calculus** is the smallest practical [Turing complete](https://en.wikipedia.org/wiki/Turing_completeness) programming language. It is important to this course for a number of reasons:
 
 - Because it is small it is easily explained and a good starting point for experimentation.
 
 - Lambda Calculus is minimal in that all it has is
   - abstraction, that is, the ability to declare a formal parameter and 
   - application, that is, a mechanims to substitute an argument for a formal parameter.
 
 - Lambda Calculus can be evaluated according to different strategies, in particular call by value and call by name.
 
 - Lambda Calculus can be extended in various ways: types, addresses, references, ...
 
 - Lambda Calculus is the basis for many fully fledged programming languages such as Lisp, Scheme, ML, Haskell, Ocaml, ...
 
 **Short Introductin to Parsing:** This is a topic that we will study in much more detail next semester in Compiler Construction. Here we just need to know a few simple rules in order to translate linear syntax, such as `1+2*3`, into a tree such as
 
         *
        / \
       +   3
      / \
     1   2
 
 The rules according to which a string is transformed into a tree can be given in the form of a [context free grammar]() and are often written using [BNF](). A short BNF definition of a little language for a calculator could be
 
    Exp ::= Integer | Exp "+" Exp | Exp "*" Exp
    
 where `Integer` stands for any whole number in decimal notation. The symbols enclosed in "..." are part of the program (concrete syntax). The other symbols serve to guide the parsing.
 
*Exercise:* Show that `1+2-3` cannot be parsed by the grammar above. Can you modify the grammar so that this becomes possible?

*Exercise:* In the grammar above the string `1+2*3` can be parsed into two different trees. Write them down.
 
 We can modify the grammar so that `1+2*3` has only one parse tree.
 
    Exp     ::=     Exp     "+"     Exp1  | Exp 1
    Exp1    ::=     Exp1    "*"     Exp2  | Exp 2
    Exp2    ::=     Integer 

*Exercise:* Show that there is only one way to parse `1+2*3` in the second grammar. How do you parse `1+2+3+4`?

*Exercise:* Add rules for minus and division.

*Exercise:* Can you parse `(1+2)*3` ? How can you modify the grammar to account for such strings?

*Remark:* BNFC has a feature called coercions. Using this the grammar for the calculator looks as follows:

    Exp     ::=     Exp     "+"     Exp1  ;
    Exp1    ::=     Exp1    "*"     Exp2  ;
    Exp2    ::=     Integer ;
    
    coercions Exp 2

**Parsing Lambda Calculus** The abstract syntax of the lambda calculus can be described simply by

    Exp ::= "\" Id "." Exp | Exp Exp | Id 
    
 As in the arithmetic example, this does not take into account parenthesis. 
 
 *Exercise:* Show that `x y z` can be parsed in two different ways.
 
    Exp1 ::= "\" Id "." Exp1 ;
    Exp2 ::= Exp2 Exp3 
    Exp3 ::= Id ;

    coercions Exp 3 ;
    
 *Exercise:* Show that `x y z` has now only one parse tree.
 
 [LambdaNat.cf](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/grammar/LambdaNat.cf)
 
 **Homework:** 
 - Read the [BNF Converter Tutorial](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) up to and including Section "The deeper semantics of precedence levels: dummy labels".
  
 - Install [Haskell](https://www.haskell.org/) on your machine and run some programs in the [LambdaNat language](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lambda-Calculus/LambdaNat).
 
 - Install BNFC,  and parse some lambda expressions.

 

