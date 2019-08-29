# Short Introduction to Parsing

## Parsing arithmetic expressions

This is a topic that we will study in much more detail next semester in Compiler Construction. 
Here we just need to know a few simple rules in order to translate linear syntax (aka concrete syntax) into tree form (aka abstract syntax).

Why is it important to translate strings into trees? To evaluate a string such as `1+2+3+4+5*6` we first need to calculate `5*6`. 
This shows that the substring we need to compute first
can be arbitrarily far away from the first letter of the string. So how do we find this substring? The answer is by first converting
the string into a tree. Once we have the data in tree form the answer to such and similar questions is obvious.

**Exercise:** Transform `1+2*3` into a tree. 
 
The rules according to which a string is transformed into a tree can be given in the form of a [context free grammar](https://en.wikipedia.org/wiki/Context-free_grammar) and are often written using [BNF](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form). A short BNF definition of a little language for a calculator could be
 
    Exp ::= Integer | Exp "+" Exp | Exp "*" Exp
    
where `Integer` stands for any whole number in decimal notation. The symbols enclosed in "..." are part of the program (concrete syntax). The other symbols serve to guide the parsing.
 
**Exercise:** `1+2-3` cannot be parsed by the grammar above. Can you modify the grammar so that this becomes possible?

**Exercise:** In the grammar above the string `1+2*3` can be parsed into two different trees. Write them down. How many parse trees are there for `1+2+3+4`?
 
 We can modify the grammar so that `1+2*3` has only one parse tree.
 
    Exp     ::=     Exp     "+"     Exp1  | Exp 1
    Exp1    ::=     Exp1    "*"     Exp2  | Exp 2
    Exp2    ::=     Integer 

**Exercise:** Show that there is only one way to parse `1+2*3` in the second grammar. How do you parse `1+2+3+4` now?

**Exercise:** Add rules for minus and division.

**Exercise:** Can you parse `(1+2)*3` ? How can you modify the grammar to account for such strings?

**Remark:** BNFC has a feature called coercions. Using this the grammar for the calculator looks as follows:

    Exp     ::=     Exp     "+"     Exp1  ;
    Exp1    ::=     Exp1    "*"     Exp2  ;
    Exp2    ::=     Integer ;
    
    coercions Exp 2
    
Using coercions we do not need to add explicit rules for `Exp ::=  Exp 1`, etc and for `Exp2 ::= "(" Exp ")"`. If you want to see all the rules specified by the above BNF in detail, it looks like this:
 
     Exp -> Exp '+' Exp1                             
     Exp -> Exp1                                      
     Exp1 -> Exp1 '*' Exp2                             
     Exp1 -> Exp2
     Exp2 -> Integer   
     Exp2 -> '(' Exp ')'         
     
By the way, this is the form in which you would write down the grammar in a theory course on formal languages, see [context free grammar](https://en.wikipedia.org/wiki/Context-free_grammar) again.

**Activity:** Being new to a subject, one of the stumbling blocks is always the subject specific jargon and notation. For example, both BNF and context free grammars are equivalent. Every context free gramma can be written in BNF, and vice versa. So why should we learn both? Discuss ... (Actually, the situation is even "worse": If you look at the particular form of BNF implemented in the tool BNFC, you will find that the notation is slightly different again ... but again there are good reasons for this (we may come back to this issue later).)

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
 
 ## Answers to selected Exercises
 
 The trees for `(1+2)*3`  and for `1+2*3` are, respectively,
 
         *            +
        / \          / \
       +   3        1   *
      / \              / \
     1   2            2   3
     
  Thu full grammar for the calculator is in BNF
  
    Exp     ::=     Exp     "+"     Exp1  | Exp 1
    Exp     ::=     Exp     "-"     Exp1  | Exp 1
    Exp1    ::=     Exp1    "*"     Exp2  | Exp 2
    Exp1    ::=     Exp1    "/"     Exp2  | Exp 2
    Exp2    ::=     Integer 
    Exp2    ::=     "(" Exp ")"

  and as a context free grammar
  
        Exp -> Exp '+' Exp1                                
	Exp -> Exp '-' Exp1                                
	Exp -> Exp1                                         
	Exp1 -> Exp1 '*' Exp2                               
	Exp1 -> Exp1 '/' Exp2                               
	Exp1 -> Exp2                                        
	Exp2 -> Integer                                    
	Exp2 -> '(' Exp ')'                                 
     
 
 ## Homework
 - Read the [BNF Converter Tutorial](http://bnfc.digitalgrammars.com/tutorial/bnfc-tutorial.html) up to and including Section "The deeper semantics of precedence levels: dummy labels".
  
 - Run some programs in the [LambdaNat language](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lambda-Calculus/LambdaNat) (this needs Haskell installed, see the homework of the previous lecture).
 
 - Write a program `plus_one.lc` in LambdaNat that adds +1 to a number. Test your program using the interpreter as in the previous item.
 
 - [Install BNFC](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md),  and parse some lambda expressions as in the [BNFC Self Check](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-example.md). Compare the abstract syntax trees produced by the parser with the parsing you have done by hand in the exercises above.

 
