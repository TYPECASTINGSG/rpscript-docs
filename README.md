# RPScript

A simple scripting language to automate the boring stuff.

RPScript provides a framework to simplify automation. The syntax is designed to be intuitive and straightforward,  allowing you to write scripts without the need for in-depth programming knowledge.

In short, it allows you to replace this:
```
var R = require('ramda');

console.log( R.repeat("Hello world",3) );
```

with this:
```
log repeat "Hello world" 3
```

This:
```
var download = require('download');
var csvParse = require('csv-parse/lib/sync');
var AdmZip = require('adm-zip');
var R = require('ramda');
var fs = require('fs');

download('https://data.gov.sg/dataset/dba9594b-fb5c-41c5-bb7c-92860ee31aeb/download', '.').then(() => {
    var zip = new AdmZip("./download.zip");
    
    zip.extractAllTo("./temp/");

    var content = fs.readFileSync('temp/data-gov-sg-dataset-listing.csv');
    
    var orgs = csvParse(content , {columns:true});

    var orgList = R.uniq(R.pluck('organisation',orgs));

    console.log(orgList); //print out the list of organisations
});

```
with this:
```
download "." "https://data.gov.sg/dataset/dba9594b-fb5c-41c5-bb7c-92860ee31aeb/download"

extract "download.zip" "./temp/"

csv-to-data --columns=true read-file "temp/data-gov-sg-dataset-listing.csv" | as "dataset"

log uniq pluck 'organisation' $dataset
```



## Install

Prerequisite: NodeJS

```
npm i -g rpscript
```
This will install a global command line in your machine.

Module installation.
```
rps install basic
```

Create a file "helloworld.rps" and add this line:
```
log repeat "hello world " 3
```

## Usage

Coming soon.

## Examples

More example coming soon.

