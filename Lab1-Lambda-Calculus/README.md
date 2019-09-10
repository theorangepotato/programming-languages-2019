# README

## Introduction

The purpose of this folder is to teach a basic way how to extend and modify a small programming language. We start with the pure and untyped lambda calculus, available in the folder [LambdaNat0](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lab1-Lambda-Calculus/LambdaNat0). 

Recall that the syntax of the lambda caclulus has only variables, abstraction (function definition) and 
function application. The semantics only has one computation rule, known as capture avoiding substitution or beta-reduction.

This is a really small programming language and the learning outcome of this lab is to teach how to extend this very basic language with new features.

## Preliminary preparations

I am pretty sure you already have [git](https://git-scm.com/) installed. I also assume that you have the [Haskell Platform](https://www.haskell.org/platform/). Some of the steps require the installation of [bnfc as described here](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md), but most of the exercises can be done without.

If you have trouble with any of the above, you can always come and see me in my office hours.

To set up your computer, clone [this directory](https://github.com/alexhkurz/programming-languages-2019/). I do this from the command line by running in my home directory

    git clone https://github.com/alexhkurz/programming-languages-2019.git
    
You now have a folder `programming-languages-2019/Lab1-Lambda-Calculus/LambdaNat0/
`. This is the base folder to follow the instructions in this section on preliminary preparations.

To **view the grammar** of the pure lambda calculus go to the folder `grammar` and  open [LambdaNat0.cf](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lab1-Lambda-Calculus/LambdaNat0/grammar/LambdaNat0.cf). 

To **create a parser** run

    bnfc -m -haskell LambdaNat0.cf
    make

If you cannot download or build [bnfc as described here](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md), you should still be able to run `make` as I uploaded to the folder `grammar` all files produced by `bnfc` (you may have to delete the executable `TestLambdaNat` in order to force make to do something).

To **parse a program** run, for example,

    echo "\x.x y z" | ./TestLambdaNat
    
**Exercise:** Write your own lamda calculus programs and parse them.
    
To **view the interpreter** find the folder `src` and open [interpreter.hs](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lab1-Lambda-Calculus/LambdaNat0/src/Interpreter.hs).
    
To **compile the interpreter** run (in the folder `Lab1-Lambda-Calculus/LambdaNat0`)

    stack build
    
On some installations where `stack build` fails, `cabal build` works. 
    
To **write a program** open a text editor and save the file in the folder `test` as, say, `myprogram.lc`. Or use one of the programs already available in the folder `test`.

To **execute a program**  in the lambda calculus run

    stack exec LambdaNat-exe test/myprogram.lc

If you used `cabal build`, then `cabal exec` instead of `stack exec` should work. If it doesn't, search for the executable `LambdaNat-exe` and execute it by giving its full path, which should be `dist/build/LambdaNat-exe/LambdaNat-exe` ... if you encounter this problem under Windows try

    dist\build\LambdaNat-exe\LambdaNat-exe  test\myprogram.lc
    
If the executable was not created in the first place, come and see me in my office hours.

Despite being Turing complete, there seem to be no obvious interesting programs in lambda calculus. Here are some straight forward examples:

    \x.x -- the identity function that returns its argument
    \x.\y.x -- the function that takes two arguments and returns the first
    \x.\y.y -- the function that takes two arguments and returns the second
    
but these functions are disappointingly simple and would not make one think that all computable functions can be implemented
in the lambda calculus. We will come back later to the question how this is possble.

**Exercise:** Write your own lamda calculus programs and execute them.

For now, instead of encoding numbers, conditionals, and recursion in the pure lambda calculus, we will go into a different direction. We will add features to the basic language until we have enough to compute some reasonably
interesting examples.


## The working cycle

The working cycle that was used to produce all the different programming languages in this directory was as follows. 

(If you find this boring, feel free to jump to the next section and come back here for reference as needed.)

1) Choose a subdirectory, that is, a programming language, for example, [LambdaNat1](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lab1-Lambda-Calculus/LambdaNat0).

2) Copy the directory `LambdaNat1` and all its content to a new folder called `LambdaNewfeature` or `LambdaNat2`.

3) Go to `LambdaNewfeature/grammar` and rename the grammar `LambdaNat1.cf` to `LambdaNewfeature.cf`.

4) Change `LambdaNewfeature.cf` according to what you want to achieve.

5) Run `bnfc -m -haskell LambdaNewfeature.cf` followed by `make`. Write programs and parse them in the new language as explained. If not all tests run according to what you expect go back to 4).

6) Run `cd ../src`. Study `AbsLambdaNat.hs`. This contains the constructors used by the parser to create the abstract syntax tree. 
Study how the interpreter `Interpreter.hs` uses the constructors of `AbsLambdaNat.hs` in order to run
the abstract syntax trees. (Instead of "run", one can also say "evaluate", "execute", "interprete".)

7) Run `mv ../grammar/*.hs .`. This copies the files produced by bnfc. 
Study how `AbsLambdaNewfeature.hs` changed now. Adapt the interpreter accordingly (this can take a while and is the item that may require the largest amount of work).

8) Run `../stack build`. Debug the interpreter if it does not compile. 

9) Write a test program and save it in test/test.lc. Run the test program via `../stack exec LambdaNewfeature-exe ../test/test.cf'. 
If not all tests run according to what you expect go back to 7).

10) Release your new programming language.

## From `LambbdaNat0` to `LambdaNat1`

...

## The different programming languages

[LambdaNat0](): The pure lambda calculus.

[LambdaNat1](): Natural numbers added as data. 

...







