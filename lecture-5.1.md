# (provisional write up of) Lecture 5.1

## Learning Outcomes

Students will be able to 

- explain the basic ideas of the two models of computation by Church and by Turing, respectively

- explain in more detail Church's model of computation as rewriting to normal form
  - build terms from operations (terms are trees)
  - rewrite terms by applying equations using pattern matching
  - equations are also called ***rewrite rules*** in this context
  - computation terminates if no rule applies
  - a term to which no rule applies is called a ***normal form***

- appreciate how important the invention of algebra in the history of science was

## Recap from Lambda Calculus

Let us compute by hand the following

    let rec plus = \x.\y. 
        if x=0 then y 
        else S (plus (minus_one x) y) in 
    plus S S 0 S S S 0

I simplify the notation a little to sace space and make it more readable, but this is what is going on:

    plus S S 0 S S S 0 -->
    S (plus (minus_one S S 0) S S S 0) -->
    S (plus S 0 S S S 0) -->
    S S (plus (minus_one S 0) S S S 0) -->
    S S (plus 0 S S S 0) -->
    S S S S S 0 

**Exercise:** Justify all computation steps.

**Remark:** Here are a few important observations.

- There is no memory and no side effects.
- All the information is in the data.
- Computation proceeds by rewriting data.
- Rewriting data proceed by matching rules to the data.
- The rules are the ones defined by `evalCBN` of `Interpreter.hs`
- At each point of the computation the next step is determined by the rules and the data only. There is no state, nothing to remember.
- The computation stops when there is no further rule to apply.

For the next few lectures we will study this model of computation. It is also known as Term Rewriting and goes back to mathematicians such as Church and Post.

In order to simplify the presentation, we explain everything at the hand of high-school algebra. This is simpler than lambda calculus but all the main ideas can be explained there as well. (Btw, this is similar to parsing where all the essential ideas could be illustrated with parsing strings like `1+2*3`).
    

## Models of computation

Before presenting our first model of computation in the standard mathematical style, let us pretend we we were researchers a hundred years ago.

How would you approach the question
	"What is computation?"

One answer was given by Turing (and we reviewed his work in a previous lecture), but his answer leads to hardware, architecture, computability and complexity theory, etc. All very interesting topics, but rather on the periphery of programming languages. So we will take another route that directly links up with what we have seen at work when we implemented an interpreter for Lambda Calculus.

### Numbers

So let us pretend we are researchers a hundred years ago.

What are the easiest examples of computation?
- Addition
- Multiplication

For the easiest example, they are surprisingly complicated. Why? Because we represent numbers as decimals. 

Let us simplify:
		
	What happens if we represent numbers in the unary numeral system?
		let us introduce some notation, 1, +
		now we can write all postive integers using abbreviations such as 3 to stand for (1+1)+1
		what equations do we need to calculate 2 + 3 = 5 ? Get out pen and paper and do this.
			[Interlude: for a programmer terms are trees]
			(1+1)+((1+1)+1) = ... = ((((1+1)+1)+1)+1)
		what equations do we need to calculate 2 x 3 = 6 ? Get out pen and paper and do this.
			[...]
	Can we write down the equations?
		associativity of +, distributivity of x
		what about the other equations such as commutativity? Not needed so far ...
			[maybe there is room for someinvestigation here ...]
    
Stocktaking: What did we learn about computation from this?
- terms are trees
- computing with terms via rewriting terms using equations
- very important question:
  - can we prove/disprove (decide) all equations?
  - [possible interlude/excursion on decidability]
- which leads to the related question:
  - how do we know that we are finished with a computation? 
  - [possible interlude/excursion on termination]
- answer (in a nutshell): rewriting to normal form
  - expand on this ...

### Remarks:

- In class we contrasted the idea of rewriting equations as a model of computation, first studied by [Alonzo Church](https://en.wikipedia.org/wiki/Alonzo_Church) in detail, with the model of computation proposed by [Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing), namely the [Turing machine](https://en.wikipedia.org/wiki/Turing_machine). I simplified a lot by explaining how the Turing machine is a model of computation well suited to imperative programming languages and hinted at how rewriting is a suitable model for functional programming. I now want to add a note of warning, this is really an over simplification and both models of computation are relevant for all programming languages. Maybe one way of understanding this is that both models of computation are equivalent, even if they look different. The equivalence of all models of computation is known as the [Church-Turing thesis](https://en.wikipedia.org/wiki/Church–Turing_thesis).
- Btw, the original paper of Turing [On Computable Numbers, with an Application to the Entscheidungsproblem](https://londmathsoc.onlinelibrary.wiley.com/doi/epdf/10.1112/plms/s2-42.1.230) is worth reading and in the first section he explains his rationale for the Turing machine.



### Answers to some questions raised above:

For the language given by

        num ::= 1 | num + 1
        exp ::= num | exp + exp 
 
the equation

        X + (Y + Z) = (X + Y) + Z
        
is enough to calculate all additions. If we replace the definition of exp by 

        exp ::= num | exp + exp | exp * exp

we need to add equations

	X * 1 = 1
	X * Y = Y * X
	X * ( Y + Z ) = X * Y + X * Z

Note that we do not need `X + Y = Y + X`. This is only needed if we add variables, that is, if we replace the definition of exp by 

        exp ::= num | exp + exp | exp * exp | x

where `x` ranges of a set of "variables". 

What about associativity of multiplication `X * ( Y * Z ) = ( X * Y ) * Z` ?

And are the equations above really enough? What equations need to be added if we want `+1` to a unary operation different and not composed from  the binary `+` and `1`?

## Algebra

(we talked about how it is important in research to simplify a problem in the right way; we learned some basic ideas: computation as rewriting to normal form; now let us make things more complicated again and see how far we can go ... there are many ways to do this: negative numbers, binary numbers (or decimals), exponentiation, square roots, calculus, if-then-else, etc etc ... but we will look at something else first, namely how to go from numbers to algebra, or from primary school to secondary school)


How far did we go in our quick tour of school mathematics? Roughly primary school, computing with numbers. 

Algebra induces a radical new big idea: instead of thinking of variables as place holders for terms/numbers: variables as "first class citizens"

Historically, this did not come easy. The first time the method of algebra appears fully developed in most of its basic ideas is a turning point in history. Please have a look at [Descartes' Geometry](http://www.gutenberg.org/ebooks/26400), first published in 1637. (It is always worth looking at Wikipedia so read up on [Descartes](https://en.wikipedia.org/wiki/René_Descartes) who led a very interesting live that is full of amusing anecdotes and his books, the [Discourse on the Method](https://en.wikipedia.org/wiki/Discourse_on_the_Method) and its appendix, the [Geometry](https://en.wikipedia.org/wiki/La_Géométrie), are, in (not only) my opinion the most important publications in philosophy and mathematics of all time. 

It is well worth to spend a few minutes and quote the four steps of [Desacrtes' scientific method](https://en.wikipedia.org/wiki/Discourse_on_the_Method#Part_II:_Principal_rules_of_the_Method).

A great resource on  philosophy and logic and some areas of mathematics is the Stanford Encyclopedia of Philosophy which also has an article on [Descartes mathematics](https://plato.stanford.edu/entries/descartes-mathematics/).) Even if you don't read French, just by browsing through the pages, you see that Descartes, who just escaped the middle ages, did write in a style that is still readable today and that looks like modern mathematics. You can also look at a facsimile of the original. Even without trying to understand the maths in detail, I found for example [page 301 of the original](https://fr.wikisource.org/wiki/Page:Descartes_La_Géométrie.djvu/11) worth looking at. We see that he didnt use "=" (which, in fact, was introduced already earlier by [Robert Recorde](https://en.wikipedia.org/wiki/Robert_Recorde) in 1557 but not widely used yet), but that otherwise all the basic ideas of algebra are already there. 

		Little research project: Why did Descartes use a symbol for "=" that is not symmetric? 
		Could there be a connection to the idea of rewriting that we mentioned above?
		
Putting Descartes in historical context can help to appreciate his importance. He was a generation younger then Galileo and a generation older than Newton. Looking at Galileo's [theorems of motion](http://galileoandeinstein.physics.virginia.edu/tns_draft/tns_153to160.html) as formulated by himself in the celebrated [Discourses and Mathematical Demonstrations Relating to Two New Sciences](https://en.wikipedia.org/wiki/Two_New_Sciences), we see that he needs 6 theorems with complicated proofs in order to express the simple equation d=v*t because he does not have the algebra of Descartes. (Thanks to Andrea DiSessa, Changing Minds (2002) for pointing this out.) But just a generation later, Leibniz and Newton were able to extend Descartes' algebra of variables and numbers to an algebra of functions, including operations of differentiation and integration.
	
Ok, after this historic excursion, let us go back to calculating with terms containing variables.

		do we need new equations?
			what, for example, about (x+y)+x = 2x+y ? Get out pen and paper.
		needs commutativity
		write out all equations we have so far (could do this together at the whiteboard)
		innocent but important question: how do we know that we have all equations?

The answer to the last question, leads to the next topic, the title of which contains the four big ideas of syntax, semantics, soundness and completeness.

But first, we could use this opportunity to get used to consult research literature. The problem we have been discussing has an interesting history and drew the attention of some real heavyweights. Read up to (and excluding) Section 1.1 of the [article by Burris and Yeats](https://www.math.uwaterloo.ca/~snburris/htdocs/MYWORKS/PREPRINTS/saga.ps). 

Also read the Wikipedia article on [Tarski's High School Algebra Problem](https://en.wikipedia.org/wiki/Tarski%27s_high_school_algebra_problem).

### Homework
Read up to (and excluding) Section 1.1 of the [article by Burris and Yeats](https://www.math.uwaterloo.ca/~snburris/htdocs/MYWORKS/PREPRINTS/saga.ps). Can you summarise its contents? (I don't expect you to understand all of it and we will explain everything in detail ... but if you try to understand the main ideas now, you will understand better what follows.)

### Summary of big ideas
 - terms are trees (maybe only a small idea? But it is of fundamental importance)
 - variables as first class citizens (ideas can seem small in hindsight, that is why I emphasised Descartes)
 - syntax (syntax has no meaning, just given by "naked" rules)
 - turning equations into rewrite rules
 - computation as rewriting to normal form
 - side effect free computation: all the state is in the term

 
### Summary of jargon
  - rewrite rule
  - normal form
  - pattern matching
  - syntax
  - abstract syntax
  - BNF
  - syntactic sugar
  - ... 
 
  
 


