# Design

RPscript goal is simple.

To create a language simple enough even for non-developer to be able to use it for their day to day task.

Thus, it is no surprise that higher-order function and currying is the centre of this language. Actions is nothing more than function, able to compose them to perform data transformation and manipulation.

One important feature is the modular approach undertake. traditionally, library and modules are imported in the source file itself. Whereas to achieve compactness and to minimise the boilerplate on the source file, modules are handled externally. 


Some key principles:

* syntax that is intuitive and as plain simple as possible. Every statement should focus on a process or data manipulation, and leave the complicated programming syntax out of it.

* Everything is an action. Action in RPScript context means a prefix keyword, follow by parameters and/or optional arguments.
```
action :: <keyword> <...params> <--opt=literal>
```

* Leave the concept of libraries out of the syntax. rely on command line to to perform module management. Example: if you need to process a csv file, simply add the module to your machine by using the command. And the keywords will apply to all your script. no more ```import * from 'csv'``` , ```new CSV(params)```.
````
rps install csv
````
* Modules consists of a list of keywords. When you install a module, you are simply adding more keywords into the framework.

````
<keyword> <...parameters>
````
## Syntax
```
action     :: <keyword> ...param --opt=optValue | action

keyword    :: [a-z][a-zA-Z0-9-]*
param      :: literal | action | lamda | variable
opt        :: [a-z][a-zA-Z0-9-]*
optValue   :: literal

lamda      :: (...variable) => action
literal    :: String | Number | Object | Array | Boolean
variable   :: [$][a-zA-Z0-9]+ | envvar
envvar     :: [$$][a-zA-Z0-9]+
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
**EnvVar** | log $$1 | Param to be passed before execution.


## Module

Module is made up of keywords. That's it.
When you install a module, you are basically adding more keywords to your dictionary.

A full list of keys can be display with this command.
```
rps actions
```

You can also view the keywords related to a specific module.
```
rps module csv
```
