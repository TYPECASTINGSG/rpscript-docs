# RPScript
Introduction to RPScript


## Install

```
npm i -g rpscript
```

## Getting started



## Usage

### Module

Check out the entire modules and actions here


List modules
```
rps modules
```

List actions of module
```
rps module <moduleName>
```


### Action

#### Structure

```
 <verbs...> "params" --<opts>=<opts_value>
```


#### Pipe 

```
   <verb> ...params | <verb>
```

### variables

```
   $variableName
```

### Directive

#### @if / @elif /@else

#### @include

#### function

Anonymous function

```
   @ $params { 
       action_1
       action_1
       ...
   }

```

Named function

```
@functionName $params... {

}
```

Execute function

```
@functionName <param...>
```