# README

This directory contains the parser produced using BNFC from the grammar Calc.cf from the BNFC tutorial.

To generate a **parser** from the grammar run

    bnfc -m -haskell Calc.cf
    make

To generate the **interpreter** run

    ghc --make Calculator

To parse some arithmetic expressions run the program `TestCalc` in a terminal as for example in

    echo "1+2*3" | ./TestCalc
    
which produces the linearized abstract syntax tree

    EAdd (EInt 1) (EMul (EInt 2) (EInt 3))

To evaluate some arithmetic expression run `Calculator` in a terminal as for example in

    echo "2+3" | ./Calculator 

which produces

    5

**Exercise:** Compare the linearized tree with the grammar [Calc.cf](https://github.com/alexhkurz/programming-languages-2019/blob/master/Calculator/Calc.cf). Explain how the tree is produced from the string.

**Exercise:** Write `EAdd (EInt 1) (EMul (EInt 2) (EInt 3))` in the more familiar two-dimensional notation.

**Exercise:** Compare the abstract syntax trees you get as an output above with those of

        echo "2 + 3" | ./TestCalc
        echo "((2) + 3)" | ./TestCalc
        
        etc
        
What do you learn about spaces and parentheses?

If you have installed BNFC, you may want to change the grammar and produce a new parser, so that you can also parse expressions with variables. See [here](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md) and [here](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-example.md) for details.



