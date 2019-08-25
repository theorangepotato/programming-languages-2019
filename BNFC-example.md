# BNFC Self Check

If you installed bnfc, test the parser according to the following instructions. 

## Exercise: Parsing a lambda calculus program.

Download [plus_one.lc]() and save it as a file called

    plus_one.lc
  
You also need the grammar [Lambda1.cf]() 

    Lambda1.cf

Run

    bnfc -m -haskell Lambda1.cf
    make
    ./TestLambda1 plus_one.lc

and check that you get the answer

        Parse Successful!

followed by the [Abstract Syntax] and the [Linearized tree].


## Exercise:

Write a lambda calculus program that adds plus two and parse it. 

## Exercise:

Build your own program and parse it. Play around to get a feel for which programs parse and which do not.
