# README

(For MACOS users with installation problems.)

Run `echo $PATH` to see what is in your path. 
In particular, check that you have a directory `/usr/local/bin` and that is is in the path. If not add it to your path.

After installing the Haskell platform, I would expect `/usr/local/bin` to contain `alex` and `happy`. Another place to look for is `/Users/YOURUSERNAME/Library/Haskell/bin`. 

You can also use the MACOS Finder to search for system files. For example, search for `alex`, then click the `+`-symbol on the right and look under `Other` on the left for `System Files` and include them in your search. Then you should find programs such as `alex` or `happy` if they exist at all.

## `alex` and `happy` do not come with the haskell platform

One thing that helped in some cases was to run `stack install alex` and `stack install happy`. For some reason `alex` and `happy` where in the wrong place, but after moving them from `.local/bin` to `/usr/local/bin` things worked.

## `bnfc` does not compile on macos

I put here the executable `bnfc` in the case that the MACOS installation of `bnfc` does not work. 

If you cannot locate `bnfc` in any way, try the following.

`cd` into (your git clone of) this directory.

Run `./bnfc` etc to check that these executables run on your machine.

Run `mv bnfc /usr/local/bin`.

Run `bnfc` in the commandline to check that these executables are now found by the operating system.
