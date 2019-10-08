# Abstract Reduction Systems 3: Termination


Proving termination is of practicial significance to the programmer. Windows was known for crashing so often that serious  programmers or computer scientists would not touch it. One of the reasons was that device drivers would go into an infinite loop. This problem has been sorted out thanks to formal methods that could automatically detect such problems.

Think of a while loop? How do you know that it terminates? Or maybe it doesnt? ... The technique that we learn now in order to show termination of ARSs will also apply to showing termination of loops in general. 

The basic idea to prove termination of an ARS $(A,\to)$ is:

Find a measure function $\phi: A \to \mathbb N$ such that $a\to b$ implies $\phi(a)>\phi(b)$.

Why does this prove termination?

Recall [our examples](https://hackmd.io/NPrGI0XTSviEhw2KBAevrA#Examples), listed for convenience again below.

**Examples:**

- $A$ is the set of integers $> 1$ and  $m\to n$ is defined to hold if $m>n$ and $n$ divides $m$.

- A is the set of finite lists (aka words) over $\{a,b\}$, $wbav\to wabv$

  - maybe first sth easier:

  - what if we have only one rule allowing to rewrite  $abb\to aa$ in every word?[^answerabb] 
  
  - or what if have only one rule allowing to rewrite  $a\to b$ in every word?[^answerab]
  
  - or what if you have both rules above?[^answerboth]

  - what now about the first question where we have one rule allowint to rewrite $ba\to ab$? [^answerbaab]

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

[^answerbaab]: Leaving this as an exercise for now, will see a simpler solution later when we learned about lexicographic orderings.

[^answer]: Answer: $\phi(i,j)=i^2+j$.

