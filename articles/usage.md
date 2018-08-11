Simple language to automate your tasks.

To create a language simple enough even for non-developer to be able to write and maintain their repetitive task. 

RPScript is strongly influent by functional programming style of coding. Higher-order function and currying is heavily used. 

Actions is nothing more than function, able to compose them to perform data transformation and manipulation.

RPScript has a different take on module management. There is no import statement required. Modules are loaded dynamically and are managed using command line.



Some key principles:

* Intuitive and simple syntax. Every expression should focus on a process or activity. 

* Everything is an action. Action represents a user activity. It is represented with prefix keyword, follow by optional arguments and/or parameters.
```
action :: <keyword> <--opt=literal> <...params>
```

* Leave the concept of libraries out of the syntax. Use on command line to to perform module management. No more ```import * from 'csv'``` , ```new CSV(params)```.
````
rps install csv
````
* Modules consists of a list of keywords. When you install a module, you are simply adding more keywords into the framework.

````
<keyword> <...parameters>
````
## Syntax
```
<expression> ::=  <action> ("|" <action>)? NL
<action>     ::=  <keyword> opt* param* | "(" <keyword> opt* param* ")" 

<param>      ::=  <literal> | <lamda> | <variable> | <action>
<opt>        ::=  "--" <optName> ("=" <literal> )?
<lamda>      ::=  "(" variable* ")" "=>" action
<literal>    ::=  String | Number | Object | Array | Boolean | Symbol
<variable>   ::= [$][a-zA-Z0-9]+ | <envvar>
<envvar>     ::= [$$][a-zA-Z0-9]+

<Symbol>     ::= [A-Z][a-zA-Z0-9.]*
<keyword>    ::=  [a-z][a-zA-Z0-9-]* 
<optName>    ::= [a-z][a-zA-Z0-9-]*
```

Feature | Example | Detail
--- | --- | ---
**Action** | `log "hello"` | Execute a process. Similar to function execution is other language.
**Keyword** | `log` "hello" | The operation to be performed. 
**Param** | log `"hello"` | parameter that is passed to the action.
**Option** | notify "title" "message" `--sound=true`  | additional options declare when executing an action.
**Lamda** | assign 'printout' `($val)=> log val` | shorthand function declaration.
**Literal** | log `"hello"` | Similar to other languages.
**Variable** | for-each `$printout $list` | Similar to other languages.
**EnvVar** | log `$$1` | Param to be passed before execution.


### Expression

Expression consists of a single action an additional piped action.
Expression is evaluated with newline.

### Action

Action is equivalent to the typical function in functional programming. Similar to homoiconic language such as lisp, keyword is equivalent to to operator whereas options and params are the operands.

One distinct difference is the options. Think of it as the optional values for the particular operation. It is not mandatory to have an option field, but if you need advanced customization, you can add the additional field and it will override the default value.

Whereas param is similar to the traditional arguments of most programming languages.

One distinction between options and param is that options is not curried, whereas most param is curried.

action is evaluate from left to right. Take a simple expression.
```
log "hello"
```
The parser will take the first word as the keyword, subsequent values as either options or param.

Let's take the second example.
```
log figlet "hello"
```
This is equivalent to
```
log (figlet "hello")
```
The parser will always asssume that what comes after the keywords will be param.
In this case, the expression will be to `log` the output of `figlet` with the input of `"hello"`

Let's say if you want to iterate a list of item and print out. You will realise the expression below `DOES NOT` do what you expected.
```
;INCORRECT
for-each log [1,2,3]
```

That is because the evaluated result is `for-each (log [1,2,3])`. Since for-each requires 2 params, it will return a function that expects an additional input.

The right way is to explicitly indicate the scope of the `log` operation.
```
;CORRECT
for-each (log) [1,2,3]
```

This actually says that the `log` action does not include `[1,2,3]`. And it is treated as a function that takes an input of any type. [http://doc.rpscript.com/log].



### Keywords

This is equivalent to the operator of homoiconic languages. Keywords are managed by modules. When you perform a `rps install <xxx>`, you are installing a set of keywords to be used. For a list of available modules and keywords, check out the (documentation)[http://doc.rpscript.com].

### Lamda

This is similar to traditional lamda function. The syntax follows the javascript convention, except that parameters must have the '$' sign.
```
for-each ($val)=> (log $val) [1,2,3,4,5]
```

### Literal

Currently supported literal are Number, String, Template String, Object and Array. The syntax follows javascript convention.

### Variable

There are 2 ways to assign a variable.
```
assign 'var1' 'hello'
```
or 
```
log 'hello' | as 'var1'
```

The 'assign' and 'as' keywords do the same thing, It takes the first value as the variable name, second as the variable value.

To access the variable.
```
log $var1
```


## Module

Module is made up of keywords.
When you install a module, you are basically adding more keywords to your dictionary.

A full list of keys can be display with this command.
```
rps actions
```

You can also view the keywords related to a specific module.
```
rps module csv
```

To add a module.
```
rps install csv
```
For the list of modules, please refer to API Documentation.

To remove.
```
rps remove csv
```