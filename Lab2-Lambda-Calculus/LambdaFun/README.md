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
                "&" <expr>
<list>      ::= "" | <expr> "," <list>
<expr_opt>  ::= "_" | <expr>
<case>      ::= <expr_opt> "->" <expr> | <expr_opt> "->" <expr> "," <case>
<id>        ::= <letter> | <id> <letter> | <id> <digit>
<ids>       ::= <id> | <id> " " <ids>
<op>        ::=  "*" | "+" | "-" | "/" | ">" | ">=" | "==" | "!=" | "=<" | "<"
<number>    ::= <digit>+
```
