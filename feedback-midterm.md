
# Feedback for Midterm

Here are some tips for future examinations. Come to my office hours for more details.

### Learn the definitions

I gave you the correct definitions in my notes. What is wrong with the following "definitions"?

"Confluence is where two elements can be joinable ..." [^confluence-is-where] 
[^confluence-is-where]: "can be" should be "must be". There is also missing an explanation of which two elements must be joinable. Moreover, "is where" is not a good way to introduce a definition. "is where" is similar to "has to do with" or "can be used when", see below.

"Confluence has to do with ..." [^has-to-do-with]

[^has-to-do-with]: If it starts with "has to do with" then it is not a definition.

"A measure function can be used when ..." [^can-be-used-when]

[^can-be-used-when]: If it starts with "can be used when" then it is not a definition.

"A measure function is used to prove that an ARS terminates" [^A-measure-function]
[^A-measure-function]: This is a correct statement, but not a definition.

"A measure function is a function that measures the time it takes for an element of an ARS to reach a normal form." [^the-time-it-takes]
[^the-time-it-takes]: The smaller problem is that this is not quite precise enough without saying what is meant by "time". (It is the smaller problem because it can be rectified with reasonable effort.) The bigger problem is that there are many different ways to define measure functions, and they do not have to be related to time at all. Go back to the examples in the lecture notes if in doubt.

"An ARS that has unique normal forms an is terminating is confluent. [^is-confluent]
[^is-confluent]: This states a property of confluence, but is not its definition.

### Learn to state the definitions correctly

Make sure that you state the definitions correctly. I sometimes gave full marks for a definition that is almost correct, but do **not** expect me to do this in the final. Just learn to state definitions correctly. 

### Learn to use the defined notions correctly

What is wrong with the following?

"The ARS is not confluent, because it does not terminate." [^not-confluet-if-not-terminates]
[^not-confluet-if-not-terminates]: The ARS with one element that reduces to itself is confluent but not terminating.

"The ARS is not confluent, because not all elements reduce to the same form." [^reduce-to-the-form]
[^reduce-to-the-form]: In the ARS with two elements `a` and `b` and no rules, not all elements reduce to the same form, but the ARS is confluent nevertheless.

### Avoid statements that do not typecheck

What is wrong with the following statements?

"An equivalence class is confluent/reflexive/transitive" [^An-equivalence-class]

[^An-equivalence-class]: Confluence etc are properties of a relation, not of a class.

"A measure function is a function that defines how an ARS is reduced." [^how-an-ARS-is-reduced]

[^how-an-ARS-is-reduced]: We reduce elements of an ARS, not ARSs themselves. 

### Avoid imprecise terminology

Can you improve the following sentences?

"The equivalence classes with unique normal forms are the ones ending with only b, a or empty word" [^ending-with]
[^ending-with]: It is not clear what it means for an equivalence class to end. Better is "The equivalence classes with unique normal forms are the ones containing b, a or empty word, respectively"

"There are less ab's and ba' than the last step" [^last-step]
[^last-step]: I am not quite sure, but I guessed that it meant "Each step reduces the number of ab's and ba's." By the way, the latter is still ambiguous, because it is not clear whether it means that both the number of ab's and the number of ba's is reduced, or only one of them, or either of them or both. 

"The ARS does not terminate because we have equivalence relations of `ab->ba` and `ba->ab`. [^equivalence-relations-of]
[^equivalence-relations-of]: The problem here is with "equivalence relations of": We have only one equivalence relation. Better is "The ARS does not terminate because we have rules `ab->ba` and `ba->ab`."

"Contain an even number of a's and b's" [^even-number]
[^even-number]: Better are "Contain an even number of letters" or "Contain an even number of a's and an even number of b's" depending on which of the two carry the intended meaning.

"The ARS contains unique normal forms" [^contains-unique-normal-forms]
[^contains-unique-normal-forms]: When I read "contains unique normal forms" I understand that the ARS contains some element that has a unique normal form. But that is very different from saying "The ARS has unique normal forms" which means that all elements of the ARS have a unique normal form.




