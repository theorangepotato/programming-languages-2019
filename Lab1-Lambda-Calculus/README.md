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


## The Work Cycle

The Work Cycle that was used to produce all the different programming languages in this directory was as follows. 

(If you find this boring, feel free to jump to the next section and come back here for reference as needed.)

Here we assume that we have `LambdaNat42` and want to build a new language called `LambdaNat43`.

1) Choose a subdirectory, that is, an already existing programming language. For the sake of concreteness, let us assume that this language is in a folder called `LambdaNat42`.

2) Copy the directory `LambdaNat42` and all its content to a new folder called `LambdaNat43`.

3) Go to `LambdaNat43/grammar` and rename the grammar `LambdaNat42.cf` to `LambdaNat43.cf`. 

   (You have to be careful if you want to choose a more descriptive name. The reason is that bnfc produces files and the names of these files need to be known to `stack` when you build the interpreter. You could use `LambdaNat.NewFeature.cf`.)

4) Change `LambdaNat43.cf` according to what you want to achieve. 

5) To build the parser:

  a) Run `bnfc -m -haskell LambdaNat43.cf`.
  b) Run `make`. 

6) Write programs and parse them in the new language as explained. 
   If not all tests run according to what you expect go back to 4).

7) Run `cd ../src`. Study `AbsLambdaNat.hs`. This contains the constructors used by the parser to create the abstract syntax tree. 
Study how the interpreter `Interpreter.hs` uses the constructors of `AbsLambdaNat.hs` in order to run
the abstract syntax trees. (Instead of "run", one can also say "evaluate", "execute", "interprete".)

8) Run `mv ../grammar/*.hs .`. This copies the files produced by bnfc. 
Study how `AbsLambdaNat.hs` changed now. Adapt the interpreter accordingly (this can take a while and is the item that may require the largest amount of work).

9) Run `../stack build`. Debug the interpreter if it does not compile. 

10) Write a test program and save it in test/test.lc. Run the test program via `../stack exec LambdaNewfeature-exe ../test/test.lc'. 
If not all tests run according to what you expect go back to 7).

11) Release your new programming language.

## From `LambbdaNat0` to `LambdaNat1`

This section assumes that we can run the parser and interpreter for the LambdaNat0.

Learning outcome of this section is a basic understanding of how to add a feature to a programming language.

The running example is adding numbers to LambdaNat0. Our first milestone is the `plus_one` function. We will achieve this in two steps. The first step, LambdaNat1, is already in the repository. The second step, LambdaNat2, you should try as homework.

Before going to write some code, we need a specification. 

**Activity:** How can we write `plus_one` as a lambda expression? Can we do this in such a way that we use the [computation rule](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/SyDa-43BB#Beta-reduction) of lambda calculus in order to compute plus one? 

**Outcome:** `(\ x . S x)`

**Example:** According to the computation rule of lambda calculus, if we apply the function `\ x . S x` to, say, `S 0`, we obtain `S S 0`.

Let us look at what we have in the folder `LambdaNat1`. 

Referring to the Work Cycle above (with 0 instantiating 42 and 1 instantiating 43), steps 1-5 have been performed already. Nevertheless, if you want to do step 6, you mave have to run `make` in the folder `grammar` in order to produce a parser that is actually executable on your machine.

Now you should be able to run, for example, 

    echo "(\x.x) S 0" | ./TestLambdaNat

**Exercise:** Do Step 6 of the Work Cycle.

Steps 7-9 have already been performed again. 

Nevertheless, you will have to perform Step 9 yourself, so that the interpreter is executable on your machine. 

We can now test the interpreter, for example by running

    echo "(\x.x) S 0" | stack exec LambdaNat-exe

**Exercise:** Do Step 10 of the Work Cycle.

**Activity:** Why does the following not work?

    echo "(\x.S x) S 0" | stack exec LambdaNat-exe

    Parse Failed...


What breaks? Why? How can we fix it?

Let us go through this step by step

- What breaks? Judging from the output the parsing.

- Why? For this we need to go to the grammar `LambdaNat1.cf`. There we find the line

        NatS.   Nat ::= "S" Nat ;
    
  which says that an `S` must be followed by a number, and not a variable or a more general expression. 

- How can we fix it? We need to change the grammar so that `S` can be followed by a variable, or, any expression. There are different possibilities here.

  - We can use the grammar
  
        e ::= \ x. e | e e | x | 0 | S e

    where now `S` can be followed by any expression.

  - We can use the grammar

        e ::= \ x . e | e e | x | 0 | S

    where `S` is now a new constant and `S 0` is parsed as an application.

  - Maybe even more ... give it a try ...

## Homework: From LambdaNat1 to LambdaNat2

Try to pick up everything from the last observation. Work yourself through the Work Cycle to produce a new version `LambdaNat2` and see whether you can get the following output

    echo "(\x.S x) S 0" | stack exec LambdaNat-exe

    Output:
    S S 0



## The different programming languages

[LambdaNat0](): The pure lambda calculus.

[LambdaNat1](): Natural numbers added as data. 

...







