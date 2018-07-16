cd ../rpscript-api-basic && npm run build
cd ../rpscript-api-shelljs && npm run build

cd ../rpscript-site
./node_modules/.bin/jsdoc ../rpscript-api-basic/build/index.js ../rpscript-api-shelljs/build/index.js -d docs -c jsdoc.conf.json --readme README.md