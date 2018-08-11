# RPScript

A simple scripting language for your daily task automation.
An easy to read scripting language for your task automation.


RPScript goal is simple, that is to provide a simple  framework for you to automate your mundane tasks. Task that are repetitive should be left to machine, so that you can focus on value-added work.

RPScript aims to provide a simple syntax that you don't need in-depth programming knowledge to work with it.

The principles:

* syntax that is intuitive and as plain simple as possible. Every statement should focus on a process or data manipulation, and leave the complicated programming syntax out of it.

* Leave the concept of libraries out of the syntax. rely on command line to to perform module installation. Example: if you need to process a csv file, simply add the module to your machine by using the command. And the keywords will apply to all your script. no more ```import * from 'csv'``` , ```new CSV(params)```.
````
rps install csv
````
* Simple concise syntax. Action is the foundation of RPScript. When you install a module, each module comes with keywords that you can use.
````
<keyword> <...parameters>
````


## Install

Prerequisite: NodeJS

```
npm i -g rpscript
```
This will install a global command line in your machine.

Let's install 2 modules: basic.
```
rps install basic
```

Create a file "helloworld.rps" and add the statement:
```
log repeat "hello world " 3
```




## Getting Started With Fancy Ascii Art

Install 3 more modules for file downloading, ascii art and file operations respectively.
```
rps install downloading figlet file
```

Start by create another file name "ascii.rps" and copy and paste the lines below to the file.

```
download "." "https://s3.amazonaws.com/sample.rpscript.com/figlet/all-fonts.txt"

split "\n" read-file "all-fonts.txt" | as 'fonts'

for-each ($val)=> (wait 1 log concat `== ${$val} ==\n` figlet --font=$val "RPScript") $fonts
```

The first line downloads the list of fonts provided by figlet.

Follow by splitting the file content by newline.

The last line iterate the list of fonts and print out fanciful ascii text with a wait period of 1 second.

