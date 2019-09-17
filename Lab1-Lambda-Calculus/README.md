# README

## Introduction

The purpose of this folder is to teach a basic way how to extend and modify a small programming language. We start with the pure and untyped lambda calculus, available in the folder [LambdaNat0](https://github.com/alexhkurz/programming-languages-2019/tree/master/Lab1-Lambda-Calculus/LambdaNat0). 

Recall that the [syntax](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lab1-Lambda-Calculus/LambdaNat0/grammar/LambdaNat0.cf) of the lambda caclulus has only variables, abstraction (function definition) and 
function application. The [semantics](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/SyDa-43BB#The-Computation-Rule-beta-Reduction) only has one computation rule, known as capture avoiding substitution or beta-reduction.

This is a really small programming language and the learning outcome of this lab is to teach how to extend this very basic language with new features. There are two main steps: Add the new feature to the parser and then to the interpreter.

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

7) 

  a) Run `cp *.hs ../src`. (Do a `mkdir ../src` before if necessary.) This copies the files produced by bnfc into the `src` folder that will contain the new interpreter. Run `cd ../src`.
    
  b) Copy the old interpreter  in `LambdaNat42/src/Interpreter.hs` to `LambdaNat43/src/Interpreter.hs` in the new `src` folder. 

8) Study how the interpreter `Interpreter.hs` uses the constructors of `AbsLambdaNat.hs` in order to evaluate the abstract syntax trees. Modify the old interpreter so that it can evaluate the new constructors of the new `AbsLambdaNat.hs` (this can take a while and is the item that may require the largest amount of work).

9) Run `../stack build`. Debug the interpreter if it does not compile. 

10) Write a test program and save it in test/test.lc. Run the test program via `../stack exec LambdaNewfeature-exe ../test/test.lc'. 
If not all tests run according to what you expect go back to 7).

11) Release your new programming language.

**Remark:** In the exercises below, **Steps 1-5a** have already been taken care of for you. But I would encourage you to also play around with your own grammars.

## From `LambbdaNat0` to `LambdaNat1`

This section assumes that we can run the parser and interpreter for LambdaNat0.

Learning outcome of this section is a basic understanding of how to add a feature to a programming language.

The running example is adding numbers to LambdaNat0. Our first milestone is the `plus_one` function. We will achieve this in two steps. The first step, LambdaNat1, is already in the repository. The second step, LambdaNat2, you should try as homework.

Before going to write some code, we need a specification. 

**Activity:** How can we write `plus_one` as a lambda expression? Can we do this in such a way that we use the [computation rule](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/SyDa-43BB#Beta-reduction) of lambda calculus in order to compute plus one? 

**Outcome:** `\ x . S x`

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

## Homework: From LambdaNat1 to LambdaNat2 (successor)

Try to pick up from the last observation. Work yourself through the Work Cycle to produce a new version `LambdaNat2` and see whether you can get the following output

    echo "(\x.S x) S 0" | stack exec LambdaNat-exe

    Output:
    S S 0

## Solution: From LambdaNat1 to LambdaNat2 

We deal with the case where we use the grammar

        e ::= \ x. e | e e | x | 0 | S e

and encourage you to explore other possibilities as further exercises.

Adding `0 | S e` to BNFC leads us to add to the following, see [`LambdaNat2.cf`]() for the full grammar.

    ENat0.  Exp3 ::= "0" ;
    ENatS.  Exp3 ::= "S" Exp3 ; 

This means that compared to [`LambdaNat0.cf`](), we have to more rules named `ENat0` and `ENatS`. Accordingly, we need to add to the [interpreter of LambdaNat0]() two cases. 

    evalCBN (ENatS e) = ENatS (evalCBN e)
    evalCBN ENat0 = ENat0

and similarly in the code for substitution

    subst id s (ENatS e) = ENatS (subst id s e) 
    subst id s ENat0 = ENat0 

With these changes, and keeping to the steps in the Work Cycle, you should be able to build the interpeter and then run a program like in

    echo "(\ x . S x) S S 0" | stack exec LambdaNat-exe

and obtain

    S S S 0

as output.

## From LambdaNat2 to LambdaNat3 (conditionals)

We go through the Work Cycle to add if-then-else. As abstract syntax we may choose (fill in the dots)

        e ::= \ x. e | e e | x | 0 | S e | ...

If you want to see my grammar you find it in the usual place. You will need to know the grammar, when are going to write an actual program in the language. 

But to modify the interpreter so that it can deal with if-then-else, we only need to know that in the definition of the abstact syntax in [AbsLambdaNat](), there is one new case now, namely 

        EIf Exp Exp Exp Exp

The trick is to use Haskell's if-then-else in order to implement the interpreter for this case. 

Can you guess how to do this? I will tell you that Haskell's syntax for a conditional is

     "if" Exp "==" Exp "then" Exp "else" Exp

As in the previous section, `subst` may also need modification. And don't forget the other steps in the Work Cycle.

In the end you should be able to run 

## From LambdaNat3 to LambdaNat4 (recursion)

Adding recursion is more tricky. We are doing this in two steps.

### **The `let` construct**

The `let` construct is a good example for syntactic sugar. It makes the code look nicer but that is all. In this case we want to write something like

    let plus_one = \ x. S x in 
      plus_one S 0

What is so nice about this is that we said some time ago that lambda functions are nameless. We also said that this does not matter. Now you can see why this is case:

In the above code the first line `let plus_one = \ x. S x in` acts as a declaration, defining the name `plus_one` that can then be used in the "block" that follows the `in`.

**Activity:** Write down a rule in BNFC for the `let` construct. Name it `ELet.`

To say that the `let` construct is syntactic sugar means that it can easily be implemented in the language we have already. How would that work?

    let f = A in B

is nothing but

    (\ f . B) A

Essentially, we just switch the order of `A` and `B`.

Another aspect of syntactic sugar is that we do not need a new computation rule for the interpreter. We simply let the interpreter translate `let f = A in B` into `(\ f . B) A`. In Haskell

    evalCBN (ELet id e1 e2) = evalCBN (EApp (EAbs id e2) e1)

Now go through the Work Cycle and test with

    echo "let plus_one = \ x. S x in plus_one S 0" | stack exec LambdaNat-exe

which should give the output

    S S 0


### **The `let rec` construct**

In order to implement recursion we use a trick from theoretical computer science, namely the so-called **fixed point combinator**. We write the fixed point combinator as `fix`. It is just a new constant, like `0` or `S`. But we equip it with an interesting computation rule, namely

    fix F --> F(fix F)

The name "fixed point combinator" comes from the fact that `fix F` is indeed a fixed point of `F`: The computation rule says that `F` applied to `fix F` is `fix F` itself. One curious thing about the rule is that it seems to go in the wrong direction as the output of the rule looks more complicated then the input. This is quite mysterious. Can this work at all?

Let us just implement it and see what happens. (We are engineers, so whatever works is fine.) 

First, for the grammar, we just add to the BNFC grammar the line

    EFix.      Exp2 ::= "fix" Exp ; 

The rule 

    fix F --> F(fix F)
    
is easy to translate to Haskell. Just remember that `F(fix F)` is an application of `F` to `fix F` (and that `fix` is represented by `EFix` in the abstract syntax). This gives us:

    evalCBN (EFix e) = evalCBN (EApp e (EFix e))

Now you can build an interpreter that can execute the following program:

    let rec f = \ x. if x = S S S 0 then Hello_World else f (S x) in 
      f 0 

Admittedly, this program is not doing anything interesting. It is just going through a "for loop" from 0 to 3 and outputs a variable named `Hello_World` at the end.

**Activity:** Can you think of a more interesting program we could use for testing.

**Hint:** If you got stuck at writing the interpreter, there is a trick. Recall that `let` is interpreted via

    let f = A in B --> (\ f . B ) A

Similarly, `let rec` is interpreted 

    let rec f = A in B --> (\ f . B ) (fix ( \ f . A)) 
    
The right hand side of the rule for `let rec` can be implemented in much the same as the right hand side of the rule for `let`.

### **Minus One or the Predecessor**

In order to write more interesting programs, we need a way to make expressions smaller as in 

    let rec fact n = if n=0 then 1 else n*f(n-1)

**Exercise:** Write the above using our definition of `let rec`. What do we need to modify? The answer lies in the encoding of `let` as syntactic sugar. But can you also eliminate the `-1`?

There is an easy way out. Surely Haskell can do `-1`, right? So why don't we use this? 

Actually, the reason why `-1` is difficult for us but easy for Haskell, is that Haskell has pattern matching. So we just add a new construct to the language

    EMinusOne. Exp2 ::= "minus_one" Exp ;   

and interpret it as

    evalCBN (EMinusOne e) = case (evalCBN e) of
        ENat0 -> ENat0
        (ENatS e) -> e

You see how elegant pattern matching here is. In fact, if we had pattern matching in our language we could implement the factorial as something like

    let rec fact = case n of
        0 -> 0
        S m -> n * f m

Nice, isn't it? But anyway, `minus_one` works as well. For example we can do `plus` now as

    let rec plus = \x.\y. if x=0 then y 
                          else S (plus (minus_one x) y) in 

    plus S 0 S S 0

**Exercise:** Explain the definition of `plus` above. Can you formulate it as a mathematical equation? The mathematical equation should prove the correctness of the program in the sense that if the program terminates it must give the correct result. Why does `plus` terminate on all inputs?


Putting things together, we can now also define more complicated functions such as fibonacci:

    let rec plus = \x.\y. 
        if x=0 then y 
        else S (plus (minus_one x) y) in 
        
    let rec fib = \n. 
        if n=0 then 0 
        else if n = S 0 then S 0 
             else plus (fib (minus_one n)) 
                        (fib (minus_one (minus_one n))) in

    fib S S S S 0 

These and similar definitions can be found in [test.lc](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lab1-Lambda-Calculus/LambdaNat4/test/test.lc) and [fib.lc](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lab1-Lambda-Calculus/LambdaNat4/test/fib.lc).

**Exercise:** Why is `fib` correct? Why does it terminate?

**Exercise:** Can your interpreter execute these programs? Make your own examples.

## The different programming languages

LambdaNat0: The pure lambda calculus.

LambdaNat1: Natural numbers added as data. 

LambdaNat2: Making plus one work.

LambdaNat3: Adding conditionals.

LambdaNat4: Adding recursion.








