# Theorem proving with Isabelle and Idris

[Continuing the lecture on induction](https://hackmd.io/@m5rnD-8SSPuuSHTKgXvMjg/BkHZL3jFS), I want to give the briefest introduction to two programming languages, Isabelle and Idris. 

Inductive definitions and proofs can be implemented in both Isabelle and Idris in a nice way and we will look at [NumExp in Isabelle](https://github.com/alexhkurz/programming-languages-2019/blob/master/NumExp.thy) and at [NumExp in Idris](https://github.com/alexhkurz/programming-languages-2019/blob/master/NumExp.idr).



[Isabelle](https://isabelle.in.tum.de) is a special purpose programming language which can do a lot of things (even general programming), but is designed to program mathematical proofs. To explain the fundamentals of how it works we look in some detail at how to prove $1+n\approx n+1$.

[Idris](http://docs.idris-lang.org/en/latest/) is a general purpose programming language inspired by Haskell, but with a much more powerful type system: Idris has so-called *dependent types*. And this allows us to use Idris not only as a programming language but also as a theorem prover. Indeed, types can be used to formulate properties of programs as types. For example, the $\approx$ relation becomes a type and the proof of $1+n\approx n+1$ a program of that type.

I encourage you to download one or both of Isabelle and Idris and play around with it. A good point to start working with Isabelle is the book [Concrete Semantics](http://concrete-semantics.org), which is available for free online. 

### The language of arithmetic expressions

The language of `num` and `exp` we defined above 

        num ::= 1 | S num 
        exp ::= num | exp + exp | exp * exp
        
is in Isabelle defined as

    datatype num = One | S num 
    datatype exp = Num num | Plus exp exp | Mult exp exp 

We replace `1, +, *` with `One, Plus, Mult`, because the former already have a meaning in Isabelle. But this is only notation. Worth noticing is that we replace `exp::=num` by `exp=Num num`. Why the extra occurrence of `Num`? One way to think about this is as a type casting which turns a `num` into an `exp`. We didn't need to write it in our mathematical notation above because we used the convention that numbers are written as $n, \ldots$ and expressions as $e,\ldots$.

Isabelle allows us to get closer to the mathematical notation by introducing some syntactic sugar, which makes the actual code look like (but the simpler one above would work just as well)

    datatype num = One ("𝟭") | S num ("_+𝟭")
    datatype exp = Num num ("⟨_⟩") | Plus exp exp (infix ":+:" 14) | Mult exp exp (infix ":*:" 15)

In Idris the language is defined as 

    data Num = O | S Num 
    data Exp = N Num | (:+:) Exp Exp | (:*:) Exp Exp
    
where we read `O` as "One".

### Equations 

Next, we definee inductively the set of equations $e\approx e'$. 

In Isabelle

    inductive equal_exp :: "exp ⇒ exp ⇒ bool" where
    equal_exp_refl:        "e ≡ex e" |
    equal_exp_symm:        "e1 ≡ex e2 ⟹ e2 ≡ex e1" |
    equal_exp_trans:       "e1 ≡ex e2 ⟹ e2 ≡ex e3 ⟹ e1 ≡ex e3" |
    equal_exp_cong_plus:   "e1 ≡ex e1' ⟹ e2 ≡ex e2' ⟹ e1 :+: e2 ≡ex e1' :+: e2'" |
    equal_exp_plusone:     "⟨n+𝟭⟩ ≡ex ⟨n⟩ :+: ⟨𝟭⟩" |
    equal_exp_assoc:       "(e1 :+: (e2 :+: e3)) ≡ex ((e1 :+: e2) :+: e3)" 

and in Idris

    data (:=:) : Exp -> Exp -> Type where 
       EqExpRefl : e :=: e
       EqExpSymm : e1 :=: e2 -> e2 :=: e1
       EqExpTrans : e1 :=: e2 -> e2 :=: e3 -> e1 :=: e3
       EqExpPlusEq : e1 :=: e1' -> e2 :=: e2' -> e1 :+: e2 :=: e1' :+: e2'
       EqExpPlusOne : (N (S n)) :=: (N n) :+: (N O)
       EqExpAssoc : e1 :+: (e2 :+: e3) :=: (e1 :+: e2) :+: e3

These two snippets of code look almost the same. Almost all differences are purely notational and not interesting. 

The one big difference that is interesting is that Isabelle has `bool` in a place where Idris has `Type`. 

In Isabelle we formalise $\approx$ by a function `equal_exp` that takes two expressions and returns a truth value. This allows us to say in Isabelle whether an equation $e\approx e'$ is derivable or not.

In Idris we decided to write `:=:` instead of $\approx$ (not important difference) and `e :=: e'` is not a boolean but a type (important). So `e :=: e'` is treated in the same way  as `Num`or `Exp`. Indeed, `e :=: e'` is a data type. Notice that the type `e :=: e'` is *dependent* on the terms `e` and `e'`.

### Proofs

We now go back to the mathematical proof

$$ 1+Sk = 1+ (k+1) = (1+k)+1 = (k+1)+1 = Sk +1$$

and the

**Exercise:** Write the chain of reasoning out in way that one can see at each step which rule among ${\ \rm (refl)\ }
, 
{\ \rm (sym)\ }
, 
{\ \rm (trans)\ }
,
{\ \rm (cong)\ }
,
{\ \rm (assoc)\ }$ is applied in the reasoning.

with the aim to get a rough idea of how this can be done in theorem provers like in Isabelle and Idris. Which rule do we have to add to the 5 above to make things work?

In both Isabelle and Idris, one has essentially to program the proof. That is, there will be a sequence of commands, or a nested call of functions, telling the program which rule to apply in which order. 

Isabelle is being developed with the aim to make machine proofs readable to humans as much as possible. And, indeed, one can write the Isabelle source code 

    lemma plusone: "⟨𝟭⟩ :+: ⟨n⟩ ≡ex ⟨n⟩ :+: ⟨𝟭⟩"
    proof (induction n)
      case One
      then show ?case by (simp add: equal_exp_refl)
    next
      case (S m)
      have "⟨𝟭⟩ :+: ⟨m+𝟭⟩ ≡ex ⟨𝟭⟩ :+: (⟨m⟩ :+: ⟨𝟭⟩)" by exp_tac
      also have      "… ≡ex (⟨𝟭⟩ :+: ⟨m⟩) :+: ⟨𝟭⟩" by exp_tac
      also have      "… ≡ex (⟨m⟩ :+: ⟨𝟭⟩) :+: ⟨𝟭⟩" by(exp_tac rule:S)
      also have      "… ≡ex (⟨m+𝟭⟩) :+: ⟨𝟭⟩" by exp_tac
      finally show ?case by simp
    qed

as the "pseudo-code"

    lemma plusone: "1+n ≡ex n+1"
    proof (induction n)
      case One
      then show ?case by (simp add: equal_exp_refl)
    next
      case (S m)
      have "1 + ⟨m+1⟩ ≡ex 1 + (m + 1)" 
      also have      "… ≡ex ( 1 + m ) + 1" 
      also have      "… ≡ex ( m + 1 ) + 1" 
      also have      "… ≡ex ⟨m+1⟩ + 1" 
      finally show ?case by simp
    qed

which, replacing `⟨m+1⟩` by $Sm$, is now easy to match with the mathematical proof 

$$ 1+Sm = 1+ (m+1) = (1+m)+1 = (m+1)+1 = Sm +1$$

I find this close match between math and programming very pleasing and I would say, well done, Isabelle.

What about Idris?

    total plusone : (n : Num) -> (N O) :+: (N n) :=: (N n) :+: (N O)
    plusone O = EqExpRefl
    plusone (S n) = 
        EqExpTrans 
            (EqExpPlusEq EqExpRefl EqExpPlusOne)
            (EqExpTrans EqExpAssoc 
        (EqExpTrans 
            (EqExpPlusEq 
                (plusone n)
                EqExpRefl) 
            (EqExpPlusEq
                (EqExpSymm EqExpPlusOne)
                EqExpRefl)))
                
Wow ... what is going on here?

The lecture is coming to end $\ldots$ so I have to leave this an exercise. But I give you some hints:

- A rule like `EqExpTrans` is now a function that takes as  arguments two proofs and produces a new proof. 
- The proof itself is then a function as well, named `plusone`.
- The induction step is now implemented as the function `plusone` calling itself recursively.

I am very excited about this last item $\ldots$ we started surveying different forms of induction and ended up discovering that inductive proofs and recursive programs are the same. 


**Remark:** The general paradigm is called "proposition as types" more often than "proofs as programs". To understand what is meant by this let us look at the Idris code snippet

    total plusone : (n : Num) -> (N O) :+: (N n) :=: (N n) :+: (N O)
    
Ignoring `total`, we can read 
- `plusone : _` as "`plusone` is an element of type `_`" 
- `(n : Num) -> _` as "for all `n` of type `Num` there is an element of type `_`"
- `(N O) :+: (N n) :=: (N n) :+: (N O)` as "$1+n=n+1$"

In other words, the proposition "$1+n=n+1$" can be read as a type. But the word "type" is short for "data type" and a data type is a set of data elements. So what are the elements here? 
[^elementsoftypes]

**Remark:** I recommend to install Idris and run the code. But I pasted in below the result of calling `plusone` on the argument 3 (remember that `O` stands here for "One"). Can you explain what happens?

    *NumExp> plusone (S (S O))
    EqExpTrans (EqExpPlusEq EqExpRefl EqExpPlusOne)
               (EqExpTrans EqExpAssoc
                           (EqExpTrans (EqExpPlusEq (EqExpTrans (EqExpPlusEq EqExpRefl
                                                                             EqExpPlusOne)
                                                                (EqExpTrans EqExpAssoc
                                                                            (EqExpTrans (EqExpPlusEq EqExpRefl
                                                                                                     EqExpRefl)
                                                                                        (EqExpPlusEq (EqExpSymm EqExpPlusOne)
                                                                                                     EqExpRefl))))
                                                    EqExpRefl)
                                       (EqExpPlusEq (EqExpSymm EqExpPlusOne)
                                                    EqExpRefl))) : (N O) :+:
                                                                   (N (S (S O))) :=:
                                                                   (N (S (S O))) :+:
                                                                   (N O)
    *NumExp> 
    




[^elementsoftypes]: Answer: The elements are the proofs `plusone n` for all `n` in `Num`. 


