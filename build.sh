# cd ../rpscript-api-basic && npm run build
# cd ../rpscript-api-open && npm run build  #COMPLETED
cd ../rpscript-api-download && npm run build  #stable:HIGH
cd ../rpscript-api-csv && npm run build
# cd ../rpscript-api-figlet && npm run build  #COMPLETED
cd ../rpscript-api-beeper && npm run build  #COMPLETED
# cd ../rpscript-api-file && npm run build
cd ../rpscript-api-hogan && npm run build #COMPLETED
# cd ../rpscript-api-date-fp && npm run build
# cd ../rpscript-api-adm-zip && npm run build #stable:MED
# cd ../rpscript-api-notifier && npm run build #COMPLETED

# cd ../rpscript-api-columnify && npm run build  #stable:HIGH
# cd ../rpscript-api-shelljs && npm run build
# cd ../rpscript-api-replace-string && npm run build  #stable:HIGH
# cd ../rpscript-api-faker && npm run build #stable:HIGH
# cd ../rpscript-api-sloc && npm run build
## cd ../rpscript-api-request && npm run build
# cd ../rpscript-api-cheerio && npm run build
# cd ../rpscript-api-mathjs && npm run build
# cd ../rpscript-api-fs-extra && npm run build
# cd ../rpscript-api-moment && npm run build
# cd ../rpscript-api-robotjs && npm run build


cd ../rpscript-site
./node_modules/.bin/jsdoc \
../rpscript-api-basic/build/index.js \
../rpscript-api-csv/build/index.js \
../rpscript-api-beeper/build/index.js \
../rpscript-api-date-fp/build/index.js \
../rpscript-api-open/build/index.js \
../rpscript-api-download/build/index.js \
../rpscript-api-figlet/build/index.js \
../rpscript-api-adm-zip/build/index.js \
../rpscript-api-hogan/build/index.js \
../rpscript-api-file/build/index.js \
../rpscript-api-notifier/build/index.js \
-d docs -c jsdoc.conf.json --readme README.md

# ../rpscript-api-shelljs/build/index.js \
# ../rpscript-api-ramda/build/index.js \
# ../rpscript-api-replace-string/build/index.js \
# ../rpscript-api-columnify/build/index.js \
# ../rpscript-api-faker/build/index.js \
# ../rpscript-api-sloc/build/index.js \
# ../rpscript-api-shelljs/build/index.js \
# ../rpscript-api-lodash/build/index.js \
# ../rpscript-api-request/build/index.js \
# ../rpscript-api-cheerio/build/index.js \
# ../rpscript-api-file/build/index.js \
# ../rpscript-api-mathjs/build/index.js \
# ../rpscript-api-fs-extra/build/index.js \
# ../rpscript-api-moment/build/index.js \
# ../rpscript-api-robotjs/build/index.js \