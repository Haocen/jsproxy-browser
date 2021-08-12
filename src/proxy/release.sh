DST=../../www/assets

rm -rf $DST/bundle.*.js

npx webpack \
  -o "$DST/" \
  --output-filename "bundle.[chunkhash:8].js" \
  --mode production

cd $DST

for i in bundle.*.js; do
  printf "\
jsproxy_config=\
x=>{\
__CONF__=x;\
importScripts(__FILE__=x.assets_cdn+'$i')\
};\
importScripts('conf.js')\
" > ../sw.js
done