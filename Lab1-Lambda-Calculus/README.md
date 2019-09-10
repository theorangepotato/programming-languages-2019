# README

(under construction)

## Introduction

The purpose of this folder is to teach a basic way how to extend and modify a small programming language. We start with [Lambda](),
contains the smallest meaningful programming language, the lambda calculus. 

The syntax of the lambda caclulus has only variables, abstraction (function definition) and 
function application. The semantics only has one computation rule, known as capture avoiding substitution or beta-reduction.

This is a really small programming language and the learning out come of this lab is to teach how to extend this very basic language with new features.

## Preliminary preparations

To set up your computer, clone [this directory](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lab1-Lambda-Calculus).

To **view the grammar** of the pure lambda calculus open [LambdaNat0.cf](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lab1-Lambda-Calculus/LambdaNat0). 

To **create a parser** run

    bnfc -m -haskell LambdaNat0.cf]
    make
    
To **parse a program** run, for example,

    echo "\x.x y x" | .TestLamNat
    
To **view the interpreter** open [interpreter.hs](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lab1-Lambda-Calculus/LambdaNat0/src/Interpreter.hs).
    
To **create the interpreter** run (in the folder `Lab1-Lambda-Calculus/`) run

    stack build
    
To **write a program** open a text editor and save the file in the folder `test` as, say `myprogram.lc`. Or use one of the programs already available in the folder `test`.

To **execute a program**  in the lambda calculus run

    stack exec LambdaNat-exe test/myprogram.cf


It is hard to think of an interesting program that one could write in lambda calculus. Here are some straight forward examples:

    \x.x -- the identity function that returns its argument
    \x.\y.x -- the function that takes two arguments and returns the first
    \x.\y.y -- the function that takes two arguments and returns the second
    
but these functions are disappointingly simple and do not suggest that all functions that are computable at all can also be computed
in the lambda calculus. We will come back later to the question how this is possble.

For now, we will go into a different direction. We will add features to the basic language until we have enough to compute some reasonably
interesting examples.

## The working cycle

The working cycle that was used to produce all the different programming languages in this directory was as follows. 

1) Choose a subdirectory, that is, a programming language, for example, [Lambda]().

2) Copy the directory Lambda and all its content to a new folder called LambdaNewfeature.

3) Go to LambdaNewfeature/grammar and rename the grammar `Lambda.cf` to `LambdaNewfeature.cf`.

4) Change `LambdaNewfeature.cf` according to what you want to achieve.

5) Run `bnfc -m -haskell LambdaNewfeature.cf` followed by `make`. Write programs and parse them in the new language as explained [here]().
If not all tests run according to what you expect go back to 4).

6) Run `cd ../src`. Study `AbsLambda.hs`. This contains the constructors used by the parser to create the abstract syntax tree. 
Study how the interpreter `Interpreter.hs` uses the constructors of `AbsLambdaNewfeature.hs` in order to run
the abstract syntax trees. (Instead of "run", one can also say "evaluate", "execute", "interprete".)

7) Run `mv ../grammar/*.hs .`. This copies the files produced by bnfc. 
Study how `AbsLambdaNewfeature.hs` changed now. Adapt the interpreter accordingly (this can take a while and is the item that may require the largest amount of work).

8) Run `../stack build`. Debug the interpreter if it does not compile. 

9) Write a test program and save it in test/test.lc. Run the test program via `../stack exec LambdaNewfeature-exe ../test/test.cf'. 
If not all tests run according to what you expect go back to 7).

10) Release your new programming language.

## The different programming languages

[LambdaNat0](): The pure lambda calculus.

[LambdaNat1](): Natural numbers added as data. Why can't we compute "plus one" here in the expected way?

[LambdaNat2](): Natural numbers added as expressions. Can do "plus one".

[LambdaNat3](): If-then-else added. Cannot do "plus" easily.

[LambdaNat4](): Recursion added. "Plus" still seemed difficult, so we also added "minus_one". We also added a "let" in addition to the "let rec" in order to illustrate the difference between the two (and the "let rec" is difficult to get right without having done the "let" before).






