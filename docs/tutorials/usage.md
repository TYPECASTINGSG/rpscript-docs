1. [Key Feature](#feature)
2. [Syntax](#syntax)
3. [Actions](#actions)
4. [Expression](#expression)
5. [Variable](#variable)
6. [Literal](#literal)
7. [Lamda](#lamda)
8. [Environment Variable](#envvar)
9. [Module](#module)



## <a name="feature"></a>Key Feature
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
* Module consists of a group of related keywords. Module installation adds those keywords into the system.  
To view the list of keywords of a module, run the command.
<pre class="prettyprint nocode"><code>
rps module &#x3C;moduleName&#x3E;
</code></pre>

## <a name="syntax"></a>Syntax
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
**Option** | notify `--sound=true` "title" "message"  | Optional attribute of the action.
**Lamda** | assign 'printout' `($val)=> log val` | Lamda declaration.
**Literal** | log `"hello"` | 
**Variable** | for-each `$print $list` | Variable is assignable using the `as` or `assign` keyword.
**EnvVar** | log `$$0` | Variable passed from the command line.


## <a name="actions"></a>Actions

Action is similar to function in functional programming.

Every action comes with a mandatory ```keyword``` (operator) , ```parameter``` (operand) and  ```option``` (optional attributes).

Example:
<pre class="prettyprint lang-rps"><code>log "Print to console"

csv-to-data --columns=true "name,title,descript\n'nameA','titleB','descC'"
</code></pre>

In line 1, `log` is the keyword. There is no option for `log`, and it has a parameter `"Print to console"`.

In line 3, `csv-to-data` is the keyword. It has 1 option `columns`, and a `String` parameter.

**Currying**  
If the required number of parameters are not met, the action will return a new function with the remaining parameters as the arguments.

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

When you visit the `log` [API documentation](http://www.rpscript.com/Basic.html#.log).
The signature of the action is explained in the form:
```
log :: a → a
```
The log keyword takes any type `a` as input, and output the same type.

The signature style follows Ramda Type Signature. For further explanation, please check out [Ramda Type Signature](https://github.com/ramda/ramda/wiki/Type-Signatures). 


**Keywords/Parameters**

A keyword is the prefix/operator of an action.

Keywords are managed by modules. When you run `rps install beeper`, keywords related to the module `beeper` are added to your system.

The [API documentation](http://www.rpscript.com/Beeper.html#.beep) for beeper explains the usage of the keyword with the signature below.
```
beep :: String|Number → void
```
The signature says that the keyword beep takes a string or number as an argument, and return nothing. The usage below are valid.

<pre class="prettyprint lang-rps"><code>beep 3
beep "**-**"
</code></pre>

Let's take [figlet](http://www.rpscript.com/Figlet.html#.figlet) as the second example with 2 parameters.
```
figlet :: String → String → String
```
The signature says that the `figlet` keyword takes a `String`, convert it to a function that takes another `String`, and return the result as a `String`.

These usages are all valid.
<pre class="prettyprint lang-rps"><code>figlet "Ghost" "Spooky"

;passing 1 parameter will result in a function that takes the second input
figlet "Ghost" | as "figletGhost"
call $figletGhost "Spooky"
</code></pre>

**Options**

Option is the optional attributes of an action. It is not curried and has a different syntax from parameter.

```
<option> :: "--" <optionName> "=" <optionValue>
```

It is specified after keyword and before parameter with the structure `--<optionName>=<optionValue>`.
<pre class="prettyprint lang-rps"><code>csv-to-data --columns=true "name,title,descript\n'nameA','titleB','descC'"
</code></pre>

`csv-to-data` is a keyword from the csv module. It is a wrapper for the node.js module [CSV](http://csv.adaltas.com/).

The keyword [csv-to-data](http://www.rpscript.com/CSV.html#.csv-to-data) takes a csv string content and converts it to a manipulable data structure. 

From the example above, `columns` is an optional attribute that assumes the first line to be the header by setting it to true.

If this option is excluded, it will default to null according to [CSV Documentation](http://csv.adaltas.com/parse/).

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


## <a name="expression"></a>Expression

An expression consists of a single action and an optional piped action.

Example, assignment can be written as:

<pre class="prettyprint lang-rps"><code>identity 10 | as 'val'</code></pre>

This is equivalent to:

<pre class="prettyprint lang-rps"><code>as 'val' identity 10</code></pre>

By placing the assignment on the right and keeping the executing process on the left, the `identity` action is brought into focus reading from left to right.

Expression ends with a newline.


## <a name="lamda"></a>Lamda

Lamda is similar to anonymous function is functional programming. The syntax is almost similar to javascript [Arrow Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions) except that all variable must have `$` sign and no curly bracket is allowed.


<pre class="prettyprint lang-rps"><code>for-each ($val)=>(log $val) [1,2,3,4,5]</code></pre>

## <a name="literal"></a>Literal

Currently supported literal are Number, Boolean, String, Template String, Object, and Array. The syntax follows javascript convention.

```
assign "array" [1,2,3]
assign "object" {a:1,b:2,c:3}
assign "str" "Hello world"
assign "num" 123
assign "template" `Hello world`
assign "truth" true
```

## <a name="variable"></a>Variable

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

The choice of which keywords and style to use is a matter of preference.

To access the variable, prefix a `$` sign.
```
log $var1
```

## <a name="envvar"></a>EnvVar

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


## <a name="module"></a>Module

A module is made up of a group of related keywords. When you install a module, you are adding those keywords to your system.

To view the list of installed modules.
```
rps modules
```

To view all installed keywords in your system.
```
rps actions
```

To view the keywords for a specific module.
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