1. [Key Feature](#Feature)
2. [Syntax](#Syntax)
3. [Actions](#Actions)
4. [Module](#Module)
5. [Expression](#Expression)
6. [Variable](#Variable)
7. [Literal](#Literal)
8. [Lamda](#Lamda)
9. [Environment Variable](#EnvVar)



## Feature
Key features:

* Action represents a user activity/process. It has a prefixed keyword, followed by options and parameters.
```
log "hello world"
```

* No module related statement. Rely on the command line to perform module management. There is no statement such as ```import * from 'csv'``` , ```new CSV(params)```.
Install a module with this command:
````
rps install csv
````
* Module consists of a group of related keywords. Module installation adds those keywords into the framework.  
To view the list of keywords of a module, run the command.
<pre class="prettyprint nocode"><code>
rps module &#x3C;moduleName&#x3E;
</code></pre>

## Syntax
```
<expression> ::=  <action> ("|" <action>)? NL

<action>     ::=  <keyword> opt* param* | "(" <keyword> opt* param* ")" 
<param>      ::=  <literal> | <lamda> | <variable> | <action>
<opt>        ::=  "--" <optName> ("=" <optValue> )?

<keyword>    ::=  [a-z][a-zA-Z0-9-]* 
<optName>    ::=  [a-z][a-zA-Z0-9-]*
<optValue>   ::=  <literal> | <variable>
<variable>   ::=  [$][a-zA-Z0-9]+ | <envvar>
<envvar>     ::=  [$$][0-9]+
<lamda>      ::=  "(" variable* ")" "=>" action
<literal>    ::=  String | Number | Object | Array | Boolean | Symbol
<symbol>     ::=  [A-Z][a-zA-Z0-9.]*
```


Feature | Example | Detail
--- | --- | ---
**Action** | `log "hello"` | User action.
**Keyword** | `log` "hello" | Operator of the action.
**Param** | log `"hello"` | Operand of the action.
**Option** | notify `--sound=true` "title" "message"  | optional field of the action.
**Lamda** | assign 'printout' `($val)=> log val` | shorthand function declaration.
**Literal** | log `"hello"` | 
**Variable** | for-each `$print $list` | variable is assignable using the `as` or `assign` keyword.
**EnvVar** | log `$$0` | variable passed from the command line.


## Actions

Action is similar to function in functional programming.

Every action comes with a mandatory ```keyword``` (operator) , ```parameter``` (operand) and  ```option``` (optional attributes).

Example
<pre class="prettyprint lang-rps"><code>log "Print to console"

csv-to-data --columns=true "name,title,descript\n'nameA','titleB','descC'"
</code></pre>

**Currying**  
If the required number of parameters are not met, action will return a new function with the remaining parameters as the arguments.

Take the example:
<pre class="prettyprint lang-rps">
<code>;function is assigned to logging since log requires an input
assign 'logging' log
call $logging "Print"

; the same result as above
log "Print" | as 'result'

log type $logging  ;output: Function
log type $result   ;output: String
</code></pre>

Line 2 assigns the variable `logging` to the result of the action `log` with no parameter. Since `log` requires an input to display on the console, instead of evaluation, it returns a function that takes a single argument.

Line 3 applies the `$logging` function with the string `Print`.


The required parameters and options are documented in [API documentation](http://www.rpscript.com/Basic.html#.log).

The signature of the action is explained in the form:
```
log :: a → a
```
The log keyword takes any type `a` as input, and output the same type.

The signature style follows Ramda Type Signature. For further explanation, please check out [Ramda Type Signature](https://github.com/ramda/ramda/wiki/Type-Signatures). 


**Keywords**

A keyword is the prefix/operator of an action.

Keywords are managed by modules. When you run `rps install csv`, keywords related to the module `csv` are added to the framework.

For a list of available modules and keywords, check out the [documentation](http://www.rpscript.com).

**Parameters**

Parameters are the required arguments for a particular action.

Check out the [documentation](http://www.rpscript.com) for the keywords provided by different modules.

**Options**

Option is the optional attributes of an action. It is not curried and has a different syntax from parameter.

```
<option> :: "--" <optionName> "=" <optionValue>
```

It is specified after keyword and before parameter with the structure `--<optionName>=<optionValue>`.
```
csv-to-data --columns=true "<data>"
```

`csv-to-data` is a keyword from the csv module. It is a wrapper for the node.js module [CSV](http://csv.adaltas.com/).

The keyword [csv-to-data](http://www.rpscript.com/CSV.html#.csv-to-data) takes a csv string content and converts it to a manipulable data structure. 

From the example above, `columns` is an optional field that assumes the first line to be the header by setting it to true.

If this option is excluded, it will default to null. as per [CSV Documentation](http://csv.adaltas.com/parse/).

**Evaluation**  

Take the expression.
```
log "hello"
```
The expression is interpreted as a keyword, followed by a single parameter.

This is similar to javascript
```
console.log("hello");
```

Actions are evaluated right-to-left eagerly.  

Take the example below:
```
log figlet "Ghost" "hello"
```
This is equivalent to
```
log (figlet "Ghost" "hello")
```
The expression will evaluate the action `figlet` first, then pass the output to `log`.

Let's assume a scenario where you want to add 2 to a list of number, and print the result. 
<pre class="prettyprint lang-rps"><code>;incorrect output
log map add 2 [1,2,3]
</code></pre>

The line above is incorrect. Instead, it prints a function as result. Why is that?

<pre class="prettyprint lang-rps"><code>log (map (add 2 [1,2,3] ) )
</code></pre>

`add 2 [1,2,3]` → `map` → `log`

The expression performs eager evaluation on `add 2 [1,2,3]` and pass the result to `map`.
Since there is only one parameter for `map`, `map` still needs another parameter before it can evaluate. Thus, it returns a function that takes the remaining argument.

The output will should this instead.  
`function n(r){return 0===arguments.length||e(r)?n:t.apply(this,arguments)}`

To fix this problem, the `add` action has to be explicitly scoped with parentheses
<pre class="prettyprint lang-rps"><code>log map (add 2) [1,2,3]
;output : 3,4,5
</code></pre>

Which will then be evaluated to:
<pre class="prettyprint lang-rps"><code>log ( map (add 2) [1,2,3] )
</code></pre>

In this scenario, `add 2` is evaluated to return a function that takes the second argument. 

`map` is now provided with two arguments. The return function of `add 2` as the first, and the array `[1,2,3]` as the second.

Now the `map` action has both required parameters for evaluation.


## Expression

An expression consists of a single action and an optional piped action.

Example, assignment can be written as:

<pre class="prettyprint lang-rps"><code>identity 10 | as 'val'</code></pre>

This is equivalent to:

<pre class="prettyprint lang-rps"><code>as 'val' identity 10</code></pre>

By placing the assignment on the right and keeping the executing process on the left, the `identity` action is brought into focus reading from left to right.

Expression ends with a newline.


## Lamda

Lamda is similar to anonymous function is functional programming. The syntax is almost similar to javascript [Arrow Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions) except that all variable must have `$` sign and no curly bracket is allowed.


<pre class="prettyprint lang-rps"><code>for-each ($val)=>(log $val) [1,2,3,4,5]</code></pre>

## Literal

Currently supported literal are Number, Boolean, String, Template String, Object, and Array. The syntax follows javascript convention.

```
assign "array" [1,2,3]
assign "object" {a:1,b:2,c:3}
assign "str" "Hello world"
assign "num" 123
assign "template" `Hello world`
assign "truth" true
```

## Variable

Under the basic module, there are 2 keywords can be used for variable assignment.
```
assign 'var1' 'hello'
```
or 
<pre class="prettyprint lang-rps"><code>
log 'hello' | as 'var1'
;same as
as 'var1' log 'hello'
</code></pre>

The 'assign' and 'as' keywords do the same thing, it takes the first value as the variable name, second as the variable value.

The choice of which keywords and what style to use is just a matter of preference.

To access the variable, prefix a `$` sign.
```
log $var1
```

## EnvVar

Arguments can be passed from the command line before execution.

The argument is represented with a `$$` followed by digit starting from `0`.

To pass the argument from the command line.
```
rps script.rps "variable1" "variable2"
```
Given the example, script.rps will interpret `$$0` as `variable1`, and `$$1` as `variable2`.

The expressions below will print "variable1" and "variable2"
```
log $$0
log $$1
```


## Module

A module is made up of a group of related keywords.
When you install a module, you are adding those keywords to your application.

To view the list of installed modules.
```
rps modules
```

A full list of installed keywords will be shown with this command.
```
rps actions
```

You can also view the keywords related to a specific module.
```
rps module csv
```

To add a module.
```
rps install csv        ;latest version
rps install csv@0.1.2  ;specific version
```

To remove a module.
```
rps remove csv
```

For the list of modules, please refer to the [API Documentation](http://www.rpscript.com/).