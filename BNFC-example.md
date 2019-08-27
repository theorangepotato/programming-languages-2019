# BNFC Self Check

If you installed bnfc, test the parser according to the following instructions. 

## Exercise: Parsing a lambda calculus program.

Download [test-xxyz.lc](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/test/test-xxyz.lc) and save it as a file called

    test-xxyz.lc
  
You also need the grammar [LambdaNat.cf](https://github.com/alexhkurz/programming-languages-2019/blob/master/Lambda-Calculus/LambdaNat/grammar/LambdaNat.cf).

Run

    bnfc -m -haskell LambdaNat.cf
    make
    ./TestLambdaNat test-xxyz.lc

and check that you get the answer

        Parse Successful!

followed by the [Abstract Syntax] and the [Linearized tree].


## Exercise:

Write a lambda calculus program that adds plus one and parse it. 

## Exercise:

Build your own program and parse it. Play around to get a feel for which programs parse and which do not. If you are adventurous, feel free to modify the grammar as well. Come to my office hours or ask in the lectures if you have questions.
