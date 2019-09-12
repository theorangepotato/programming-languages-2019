# README

The original file of this folder is `LambdaNat.cf`.

All other files of this folder have been produced using bnfc by running the following in this folder (this requires a Haskell and bnfc installation).

    bnfc -m -haskell LambdaNat.cf
    make
    
In particular, these commands produce the LambdaNat parser 

    TestLambdaNat
   
To parse a program such as `\x.x` run

    echo "\x.x" | ./TestLambdaNat
    
or save the program into a file `file` and run

    ./TestLambdaNat file

