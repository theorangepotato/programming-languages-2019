# Short Introduction to Parsing 

    "The form of syntax we shall now describe differs from the Backus normal form in two ways. 
    First, it is analytic rather than synthetic; it tells how to take a program apart, 
    rather than how to put it together. Second, it is abstract in that it is independent of the notation 
    used to represent, say sums, but only affirms that they can be recognized and taken apart."

From the article [Towards a Mathematical Science of Computation](http://www-formal.stanford.edu/jmc/towards.ps) by [McCarthy](https://en.wikipedia.org/wiki/John_McCarthy_%28computer_scientist%29).

McCarthy was a pioneer of Computer Science. In 1955 he coined the term "artificial ingelligence", shortly afterwards he invented LISP and garbage collection, [time-sharing systems](https://en.wikipedia.org/wiki/Time-sharing), and in 1962 he introduced, with the quote above, the idea of abstract syntax.

Interesting for us, is that McCarthy emphasises that BNF makes it easy to generate, write and synthesize programs, whereas abstract syntax makes it easy to analyse, translate, type check, interprete and compile programs. Another way to put it, is to say that concrete syntax is good for human readers and abstract syntax is good for automated processing.

Another influential article is [Ascribing mental qualities to machines](http://cs.uns.edu.ar/~grs/InteligenciaArtificial/ascribing.pdf) from 1979.

## Learning Outcomes

After having worked through the exercises and homework, students will be able to

- understand a context free grammar in BNFC for arithmetic expressions,
- parse an arithmetic expression, that is, to transform an arithmetic expression into an abstract syntax tree,
- how precedence levels are used to make sure that each expresssion has only one parse tree,
- explain what is an abstract syntax tree.

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
    
where `Integer` stands for any whole number in decimal notation. The symbols enclosed in "..." are part of the program (concrete syntax). The other symbols serve to guide the parsing. The vertical bar `|` means "or", that is, the one line above abbreviates the following three rules:

    Exp ::= Integer 
    Exp ::= Exp "+" Exp 
    Exp ::= Exp "*" Exp
 
**Exercise:** `1+2-3` cannot be parsed by the grammar above. Can you modify the grammar so that this becomes possible?

**Exercise:** In the grammar above the string `1+2*3` can be parsed into two different trees. Write them down. How many parse trees are there for `1+2+3+4`?
 
 We can modify the grammar so that `1+2*3` has only one parse tree.
 
    Exp     ::=     Exp     "+"     Exp1  | Exp 1
    Exp1    ::=     Exp1    "*"     Exp2  | Exp 2
    Exp2    ::=     Integer 

**Exercise:** Show that there is only one way to parse `1+2*3` in the second grammar. How do you parse `1+2+3+4` now?

**Exercise:** Add rules for minus and division.

**Exercise:** Can you parse `(1+2)*3` ? How can you modify the grammar to account for such strings?

**Remark:** BNFC has a feature called coercions. Using this the grammar for the calculator looks as follows (BNFC also requires a `;` at the end of each rule): 

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

**Activity:** Being new to a subject, one of the stumbling blocks is always the subject specific jargon and notation. For example, both BNF and context free grammars are equivalent. Every context free gramma can be written in BNF, and vice versa. So why should we learn both? Discuss ... (Actually, the situation is even "worse": If you look at the particular form of BNF implemented in the tool BNFC, you will find that the notation is slightly different again ... but again there are good reasons for this (we may come back to this later).)


 ## Answers to the Exercises
 
 The trees for `(1+2)*3`  and for `1+2*3` are, respectively,
 
         *            +
        / \          / \
       +   3        1   *
      / \              / \
     1   2            2   3
     
  The full grammar for the calculator is in BNF
  
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
     
 `1+2+3+4` has 5 parse trees in the grammar `Exp ::= Integer | Exp "+" Exp | Exp "*" Exp` but only one in the full grammar above.
 
 ## References
 
 - Chapter 2.1-2.6 of [Implementing Programming Languages](http://www.cse.chalmers.se/edu/year/2012/course/DAT150/lectures/plt-book.pdf). To work throug the rest of this book is the aim of the course on Compiler Construction.
 
 - To see how these methods can be applied to natural language look at Chapter 2 of [Grammatical Framework: Programming with Multilingual Grammars](http://www.grammaticalframework.org/gf-book/). If you don't have access to the book, try pages 63-98 of the [slides](http://www.grammaticalframework.org/gf-book/gf-book-slides.pdf).
 
 ## Homework
 
 - Read the lecture notes carefully. Work through all exercises. I would be grateful if you reported any typos or questions via [the issue tracker](https://github.com/alexhkurz/programming-languages-2019/issues).

 - To know what we will need about LBNF (the input language for the parser generator  BNFC) read Sections 1, 2, 3, 4.3, 7.2  of the article [The Labelled BNF Grammar Formalism]().
 
 - Write down some arithmetic expressions (such as `1+2*(3+4)`, `1+2+3*4+5`, etc) and construct the parse tree using the rules of the grammar. Also write down the abstract syntax trees.
 
 - Compare your abstract syntax trees form the previous exercise with the ones computed by the parser available [here](https://github.com/alexhkurz/programming-languages-2019/tree/master/Calculator).
 
 - Write down some illegal expressions (such as `1++2`, `2*`, etc) and try to parse them. Where does the parsing get stuck? If you were a compiler, what syntax error would you provide to the user on encountering a syntax error? (In order to be implementable, the error message must be computed from the data available at the moment were the parsing gets stuck.)
 
