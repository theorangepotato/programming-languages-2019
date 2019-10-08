# Exercises

I collect here exercises to practice the material that will be the subject of the midterms and of the final exam.

But remember that there also are exercises scattered throughout the lecture notes.

The exercises you can hand in to me on pen and paper, send to me via email, discuss in my office hours (Tue/Thu 2-3.30 or by appointment).


## Abstract Reduction Systems

To do the exercises you need to use the material about [equivalence relations](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/SJ1cc-dDr) and [syntax and semantics](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/Sy3oqhpvH) and [abstract reduction systems](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/S1zQfzedS) and [termination](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/H1jhgxmur).

---

### Basic examples

The first exercise is meant to be easy. If it is not,  and assuming that you revised the material linked above, the reason must be that I didn't explain some background you need  ... let me know if this is case.

#### Exercise (String rewriting)
In this exercise we rewrite strings over letters `a,b` and write `w -> w'` for a pattern or schema of rules that allows to reduce strings by replacing any occurrence of `w` by `w'`. The rule schema `w ->` allows us to erase `w` from any word in which `w` occurs.

- Consider the schemas of rules

        ab -> ba
        ba -> ab
        aa ->
        b ->
  - Reduce some example strings such as `abba` and `bababa`.
  - Why is the ARS not terminating?
  - How many equivalence classes does $\stackrel{\ast}{\longleftrightarrow}$ have? Can you describe them in a nice way? What are the normal forms?
  - Can you change the rules so that the ARS becomes terminating without changing its equivalence classes? Which measure function proves termination of your modified system?
  - Write down a question or two about strings that can be answered using the ARS. Think about whether this amounts to giving a semantics to the ARS.
  
- Consider the schemas of rules

        ba -> bbaa
        aa ->
        ba -> ab
        ab -> ba
     
     - Can one reduce `ab` to `aabb`?
     - Can one reduce `ba` to `abbaababbab`?
     - Can one reduce `ba` to `abbaababbaba`?
     - Can you find a nice way of stating which words are in the equivalence class of `ba`?
     - Can you list some properties of words that remain invariant under application of rules?[^invariant]
     - Can you describe all equivalence classes? (I didn't do this one myself ... don't know exactly how much work it requires.)
     - Can you change the rules so that the ARS becomes terminating without changing its equivalence classes? Which measure function proves termination of your modified system?
     
---
        
The purpose of the next exercise is for you to apply the new technical notions to an example you know well already. (We have done some of this exercise in class already, but it would be good to do it again at home.)

#### Exercise (Fractions)

- To simplify, we only consider positive fractions. Define an equivalence relation $\equiv$ on the set $\mathbb N\times \mathbb N$ such that the set $\mathbb N\times \mathbb N/{\equiv}$ of equivalence classes is in bijective correspondence with positive fractions. (Hint: $\equiv$ needs to capture that, eg, in mathematics $1/3=2/6$; this will correspond to $(1,3)\equiv(2,6)$.[^fractions])
- Define an ARS $(\mathbb N\times \mathbb N,\to)$ that has unique normal forms. Argue why your ARS has unique normal forms.
- Explain how to add and multiply normal forms.

In the exercise, the bijective correspondence of equivalence classes with positive fractions sets up a semantics as discussed [here](https://hackmd.io/s/SyIA3Lx_Q). The point of the exercise was to work from the semantics towards a syntax that captures it. 

---

In the next exercise, we work in the other direction. I give you an ARS that will look unfamiliar to you. Can you find an interpretation, or maybe just an invariant (see the footnotes) and use it to show that the string `OK` cannot be reached from `OR`?

#### Exercise (ORK)

    If the last letter is R you may add a K at the end 
    A string of the form Ox may be rewritten to Oxx
    You may replace any occurrence of RRR by K
    You may erase any occurrence of KK

Above, `x` is a variable that maybe replaced by any string.

- Describe an ARS $(A,\to)$ that is given by the 4 rules above.
- Give some sample reductions. Can you reduce `OK` to `OR`?
- Is it possible to reduce `OR` to `OK`?

As it often happens with this kind of exercises, it can be quite tricky until you suddenly see the solution. But trying to understand what is going on pays off in any case. 

---
        
The next exercise illustrates that there is a tight connection between reductions in ARSs and the evaluation of recursive functions. In fact, ARSs are the model of computation behind recursive functions.

        
#### Exercise (The A-function)
The A-function has a recursive definition as follows.

    a(0,n) = n+1
    a(m+1,0) = a(m,1)
    a(m+1,n+1) = a(m, a(m+1,n))

- Write out some recursive computations by hand such as a(1,2). 
- Challenge: What are the biggest numbers $n,m$ for which you can compute $a(n,m)$? (Hint: Feel free to use a computer to get to bigger numbers.)
- Can you find an interpretation of the A-function?
- Bonus question: If you let $n$ in the first equation range not over numbers but over expressions, then the ARS defined by reading the equations from left to right is non-deterministic.[^deterministic] Is it confluent?

---
The next example is typical for a situation where the elements of the ARS are not mere strings but terms. We encountered this before when we discussed arithmetic expressions. Recall how terms really are trees, even if written in linear (or, as we sometimes say, one-dimensional) notation. 


#### Exercise (Sorting)
Consider the ARS, from [Dershowitz: A Taste of Rewrite Systems](http://citeseerx.ist.psu.edu/viewdoc/download;jsessionid=FC8676559B7A991F184EA8DA76458837?doi=10.1.1.31.6812&rep=rep1&type=pdf), given by 

    max(0,x) -> x
    max(x,0) -> x 
    max(s(x),s(y)) -> s(max(x,y))
    min(0,x) -> 0
    min(x,0) -> 0
    min(s(x),s(y)) -> s(min(x,y))
    sort([]) -> [] 
    sort([x | xs]) -> insert(x,xs)
    insert(x,[]) -> [x]
    insert(x,[y|ys]) -> [min(x,y)|insert(max(x,y),ys)]
    
where
- operation symbols are 
  - constants: `[]` and `0`
  - unary:  `s` and `sort`
  - binary:  `[-|-]` and `min` and `max` and `insert`
- and variables are `x` and `y` and `xs` and `ys`

Do the following exercises.
- Give small examples of reductions for each of `min`, `max`, `sort`, `insert`. 
- Discuss the properties of termination, confluence, unique normal forms in this example.
- In what sense, if at all, is it appropriate to consider `min`, `max`, `sort`, `insert` as functions? Your answer should make use of what we learned about syntax and semantics.
- Compare this example with the implentation of `sort` in Assignment 1. What are the similarities and what are the differences? Make two lists summarising your observations.

---

## Termination

(The termination exercises are taken from the book by Baader and Nipkow.)

**Exercise:** Show that whatever the test `<TEST>` the program below

    while ub > lb + 1 do
    begin r : = (ub + lb) div 2;
    if <TEST> then ub := r else lb := r
    end 

terminates. Are there any assumptions you need do make the argument work?

**Exercise:** Show that the two programs

    while m =/= n do
      if m > n then m := m — n else n := n — m

and

    while m =/= n  do
      if m > n then m : = m — n
      else begin h :=m; m :=n; n := h end

terminate. Are there any assumptions you need do make the argument work?

**Exercise:** Take a program with a while loop from on of your other courses and show termination by exhibiting a measure function. 


---
---

The exercises below relate to material that has not been taught yet.

---

## Term Rewriting Systems

#### The basic examples as TRSs

Review the Basic Examplesabove and describe them in terms of TRSs. What are the signature, variables and equations? [^signature]

### Exercise on TRSs 

(This exercise is optional.)

Choose a simple algorithm and formulate it as a rewriting system as in the exercise on sorting above. Add in as much as you want and can of the material we learned so far, including the lectures on [TRSs]().



## Partial correcteness of while-loops

**Exercise:** What do the following two programs compute? What pre and postconditions can be used to formalise this? Find a loop invariant and use it to prove the partial correctness of this program.

1)

        while (i < 100 ) do
            y := y+x
            i := i+1  
        done

2)

        while  (i < k ) do
            i := i+1 
            y := y*i
        done



**Exercise:** Go back to your program and the exercise on termination of a while loop. Discuss the partial correctness of the loop. (Or, alternatively, choose another program with a while loop.)

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

