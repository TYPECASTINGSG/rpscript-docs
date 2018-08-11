RPScript runs on top of NodeJS. To install RPScript, first you have to install [Nodejs](https://nodejs.org/en/download/).

## Install

After you have installed Node.js, fire up your terminal console, and enter the command.
```
npm i -g rpscript
```
Congratulation, rpscript is now installed in your machine.

RPScript is nothing more than an execution environment that process your script. After your installation, a global command 'rps' will be available to you.

This is the application used for parsing, executing your script and manage your modules.

To confirm the installation is successful, enter:
```
rps
```
You will then see a similar message as below.
```
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

    verify <filename>  Verify if the rps script is valid
    install [modules]  Install one or more modules
    remove [modules]   Remove one or more modules
    modules            List modules information
    module <module>    Show module information
    actions            List installed actions
    help [cmd]         display help for [cmd]
```

## Module installation

RPScript is module driven. Without module, you can't do anything about it. To start it off, let's install the core module, basic.

```
rps install basic
```
This is will basic operations and data manipulation keywords.
You can verify with the command when it is done.
```
rps module basic
```

## Writing your first hello world

Let's not dive into the real action. Let's create our first script. Create a text file 'hello.rps' and start typing with your favourite text editor.

```
;Printout 'hello rpscript'
log "hello"
```

Nothing fanciful here, just a normal print out to the terminal.

Let's getting a bit fancier by say.... print out 3 times?
```
log repeat "hello" 3
```
To find out more on the keywords, refer to the [documentation](http://doc.rpscript.com/api).

Sick of silly console log 'Hello world'? I heard you. It's get a little arty farty by making the hello fancier.
Let's install the [figlet](http://doc.rpscript.com/doc/figlet)
```
rps install figlet
rps module figlet

;name : figlet
;version : xxx
;actions : figlet
```
Now, change your script to.
```
log figlet 'hello'
```
Add a little spook to your text.
```
log figlet 'Casper' --font="Ghost"
```

Let's say by now you kinda really like RPScript and want to write something awesome to show your love for it. Let's celebrate by sharing your appreciation by doing it in style.

```
assign "val" split " " "RPScript is really awesome . . ."

for-each (compose (wait 1) (log) (figlet)) $val
```
What does this two lines of statement means?

Line one simple say assign a variable name val, and save the result of `split " " "RPScript is really awesome . . ."` which converts a string to an list by splitting it with space.

The second line simply all items from the list, and perform an operation.

And what is the operation? It is a `compose` 3 actions. figlet, log, wait 1 sec.

If the order bothers you, you can switch the order by using pipe instead. 

```
assign "val" split " " "RPScript is really awesome . . ."
assign "slowFiglet" pipe (figlet) (log) (wait 1)

for-each $slowFiglet $val
```