require 'json'
$dict = Hash.new {|h, k| h[k] = 0}
$count = 0
def show
  $dict.keys.sort {|a, b| $dict[b] <=> $dict[a]}.each {|k|
    print "#{k}\t#{$dict[k]}\n"
  }
  print "\n"
end
File.foreach('data.ndjson') {|l|
  $count += 1
  json = JSON::parse(l)
  $dict[json['properties']['type']] += 1
  show if $count % 100000 == 0
}
show
