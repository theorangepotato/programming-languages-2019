# README

For MACOS users who have problems with finding `alex` or `happy` after installing the Haskell platform. 

### finding files in OS

Run `echo $PATH` to see what is in your path. 
In particular, check that you have a directory `/usr/local/bin` and that it is in the path. If not add it to your path.

After installing the Haskell platform, I would expect `/usr/local/bin` to contain `alex` and `happy`. Another place to look for is `/Users/YOURUSERNAME/Library/Haskell/bin`. 

You can also use the MACOS Finder to search for system files. For example, search for `alex`, then click the `+`-symbol on the right (or find `Search Options` in the menue) and look under `Other` on the left for `System Files` and include them in your search. Then you should find programs such as `alex` or `happy` if they exist at all.

### `alex` and `happy` do not come with the haskell platform

One thing that helped in some cases was to run `stack install alex` and `stack install happy`. For some reason `alex` and `happy` where in the wrong place, but after moving them from `.local/bin` to `/usr/local/bin` things worked.

