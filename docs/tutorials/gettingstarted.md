RPScript runs on top of NodeJS. To install RPScript, first you have to install [Nodejs](https://nodejs.org/en/download/).

## Install

After you have installed Node.js, fire up your terminal console, and enter the command.
```
npm i -g rpscript
```
Congratulation, rpscript has now installed in your machine.

To confirm the installation is successful, enter:
```
rps
```
You will then see the message below.
<pre class="prettyprint"><code class="nocode">
  Usage: rps [filename] [options]

  ******************************************** 
   ____  ____    ____            _       _
  |  _ \|  _ \  / ___|  ___ _ __(_)_ __ | |_ 
  | |_) | |_) | \___ \ / __| '__| | '_ \| __|
  |  _ <|  __/   ___) | (__| |  | | |_) | |_ 
  |_| \_\_|     |____/ \___|_|  |_| .__/ \__|
                                  |_|         
  ******************************************** 

  Options:

    -v, --version      Display version
    -d, --debug        Show debugging information on console
    -h, --help         output usage information

  Commands:

    verify &#x3C;filename&#x3E;  Verify if the rps script is valid
    install [modules]  Install one or more modules
    remove [modules]   Remove one or more modules
    modules            List modules information
    module &#x3C;module&#x3E;    Show module information
    actions            List installed actions
    help [cmd]         display help for [cmd]
</code></pre>

## Module installation

Actions (similar to expression) is the heart of RPScript. When you install a module, you are actually installing a set of actions that model a user process.

To get started, install the module [basic](file:///home/jameschong/projects/rpscript-site/docs/Basic.html).

<pre class="prettyprint"><code class="nocode">rps install basic
</code></pre>
This module provides some basic operations and data manipulation.
You can verify with the command when it is done.

<pre class="prettyprint"><code class="nocode">rps module basic
</code></pre>

## Writing your first hello world

Let's create our first script. Create a text file 'hello.rps' and copy the code below to your favourite text editor.

<pre class="prettyprint lang-rps"><code>;print 'hello'
log "hello"
</code></pre>

You should be seeing a standard "hello" message on the terminal.

To print out 3 times.
<pre class="prettyprint lang-rps"><code>log repeat "hello" 3
</code></pre>

`log` and `repeat` are keywords from the installed `basic` module.

There are currently 11 available modules that you can install and use immediately. More modules will be available in the future. For the full list of modules, refer to the API documentation.


## Fancy Ascii Art

Now, let's get fancier by adding some ascii art.

Let's install the [figlet](http://doc.rpscript.com/doc/figlet) module.
<pre class="prettyprint"><code class="lang-rps">rps install figlet
rps module figlet

;name : figlet
;version : xxx
;actions : figlet
</code></pre>
Now, change your script to and run `rps hello.rps`
<pre class="prettyprint lang-rps"><code>log figlet "Ghost" "Casper"
</code></pre>

## Compose actions

RPScript is a functional language, which explains why ramda is part of the `basic` module. For now, I assume you have basic foundation on ramda. I highly recommend to read the tutorial series [Thinking in Ramda](http://randycoulman.com/blog/categories/thinking-in-ramda/).

Let's start with an example that prints a word every one second.
<pre class="prettyprint lang-rps"><code>assign "val" split " " "RPScript is really awesome . . ."
for-each (compose (wait 1) (log) (figlet "Ghost")) $val
</code></pre>

What does it mean?

**Line 1** assigns a variable name val, and save the result of the action `split " " "RPScript is really awesome . . ."`
The action [split](http://docs.rpscript.com/Basic.html#.split) takes a string and split into an array of strings with whitespace as the delimiter.

**Line 2** takes all items from the list, and perform the composition of 3 actions evaluated from right to left.

[for each](http://docs.rpscript.com/Basic.html#.for-each) item in the list, convert with [figlet](http://docs.rpscript.com/Figlet.html#.figlet), then [print](http://docs.rpscript.com/Basic.html#.log) to the terminal, then [wait](http://docs.rpscript.com/Basic.html#.wait) 1 second.


If the order bothers you, you can switch by using pipe instead. 

<pre class="prettyprint lang-rps"><code>assign "val" split " " "RPScript is really awesome . . ."
assign "slowFiglet" pipe (figlet "Ghost") (log) (wait 1)

for-each $slowFiglet $val
</code></pre>