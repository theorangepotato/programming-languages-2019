# Abstract Reduction Systems 3: Termination

## Recap

Let us just quickly track back through what we have done so far.

We started with developing our own small programming language, culminating in Assignment 1. This programming language was small enough so that we could give a complete and formal definition of its syntax and semantics that is both executable on a machine and understandable by a human. 

Nevertheless, LambdaNat5 was already complicated enough to justify building mathematical models that abstract from its details and allow us to study certain of its aspects in a simplified framework. This was the reason to introduce the notion of an abstraction reduction system (ARS).

We defined ARSs mathematically and studied some of their properties. In particular, we proved that an ARS that is confluent and terminating has unique normal forms. We also studied examples illustrating that this theorem justifies a general methodology that allows us to create complicated algorithms (such as the interpreter of LambdaNat5) by writing out a small set of relatively simple rules.

The two key properties underlying this methodology are confluence and termination. We will not go deeply into refining our methodology in order to prove confluence for particular systems. But we will take the time to study proving termination in more detail, because this is a central concern in algorithms in general. We will learn valuable lessons that are not only important for ARSs and term rewriting, but for software engineering in general.


## Proving Termination

Proving termination is of practicial significance to the programmer. For many years, Windows was known for crashing so often that serious  programmers or computer scientists would not touch it. One of the reasons was that device drivers would go into an infinite loop. This problem has been sorted out thanks to [formal methods](https://web.archive.org/web/20120825085504/http://research.microsoft.com:80/en-us/um/cambridge/projects/terminator/) that could automatically detect such problems. If you are interested in learning more about this take a look at [Byron Cook's webpage](http://www0.cs.ucl.ac.uk/staff/b.cook/) who has a lot of introductory and advanced material these issues. A good starting point could be [this video](https://www.youtube.com/watch?time_continue=445&v=J9Da3VsLH44) followed by the [AmazonWebServices Probable Security](https://aws.amazon.com/security/provable-security/) website.

Think of a while loop? How do you know that it terminates? Or maybe it doesnt? ... The technique that we learn now in order to show termination of ARSs will also apply to showing termination of loops in general. 

The basic idea to prove termination of an ARS $(A,\to)$ is:

Find a measure function $\phi: A \to \mathbb N$ such that $a\to b$ implies $\phi(a)>\phi(b)$.

Why does this prove termination?

Recall [our examples](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/r1D5VMedS#Examples-and-Exercises), listed for convenience again below.

**Examples:**

- $A$ is the set of integers $> 1$ and  $m\to n$ is defined to hold if $m>n$ and $n$ divides $m$.

- A is the set of finite lists (aka words) over $\{a,b\}$, $wbav\to wabv$

  - maybe first sth easier:

  - what if we have only one rule allowing to rewrite  $abb\to aa$ in every word?[^answerabb] 
  
  - or what if have only one rule allowing to rewrite  $a\to b$ in every word?[^answerab]
  
  - or what if you have both rules above?[^answerboth]

  - what now about the first question where we have one rule allowing to rewrite $ba\to ab$? [^answerbaab]

- A is the set of multisets over $\{a,b\}$, $aa\to a$, $bb\to a$, $ab\to b$, $ba\to b$

- [Langton's Ant](https://kartoweb.itc.nl/kobben/D3tests/LangstonsAnt/) is an example of an interesting ARS that is not termintating. But it nevertheless reaches some kind of stability that, even though not a normal form in the technical sense, has some resemblance with it. A point worth thinking about.




**Def:** Let $(A,\to)$ be an ARS. The function $\phi: A \to \mathbb N$ is called a measure function if $a\to b$ implies $\phi(a)>\phi(b)$.

**Fact:** If an ARS has a measure function, then it is terminating.

We have seen examples of how to use measure functions to prove termination.

What about the converse? Can we always find a measure function if the ARS is terminating?

Let us look at the following example. Working out some reductions (eg write down all reductions starting from $(4,3)$) leads us to the firm belief that it is termintatin. But what is the measure function?

**Example:** Let $A=\mathbb N\times \mathbb N$ and $(i,j+1)\to (i,j)$ and $(i+1,j)\to (i,i)$. Does it terminate? What is the measure function? [^answer] 




## References:
- Baader, Nipkow. Term Rewriting and All That. 1999
        
        Chapter 
			2.3 termination


[^answerabb]: Count the number of letters. More formally, you can implement a function ${\rm length}$ and then define $\phi_1(w)={\rm length(w)}$.

[^answerab]: Count the number of "a"s. More formally, you can implement a function ${\rm number}$ and then define $\phi_2(w)={\rm number(a,w)}$

[^answerboth]: Add the two measure functions above. More formally, define $\phi(w)=\phi_1(w)+\phi_2(w)$.

[^answerbaab]: There are several elegant solutions here. 

    - First we can map $a\mapsto 1, b\mapsto 2$, for example $baab\mapsto 2112$, where we take 2112 as a number in decimal notation. (Show that this is a measure function.)
    
    - Second, we can map a word to the set of indeces of the a's, for example $abba\mapsto \{0,3\}$ and then map the set to the sum of its indeces for example $\{0,3\}\mapsto 4$. (Show that this is a measure function.)

[^answer]: Answer: $\phi(i,j)=i^2+j$. (Show that this is a measure function.)

