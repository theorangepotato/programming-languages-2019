(under construction)

## Parsing Lambda Calculus expressions 

The abstract syntax of the lambda calculus can be described simply by

    Exp ::= "\" Id "." Exp | Exp Exp | Id 
    
 As in the arithmetic example, this does not take into account parenthesis. 
 
 **Exercise:** Show that `x y z` can be parsed in two different ways.
 
    Exp1 ::= "\" Id "." Exp1 ;
    Exp2 ::= Exp2 Exp3 
    Exp3 ::= Id ;

    coercions Exp 3 ;
    
 **Exercise:** Show that `x y z` has now only one parse tree.
 
 [LambdaNat.cf](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/grammar/LambdaNat.cf)
 
 ## Homework
 - Read the [BNF Converter Tutorial](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) up to and including Section "The deeper semantics of precedence levels: dummy labels".
  
 - Run some programs in the [LambdaNat language](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lambda-Calculus/LambdaNat) (this needs Haskell installed, see the homework of the previous lecture).
 
 - Write a program `plus_one.lc` in LambdaNat that adds +1 to a number. Test your program using the interpreter as in the previous item.
 
 - [Install BNFC](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md),  and parse some lambda expressions as in the [BNFC Self Check](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-example.md). Compare the abstract syntax trees produced by the parser with the parsing you have done by hand in the exercises above.

 
