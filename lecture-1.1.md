# Introduction

The course will have a practical and a theoretical component.

- *The theoretical component* will teach some of the discrete mathematics that forms the background to understand principles of programming languages. These include the very basics of logic, rewriting, ordered structures, universal algebra, type theory, etc. 

- *The practical component* will be about building a small programming language. We will start with the smallest practical programming language known as lambda calculus and then extend it with features. There will be room for invention and adventure there if you feel like it. But there will also be guided exercises.

**Assessment:** The theoretical component will be assessed by a final exam worth 30% and a number of tests during the semester worth together 20%. The practical component will be assessed by a short essay and presentation worth 20% and a number of programming exercises during the semester worth together 30%. There may also be unnannounced short quizzes at the beginning of a lecture to provide feedback to students and lecturer. These quizzes do not contribute to the final grade.

**Homework:** Most lectures will finish with some homework. Homework is not graded but feel free to hand it in for feedback or come into my office hourse to discuss. Homework is essential to achieve the learning outcomes.

**Creating our own little programming language** will be an important part of the course. This will involve using the tool BNFC as well as learning some of the programming Haskell. 

**BNFC**: BNFC is a tool that helps creating your own programming language. A more in depth study of the tool will be part of the Compiler Construction Course. For this course, for most of the exercises you will get template files. But later, or if you want to conduct your own developments and experiments, you will have to have BNFC installed, so why not start right now. Here are the instructions to follow:

- [BNFC: basic installation instructions](https://github.com/alexhkurz/programming-languages-2019/blob/master/BNFC-installation.md)  

**Haskell** is the leading functional programming language and will be of interest to the course for a number of reasons:

 - Haskell, even though a powerful general purpose language, has been  called a domain specific language for creating programming languages for a good reason.
 
 - Haskell is the langauge in which many tools (such as BNFC) in the area of Programming Languages are implemented.
 
 - Haskell is a lazy functional programming language and, thus, a prime example of an important paradigm in Programming Languages.
 
 - Haskell is an elaboration of the lambda calculus, which also forms the basis for our own small programming language that we will consider in the exercises of this course.
 
 - Haskell is the language in which we will write the interpeter used to execute our programming language.
 
 - Haskell's semantics is based on rewriting, which forms one of the central theoretical concept of the course.
 
 - Last but not least, Haskell is gaining popularity in industry applications for a number of important reasons, such as self-documenting code, a strong type system, side-effect free parallelizable code, ... so some of you may be interested in adding Haskell to the portfolio of your programming languages.
 
 **Lambda Calculus** is the smallest practical [Turing complete](https://en.wikipedia.org/wiki/Turing_completeness) programming language. It is important to this course for a number of reasons:
 
 - Because it is small it is easily explained and a good starting point for experimentation.
 
 - Lambda Calculus is minimal in that all it has is
   - abstraction, that is, the ability to declare a formal parameter and 
   - application, that is, a mechanims to substitute an argument for a formal parameter.
 
 - Lambda Calculus can be evaluated according to different strategies, in particular call by value and call by name.
 
 - Lambda Calculus can be extended in various ways: types, addresses, references, ...
 
 - Lambda Calculus is the basis for many fully fledged programming languages such as Lisp, Scheme, ML, Haskell, Ocaml, ...
 
 **Homework:** Install the [Haskell Platform](https://www.haskell.org/downloads/#platform) available at [Haskell](https://www.haskell.org/) on your machine.
