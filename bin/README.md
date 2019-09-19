# README

(For MACOS users with installation problems.)

I put here some executables in the case that the MACOS installation of `bnfc` or `alex` or `happy` does not work. 

First try eg `which alex` to see whether the operating system finds the executable. Also run `echo $PATH` to see what is in your path. 
In particular, check that you have a directory `/usr/local/bin` and that is is in the path. If not add it to your path. 

If `/usr/local/bin` does not contain `bnfc` or `alex` or `happy`,
another place to look for is `/Users/YOURUSERNAME/Library/Haskell/bin`. 

You can also use the MACOS Finder to search for system files. For example, search for `alex`, then click the `+`-symbol on the right and look under `Other` on the left for `System Files` and include them in your search. Then you should find programs such as `alex` or `happy` if they exist at all.

If you cannot locate `bnfc` or `alex` or `happy` in any way, 
try the following.

`cd` into (your git clone of) this directory.

Run `./bnfc` etc to check that these executables run on your machine.

Run `cp bnfc /usr/local/bin` or `cp alex /usr/local/bin` or `cp alex /usr/local/bin` as appropriate.

Run `bnfc` or `alex` or `happy` in the commandline to check that these executables are now found by the operating system.
