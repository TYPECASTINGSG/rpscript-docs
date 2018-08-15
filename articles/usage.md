RPScript is strongly influent by functional programming. Higher-order function and currying is heavily used. 

Actions represent function in typical functional programming context. Similar to functions, actions can be composed to perform data transformation and manipulation.

RPScript has a different take on module management. There is no import statement required. Modules are loaded dynamically. The installation and removal is handled using command line. There is no import statement required.


Some key principles:

* Everything is an action. Action represents a user activity. It is represented with prefix keyword, follow by optional arguments and/or parameters.
```
action :: <keyword> <--opt=literal> <...params>
```

* Leave the concept of libraries out of the syntax. Rely on command line to perform module management. No more ```import * from 'csv'``` , ```new CSV(params)```.
````
rps install csv
````
* Module represents a list of keywords. When you install a module, you are simply adding more keywords into the framework. To view the list of keywords, enter the command.
```
rps module <moduleName>
```

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
**Action** | `log "hello"` | Execute a process. Similar to function execution in other language.
**Keyword** | `log` "hello" | The operation to be performed. 
**Param** | log `"hello"` | parameter that is passed to the action.
**Option** | notify `--sound=true` "title" "message"  | additional options declare when executing an action.
**Lamda** | assign 'printout' `($val)=> log val` | shorthand function declaration.
**Literal** | log `"hello"` | Similar to other languages.
**Variable** | for-each `$printout $list` | variable is assigned using the `as` or `assign` keyword.
**EnvVar** | log `$$0` | Param to be passed before execution.


## Expression

Expression consists of a single action and an optional piped action.

piped action is just syntactic sugar that makes the expression more readable.

Example, assignment can be written as:
```
identity 10 | as 'val'
```
This is equivalent to:
```
as 'val' identity 10
```

Expression ends with a newline.

## Action

Action is equivalent to the function in functional programming. Similar to homoiconic language such as lisp, keyword is equivalent to to operator whereas options and params are the operands.

One distinct difference is the options. Think of it as the optional fields for the particular operation. 

It is not mandatory to have an option field, but if you need advanced customization, you can add the additional field and it will override the default value.

Whereas param is similar to the traditional arguments of most programming languages.

Another distinction between options and param is that options is not curried, whereas most param is typically curried.

action is evaluate from left to right. Take a simple expression.
```
log "hello"
```
The parser will take the first word as the keyword, subsequent values as either options or param.

Take another example.
```
log figlet "Ghost" "hello"
```
This is equivalent to
```
log (figlet "Ghost" "hello")
```
The parser will always asssume that what comes after the keywords will be param.
In this case, the expression will be to `log` the output of `figlet` with the input of `"Ghost" and "hello"`

Let's say if you want to add 2 to a list of items and print out. You will realise the expression below `DOES NOT` do what is expected.

<pre class="prettyprint lang-rps"><code>
map add 2 [1,2,3] | as 'val'
log $val
;incorrect output
</code></pre>

That is because the expression is evaluated as `map (add 2 [1,2,3])`. Since map requires 2 params, it will return a function that expects another input (curried).

The right way is to explicitly indicate the scope of the `log` operator.
<pre class="prettyprint lang-rps"><code>
;CORRECT
map (add 2) [1,2,3] | as $val
log $val
;output : 3,4,5
</code></pre>

This actually says that the `log` action is a seperate action and it does not include `[1,2,3]`. [log documentation](http://docs.rpscript.com/Basic.html#.log).



## Keywords

Keyword is the prefix of an action. It is equivalent to the operator of homoiconic languages. Keywords are managed by modules. When you perform a `rps install <xxx>`, you are installing a set of keywords to be used. For a list of available modules and keywords, check out the [documentation](http://docs.rpscript.com).

## Lamda

This is similar lamda function in functional programming. The syntax follows the javascript convention, except that must have the `$` sign.
```
for-each ($val)=> (log $val) [1,2,3,4,5]
```

## Literal

Currently supported literal are Number, String, Template String, Object and Array. The syntax follows javascript convention.

## Variable

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

All variable must have a prefixed `$` sign.

## Environment Variable

Environment variable can be passed as part of the command line. The environment variable can be represented with a `$$` follow by the digit from left to right sequence starting from `0`.

```
rps script.rps "variable1" "variable2"
```
Given the example, scrip.rps will interpret `$$0` as `variable1`, and `$$1` as `variable2`.

You can test out with the expression below.
```
log $$0
log $$1
```


## Module

Module is made up of keywords.
When you install a module, you are basically adding more keywords to your dictionary.

To view the list of installed modules.
```
rps modules
```

A full list of installed keys can be displayed with this command.
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
For the list of modules, please refer to [API Documentation](http://docs.rpscript.com/).

To remove a module.
```
rps remove csv
```