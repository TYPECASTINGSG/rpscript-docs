# RPScript

A simple scripting language for your daily task automation.

````
;download and extract file to folder "folder"
extract-to "folder" download "http://www.url.com/abc.zip"

;convert csv to manipulated format
convert-csv-to-data read "folder/data.csv" --columns=true

;print out all organisation
log uniq pluck 'organisation' $RESULT | as 'organisations'

;write it to a text file
write "allOrg.txt" $RESULT

;alert with notification dialog
notify "success: allOrg.txt written"

;open the generated text file
open "allOrg.txt"
````