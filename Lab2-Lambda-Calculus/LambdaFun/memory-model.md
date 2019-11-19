# The Memory Model

We will look at the memory model. The memory is divided in an inmutable stack [^immutable-stack] 

and a mutable heap. To see the difference, run

    λ val a = new [] ;;

which creates a new variable `a` on the stack and a new memory cell (address) on the heap. To see this run

    λ :env

upon which we get to see a full list of the stack (called `Env` below for environment) and the heap (called `Memory` below). I only show part of the overall output.

    Env:
    "a" -> <address 0>
    Memory:
    0 -> Nothing
    
This tells us that the value of `a` is `address 0` and that the memory at address `0` has not been initialised.

**Exercise:** Go through the following list of commands and each time list the environment using `:env`.

    λ val b = new [];;     
    λ b:= a;;
    λ b:= !a;;

The names `a` and `b` are on the stack. Their values, which are addresses, do not change. 

On the other hand, the addresses themselves are on the heap and their values can be changed using assignment `:=`.

**Exercise:** Explain the difference between 

    λ b:= a;;
    λ b:= !a;;

[^immutable-stack]: The stack is mutable at the top level. This can be seen by 

        λ val i = 0;;
        λ i;;
        λ val i = i+1;;
        λ i;;

    but this does not work insdide a function.