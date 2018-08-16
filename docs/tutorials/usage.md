1. [Principle](#Principle)
2. [Actions](#Actions)
3. [Syntax](#Syntax)
    * [Expression](#Expression)
    * [Keyword](#Keyword)
    * [Variable](#Variable)
    * [Literal](#Literal)
    * [Lamda](#Lamda)
    * [Environment Variable](#EnvVar)
4. [Module](#Module)



RPScript is strongly influent by functional programming. Higher-order function and currying is heavily used. 

Actions represent function in typical functional programming context. Similar to functions, actions can be composed to perform data transformation and manipulation.

RPScript has a different take on module management. There is no import statement required. Modules are loaded dynamically. The installation and removal is handled using command line. There is no import statement required.

## Principle
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

## Actions

Action is the heart of RPScript. Action is heavily influenced by the traditional function in functional programming.

Every action comes with a mandatory ```keyword``` (operator) , ```parameter``` (operand) and optional ```option```.

```
action :: <keyword> <--option=literal> <...param>
```

Example
<pre class="prettyprint lang-rps"><code>log "Print to console"

csv-to-data --columns=true "name,title,descript\n'nameA','titleB','descC'"
</code></pre>

**Currying**  
Actions are curried. 
<pre class="prettyprint lang-rps">
<code>assign 'logging' log
call $logging "Print to console"

;same as above
log "Print to console" | as 'result'

log type $logging  ;output: Function
log type $result   ;output: String
</code></pre>

Line 1 assigns `log` with zero parameter. Thus it returns a function that takes one parameter and perform the log operation.

The assigned variable $logging is a function.

Line 7 will show an output of the type Function.  
Line 8 will be the type String.

This is explained in the [API documentation](http://docs.rpscript.com/Basic.html#.log) with the signature.
```
log :: a → a
```
The log keyword takes any type `a` as input, and output the same type.

The signature style follows [Ramda Type Signature](https://github.com/ramda/ramda/wiki/Type-Signatures). 

**Params**

The interpretation of parameters depends on the keywords. Check out the [documentation](http://docs.rpscript.com) for the keywords provided by different modules.

**Options**

Option provides entry of arguments that are optional. The intention is to reduce the size of the parameter list by classifying optional fields in different category.

Option has the syntax.
```
option :: "--" <optionName> "=" <optionValue>
```

And it is included right after the keyword
```
csv-to-data --columns=true "<data>"
```
The example above is a keyword from the csv module. It is a wrapper for the node.js module [CSV](http://csv.adaltas.com/).

The keyword [csv-to-data](http://docs.rpscript.com/CSV.html#.csv-to-data) takes a csv string content and convert it to a manipulable data structure. 

From the example above, `columns` is an optional field that asssume the first line is the header if set to true.

If this option is excluded, it will default to null. as per [CSV Documentation](http://csv.adaltas.com/parse/).

**Evaluation**  
Take the expression.
```
log "hello"
```
The parser will take the first word as the keyword, subsequent values as either options or params.

Actions are evaluated right-to-left eagerly.
```
log figlet "Ghost" "hello"
```
This is equivalent to
```
log (figlet "Ghost" "hello")
```
The expression will evaluate the action `figlet`, then pass the output to `log`.


Let's say if you want to add 2 to a list of items and print the result. You will realise the expression below `DOES NOT` do what is expected.

<pre class="prettyprint lang-rps"><code>;incorrect output
log map add 2 [1,2,3]
</code></pre>

Evaluated to:
<pre class="prettyprint lang-rps"><code>log (map (add 2 [1,2,3] ) )
</code></pre>

This expression will evaluate `add 2 [1,2,3]` and pass the result to `map`.
Since there is only one param , `map` will be curried to return a function that requires another argument.

Thus, you will be seeing this as output instead.  
`function n(r){return 0===arguments.length||e(r)?n:t.apply(this,arguments)}`

This can be fixed by explicitly scoping the `add` action with parentheses
<pre class="prettyprint lang-rps"><code>log map (add 2) [1,2,3]
;output : 3,4,5
</code></pre>

Which will be evaluated to:
<pre class="prettyprint lang-rps"><code>log ( map (add 2) [1,2,3] )
</code></pre>

`add` will be evaluated to a function that takes another argument. It will be passed to `map` as the first param, and the array `[1,2,3]` is the second param. The output will be a mapped array that will be the input for `log`.



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
**Action** | `log "hello"` | User action.
**Keyword** | `log` "hello" | Operator of the action.
**Param** | log `"hello"` | Operand of the action.
**Option** | notify `--sound=true` "title" "message"  | options declare of the action.
**Lamda** | assign 'printout' `($val)=> log val` | shorthand function declaration.
**Literal** | log `"hello"` | 
**Variable** | for-each `$printout $list` | variable is assignable using the `as` or `assign` keyword.
**EnvVar** | log `$$0` | environment paramter passed before execution.


## Expression

Expression consists of a single action and an optional piped action.

piped action is just syntactic sugar that makes the expression more readable.

Example, assignment can be written as:

<pre class="prettyprint lang-rps"><code>identity 10 | as 'val'</code></pre>

This is equivalent to:

<pre class="prettyprint lang-rps"><code>as 'val' identity 10</code></pre>


Expression ends with a newline.

## Keywords

Keyword is the prefix of an action. It is equivalent to the operator of homoiconic languages. Keywords are managed by modules. When you perform a `rps install <xxx>`, you are installing a set of keywords to be used. For a list of available modules and keywords, check out the [documentation](http://docs.rpscript.com).

## Lamda

This is similar lamda function in functional programming. The syntax follows the javascript convention, except that must have the `$` sign.
<pre class="prettyprint lang-rps"><code>for-each ($val)=> (log $val) [1,2,3,4,5]</code></pre>

## Literal

Currently supported literal are Number, String, Template String, Object and Array. The syntax follows javascript convention.

```
assign "array" [1,2,3]
assign "object" {a:1,b:2,c:3}
assign "str" "Hello world"
assign "num" 123
assign "template" `Hello world`
```

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

## EnvVar

Environment variable can be passed as part of the command line. The environment variable can be represented with a `$$` follow by the digit from left to right sequence starting with `0`.

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