(* Samuel Balco and Alexander Kurz, Sept 2018 *)

section "Arithmetic Expressions"

theory NumExp imports Main "HOL-Eisbach.Eisbach" begin

subsection "Arithmetic Expressions"

(* num ::= 1 | num + 1 
   exp ::= num | exp + exp | exp * exp *)

datatype num = One ("\<one>") | S num ("_+\<one>")
datatype exp = Num num ("\<langle>_\<rangle>") | Plus exp exp (infix ":+:" 14) | Mult exp exp (infix ":*:" 15)

fun eval_num :: "num \<Rightarrow> int" where
"eval_num \<one> = 1" |
"eval_num (num+\<one>) = (eval_num num) + 1"

value "eval_num \<one>"
value "eval_num (\<one>+\<one>+\<one>)"

fun eval_exp :: "exp \<Rightarrow> int" where
"eval_exp \<langle>num\<rangle> = eval_num num" |
"eval_exp (a\<^sub>1 :+: a\<^sub>2) = eval_exp a\<^sub>1 + (eval_exp a\<^sub>2)" |
"eval_exp (a\<^sub>1 :*: a\<^sub>2) = eval_exp a\<^sub>1 * (eval_exp a\<^sub>2)"

value "eval_exp (Plus (Num (S One)) (Num One))"

value "eval_exp (\<langle>\<one>+\<one>\<rangle> :+: \<langle>\<one>+\<one>\<rangle> :*: \<langle>\<one>+\<one>+\<one>\<rangle>)"

value "eval_exp (Mult (Num (S One)) (Num One))"

(* the following is easy because addition in integers is commutative *)
(* so after evaluation, there is not much to prove *)
lemma "eval_exp (e\<^sub>1 :+: e\<^sub>2) = eval_exp (e\<^sub>2 :+: e\<^sub>1)"
  by auto

(* but can we prove commutativity on the syntactic side? *)
(* we need to assume something, that captures that Plus is addition *)
(* in our simple situation, associativity is enough *)

inductive equal_exp :: "exp \<Rightarrow> exp \<Rightarrow> bool" (infix "\<equiv>ex" 13) where
equal_exp_refl:         "e \<equiv>ex e" |
equal_exp_symm:         "e\<^sub>1 \<equiv>ex e\<^sub>2 \<Longrightarrow> e\<^sub>2 \<equiv>ex e\<^sub>1" |
equal_exp_trans[trans]: "e\<^sub>1 \<equiv>ex e\<^sub>2 \<Longrightarrow> e\<^sub>2 \<equiv>ex e\<^sub>3 \<Longrightarrow> e\<^sub>1 \<equiv>ex e\<^sub>3" |
equal_exp_cong_plus:    "e\<^sub>1 \<equiv>ex e\<^sub>1' \<Longrightarrow> e\<^sub>2 \<equiv>ex e\<^sub>2' \<Longrightarrow> e\<^sub>1 :+: e\<^sub>2 \<equiv>ex e\<^sub>1' :+: e\<^sub>2'" |
equal_exp_plusone:      "\<langle>n+\<one>\<rangle> \<equiv>ex \<langle>n\<rangle> :+: \<langle>\<one>\<rangle>" |
equal_exp_assoc:        "(e\<^sub>1 :+: (e\<^sub>2 :+: e\<^sub>3)) \<equiv>ex ((e\<^sub>1 :+: e\<^sub>2) :+: e\<^sub>3)" 


lemma plusone: "\<langle>\<one>\<rangle> :+: \<langle>n\<rangle> \<equiv>ex \<langle>n\<rangle> :+: \<langle>\<one>\<rangle>"
(* Show 1+n=n+1 by induction on n:
   If n=1, then 1+1=1+1
   If n=Sm, then 1+n = 1+Sm = 1+(m+1) = (1+m)+1 = (m+1)+1 = Sm+1 = n+1
*)
  apply (induction n)
  
  apply (rule equal_exp_refl)

  apply(rule equal_exp_trans)
  apply(rule equal_exp_cong_plus)
  apply(rule equal_exp_refl)
   apply(rule equal_exp_plusone)

  apply(rule equal_exp_trans)
  apply(rule equal_exp_assoc)
  apply(rule equal_exp_trans)
  apply(rule equal_exp_cong_plus)
  apply simp
   apply(rule equal_exp_refl)

  apply(rule equal_exp_cong_plus)
  apply(rule equal_exp_symm)
  apply(rule equal_exp_plusone)
   apply(rule equal_exp_refl)
  done

(* We want to show that n+m=m+n, or, Plus n m = Plus m n, which again needs to be written as
   "equal_exp (Plus (Num n) (Num m)) (Plus (Num m) (Num n))" to be understood by Isabelle  *)
lemma commutativity_num: "\<langle>n\<rangle> :+: \<langle>m\<rangle> \<equiv>ex \<langle>m\<rangle> :+: \<langle>n\<rangle>"
(* Induction on m: 
   If n=1, then we need to show 1+m=m+1, which we proved in lemma plusone
   If n = Sl, then 
    n+m = Sl+m = (l+1)+m = (1+l)+m = 1+(l+m) = 1+(m+l) = (1+m)+l = (m+1)+l 
     = m+(1+l) = m+(l+1) =  m+n
*)
proof(induction n)
case One
  then show ?case by (rule plusone)
next
  case (S l)
  have "\<langle>l+\<one>\<rangle> :+: \<langle>m\<rangle> \<equiv>ex (\<langle>l\<rangle> :+: \<langle>\<one>\<rangle>) :+: \<langle>m\<rangle>"
    apply(rule equal_exp_cong_plus)
    apply(rule equal_exp_plusone)
    by(rule equal_exp_refl)
  also have      "\<dots> \<equiv>ex (\<langle>\<one>\<rangle> :+: \<langle>l\<rangle>) :+: \<langle>m\<rangle>"
    apply(rule equal_exp_cong_plus)
    apply(rule equal_exp_symm)
    apply(rule plusone)
    by(rule equal_exp_refl)
  also have      "\<dots> \<equiv>ex \<langle>\<one>\<rangle> :+: (\<langle>l\<rangle> :+: \<langle>m\<rangle>)"
    apply(rule equal_exp_symm)
    by(rule equal_exp_assoc)
  also have      "\<dots> \<equiv>ex \<langle>\<one>\<rangle> :+: (\<langle>m\<rangle> :+: \<langle>l\<rangle>)"
    apply(rule equal_exp_cong_plus)
    apply(rule equal_exp_refl)
    by(rule S)
  also have      "\<dots> \<equiv>ex (\<langle>\<one>\<rangle> :+: \<langle>m\<rangle>) :+: \<langle>l\<rangle>"
    by(rule equal_exp_assoc)
  also have      "\<dots> \<equiv>ex (\<langle>m\<rangle> :+: \<langle>\<one>\<rangle>) :+: \<langle>l\<rangle>"
    apply(rule equal_exp_cong_plus)
    apply(rule plusone)
    by(rule equal_exp_refl)
  also have      "\<dots> \<equiv>ex \<langle>m\<rangle> :+: (\<langle>\<one>\<rangle> :+: \<langle>l\<rangle>)"
    apply(rule equal_exp_symm)
    by(rule equal_exp_assoc)
  also have      "\<dots> \<equiv>ex \<langle>m\<rangle> :+: (\<langle>l\<rangle> :+: \<langle>\<one>\<rangle>)"
    apply(rule equal_exp_cong_plus)
    apply(rule equal_exp_refl)
    by(rule plusone)
  also have      "\<dots> \<equiv>ex \<langle>m\<rangle> :+: \<langle>l+\<one>\<rangle>"
    apply(rule equal_exp_cong_plus)
    apply(rule equal_exp_refl)
    apply(rule equal_exp_symm)
    by(rule equal_exp_plusone)
  finally show ?case by simp
qed


(*I've added a simple tactic called exp_tac, which simply tries 
all* the rules on a goal in this order:

1) try refl
2) try plusone
3) try symmetry and then plusone
...
6) try split on n + m and recursively try to solve n and m
7) try custom derived rule
8) try symmetry and then custom rule

*this tactic does not apply the trans rule for obvious reasons
*)


method exp_tac uses rule = 
    rule equal_exp_refl |
    rule equal_exp_plusone |
    (rule equal_exp_symm ; rule equal_exp_plusone) |
    rule equal_exp_assoc |
    (rule equal_exp_symm ; rule equal_exp_assoc) |
    (rule equal_exp_cong_plus ; (exp_tac rule:rule)+) |
    rule rule  |
    (rule equal_exp_symm ; rule rule)


lemma plusone_isar: "\<langle>\<one>\<rangle> :+: \<langle>n\<rangle> \<equiv>ex \<langle>n\<rangle> :+: \<langle>\<one>\<rangle>"
(* Show 1+n=n+1 by induction on n:
   If n=1, then 1+1=1+1
   If n=Sm, then 1+n = 1+Sm = 1+(m+1) = (1+m)+1 = (m+1)+1 = Sm+1 = n+1
*)
proof (induction n)
  case One
  then show ?case by (simp add: equal_exp_refl)
next
  case (S m)
  have "\<langle>\<one>\<rangle> :+: \<langle>m+\<one>\<rangle> \<equiv>ex \<langle>\<one>\<rangle> :+: (\<langle>m\<rangle> :+: \<langle>\<one>\<rangle>)" by exp_tac
  also have      "\<dots> \<equiv>ex (\<langle>\<one>\<rangle> :+: \<langle>m\<rangle>) :+: \<langle>\<one>\<rangle>" by exp_tac
  also have      "\<dots> \<equiv>ex (\<langle>m\<rangle> :+: \<langle>\<one>\<rangle>) :+: \<langle>\<one>\<rangle>" by(exp_tac rule:S)
  also have      "\<dots> \<equiv>ex (\<langle>m+\<one>\<rangle>) :+: \<langle>\<one>\<rangle>" by exp_tac
  finally show ?case by simp
qed

lemma commutativity_num': "\<langle>n\<rangle> :+: \<langle>m\<rangle> \<equiv>ex \<langle>m\<rangle> :+: \<langle>n\<rangle>"
(* Induction on m: 
   If n=1, then we need to show 1+m=m+1, which we proved in lemma plusone
   If n = Sl, then 
    n+m = Sl+m = (l+1)+m = (1+l)+m = 1+(l+m) = 1+(m+l) = (1+m)+l = (m+1)+l 
     = m+(1+l) = m+(l+1) =  m+n
*)
proof(induction n)
case One
  then show ?case by (rule plusone)
next
  case (S l)
  have "\<langle>l+\<one>\<rangle> :+: \<langle>m\<rangle> \<equiv>ex (\<langle>l\<rangle> :+: \<langle>\<one>\<rangle>) :+: \<langle>m\<rangle>" by exp_tac
  also have      "\<dots> \<equiv>ex (\<langle>\<one>\<rangle> :+: \<langle>l\<rangle>) :+: \<langle>m\<rangle>" by(exp_tac rule:plusone)
  also have      "\<dots> \<equiv>ex \<langle>\<one>\<rangle> :+: (\<langle>l\<rangle> :+: \<langle>m\<rangle>)" by exp_tac
  also have      "\<dots> \<equiv>ex \<langle>\<one>\<rangle> :+: (\<langle>m\<rangle> :+: \<langle>l\<rangle>)" by(exp_tac rule:S)
  also have      "\<dots> \<equiv>ex (\<langle>\<one>\<rangle> :+: \<langle>m\<rangle>) :+: \<langle>l\<rangle>" by exp_tac
  also have      "\<dots> \<equiv>ex (\<langle>m\<rangle> :+: \<langle>\<one>\<rangle>) :+: \<langle>l\<rangle>" by(exp_tac rule:plusone)
  also have      "\<dots> \<equiv>ex \<langle>m\<rangle> :+: (\<langle>\<one>\<rangle> :+: \<langle>l\<rangle>)" by exp_tac
  also have      "\<dots> \<equiv>ex \<langle>m\<rangle> :+: (\<langle>l\<rangle> :+: \<langle>\<one>\<rangle>)" by(exp_tac rule:plusone)
  also have      "\<dots> \<equiv>ex \<langle>m\<rangle> :+: \<langle>l+\<one>\<rangle>" by exp_tac
  finally show ?case by simp
qed

end

