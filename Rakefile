task :default do
  sh "ruby collect.rb > data.ndjson"
  sh "../tippecanoe/tippecanoe --maximum-zoom=15 -P -B16 -f -o data.mbtiles --layer=gsi-fgd data.ndjson"
end
