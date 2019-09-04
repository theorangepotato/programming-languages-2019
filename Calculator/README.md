# README

This directory contains the parser produced using BNFC from the grammar Calc.cf from the BNFC tutorial.

To parse some arithmetic expressions run the program `TestCalc` in a terminal as for example in

    echo "2+3" | ./TestCalc
    
Compare the abstract syntax trees you get as an output above with those of

        echo "2 + 3" | ./TestCalc
        echo "((2) + 3)" | ./TestCalc
        
        etc
        
What do you learn about spaces and parentheses?

If you have installed BNFC, you may want to change the grammar and produce a new parser, so that you can also parse expressions with variables. See [here](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md) and [here](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-example.md) for details.


