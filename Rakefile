task :default do
  sh "ruby collect.rb > data.ndjson"
  sh "../tippecanoe/tippecanoe --maximum-zoom=15 -P -B15 -f -o data.mbtiles --layer=gsi-fgd data.ndjson"
  sh "ruby fan_out.rb"
end
