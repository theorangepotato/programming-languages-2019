# README

(For MACOS users whith installation problems.)

I put here some executables in the case that the MACOS installation of `bnfc` or `alex` or `happy` does not work. 

First try eg `which alex` to see whether the operating system finds the executable. Also run `echo $PATH` to see what is in your path. 
In particular, check that you have a directory `/usr/local/bin` and that is is in the path. If not add it to your path. 

If `/usr/local/bin` does not contain `bnfc` or `alex` or `happy`,
another place to look for is `/Users/YOURUSERNAME/Library/Haskell/bin`. If you cannot locate `bnfc` or `alex` or `happy` in any way, 
try the following.

`cd` into this directory.

Run `./bnfc` etc to check that these executables run on your machine.

Run `cp bnfc /usr/local/bin` or `cp alex /usr/local/bin` or `cp alex /usr/local/bin` as appropriate.

Run `bnfc` or `alex` or `happy` in the commandline to check that these executables are now found by the operating system.
