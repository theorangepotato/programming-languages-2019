# Exercises, Part 3

## Abstract data types

### Exercise on sets and lists
Describe the data-types of lists and sets by operations and equations. For the operations you may have a look at [lists in python](https://docs.python.org/3/tutorial/datastructures.html#more-on-lists) and [sets in python](https://docs.python.org/2/library/stdtypes.html#set) but choose a small set of operations that seem essential. 
- Which operations make sense for both lists and sets? 
- Restricting attention to these operations, is there a homomorphism from lists to sets? What is the congruence relation on lists induced by that homomorphism?
- How do lists and sets differ in terms of operations and in terms of equations that the operations satisfy?

## Lambda Calculus

### Exercise on reducing lambda terms

Reduce the following lambda terms

- Reduce $$(\lambda m.\lambda n. \lambda f. \lambda x. m f( n f x))(\lambda f.\lambda x. f(x))(\lambda f.\lambda x.f(x))$$ to normal form using only the $\beta$-equation.[^alpha]

- $fix_F\,2$ where $F$ stands for 
$$\lambda f.\lambda n. \texttt{ if } n==0 \texttt{ OR } n==1 \texttt{ then } 1 \texttt{ else } f(n-1) + f(n-2)$$
You may use the following equations:
  - $\beta$-equation
  - $fix_F = F(fix_F)$
  - all equations you know involving numbers and $+$ and $-$.
  
 - Are all reduction sequences starting from $fix_F\,2$ finite?
  
### Exercise on typing lambda terms

Decide whether the folloing lambda terms are typable. If they are typable, derive the most general type. Justify your answer.

- $\lambda x.\lambda y. x$
- $\lambda f.\lambda x. f(f(x))$
- $\lambda m.\lambda n. \lambda f. \lambda x. m f( n f x)$
- $\lambda f. (\lambda x.f(xx))(\lambda x.f(xx))$

---

## Further exercises

The exercises in this section should be fun or be intersting for various reasons, but if you have done the ones above you should  be fine.

#### Exercise (More ARS examples):

    Show that the following process always terminates. There is a box full
    of black and white balls. Each step consists of removing an arbitrary
    ball from the box. If it happens to be a black ball, one also adds an
    arbitrary (but finite) number of white balls to the box.

#### Exercise (More algorithms):

    Go back to your class on data structures and algorithms 
    and find an algorithm based on a while-loop and analyse it 
    from the point of view of invariants and partial correctness. 
    
#### Exercise (More Hoare rules):
    
    Suggest a rule to add in Hoare Logic for the statement

            repeat S until B

    The repeat statement first executes the statement S 
    and then checks for the condition B.
    
#### Exercise (equivalence/congruenc relations):

Let us look at the function
$$price:Goods\to Price$$

that maps a good to its price. For our purposes, we can identify $Price$ here with $\mathbb N$.

- Discuss different real world situations in which $price$ is a homomorphism or not.
- Define the equivalence/congruence relation corresponding to $price$. 
- Discuss ways to determine whether two goods have the same price in a society where there is no money. In other words, how do you define the equivalence relation without referring to the function?



[^invariant]: A function $P:A\to B$ is an ***invariant*** for an ARS $(A,\to)$ if 
$$ a\to b \ \Longrightarrow \ P(a)=P(b)$$ for all $a,b\in A$.

[^deterministic]: An ARS $(A,\to)$ is ***deterministic*** if for all $a\in A$ there is at most one $b\in A$ such that $a\to b$.

[^fractions]: Assuming that you encode the fraction $1/3$ as the pair $(1,3)$ ... which makes sense but ultimately is an abritrary choice; many other encodings would be possible.

[^alpha]: We take lambda-terms here up to $\alpha$ equivalence, so you may rename bound variables at any point in your computation without explicitely invoking a rule.

[^signature]: STOP reading if you do not want to see hints at the solution.
    - In case of string rewriting, the question is what are the operations that we use to form words such as `aba` from letters `a` and `b`? There are at least three possibilities.
      1. Empty word, binary concatenation and constants for the letters. This needs some equations.
      2. Unary operations for each letter. This does not need any equations.
      3. One $n$-ary operation for each natural number $n$ to construct a lists lenght $n$.
    - In case of the sorting example, the signature is given by constants `0`, `[]`, unary operation symbols `s`, `sort`, and binary operation symbols `[-|-]`, `min`, `max`,  and `insert`. We can also refine this to a "many-sorted signature" by introducing types `nat` and `natlist` and say that operation symbols are typed as follows (in, hopefully, self-explanatory notation)
    
            0 : nat
            s : nat -> nat
            max : nat,nat -> nat
            min : nat,nat -> nat
            [] : list
            [-|-] : nat, natlist -> natlist
            insert : nat, natlist -> nat
            sort : natlist -> natlist

