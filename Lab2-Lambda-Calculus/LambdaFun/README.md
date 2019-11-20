```
  $$$$\        $$$$$$$$\                     
    $$ \       $$  _____|                    
     $$ \      $$ |    $$\   $$\ $$$$$$$\  
     $$$ \     $$$$$\  $$ |  $$ |$$  __$$\ 
    $$ $$ \    $$  __| $$ |  $$ |$$ |  $$ |
   $$ / $$ \   $$ |    $$ |  $$ |$$ |  $$ |
 $$$ /   $$$\  $$ |    \$$$$$$  |$$ |  $$ |
 \___|   \___| \__|     \______/ \__|  \__|
```

To compile run `stack build` and to launch the REPL, run `stack exec lamfun`. For help, type `:help` in the REPL...

The full grammar of λFun is given below:

```
<statement> ::= <expr> ";;" | <defn> ";;"
<defn>      ::= "val" <id> "=" <expr> | "rec" <id> " " <ids> "=" <expr>
<expr>      ::= <id> | 
                <number> | 
                "true" | 
                "false" | 
                "\" <ids> "." <expr> | 
                <expr> " " <expr> | 
                <expr> <op> <expr> | 
                "[" <list> "]" | 
                <expr> ":" <expr> |
                "let " <defn> " in " <expr> | 
                "case " <expr> " of " "{" <case> "}" |
                "while " <expr> " do " <expr> | 
                <expr> ";" <expr> |
                <expr> ":=" <expr> | 
                "!" <expr> | 
                "addr" <expr>
<list>      ::= "" | <expr> "," <list>
<expr_opt>  ::= "_" | <expr>
<case>      ::= <expr_opt> "->" <expr> | <expr_opt> "->" <expr> "," <case>
<id>        ::= <letter> | <id> <letter> | <id> <digit>
<ids>       ::= <id> | <id> " " <ids>
<op>        ::=  "*" | "+" | "-" | "/" | ">" | ">=" | "==" | "!=" | "=<" | "<"
<number>    ::= <digit>+
```

Remark: `while a do b ; c` is parsed as `(while a do b) ; c`, not as `while a do (b ; c)`

## Lab2

**Lab on Tuesday:** Implement easy arithmetic: `plusone`, `add`

**Homework before Thursday:** Implement the programs of Assignment1 in LambdaFun using the built-in lists. See `test/examples.lc` for examples.

**Lab on Thursday:** Implement the programs of Assignment1 in LambdaFun by adding them to `test/linked-list.lc`

**Memory:** See  the discussion on the [Memory Model](https://hackmd.io/@alexhkurz/HkEBbgGnS). 