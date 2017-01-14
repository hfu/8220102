require 'find'
require 'json'

src_dir = '/Volumes/My Passport for Mac/xyz/experimental_fgd/18'
src_x = 220
src_y = 102
d = 2 ** 10
d.times {|dx|
  x = src_x * d + dx
  d.times {|dy|
    y = src_y * d + dy
    path = "#{src_dir}/#{x}/#{y}.geojson"
    next unless File.exist?(path)
    json = JSON::parse(File.read(path))
    json['features'].each {|feat|
      feat['properties'].delete_if{|k, v|
        %w{fid lfSpanFr lfSpanTo devDate orgMDId}.include?(k)
      }
      case feat['properties']['type']
      when '普通建物', '一般等高線', '標高点（測点）', '一条河川', '徒歩道', '普通無壁舎', '徒歩道', '歩道', '庭園路等', 'せき', '分離帯', '側溝', 'トンネル内の道路', '防波堤', '三角点', '透過水制', 'その他', '水門', 'トンネル内の鉄道', '水準点', '不透過水制', '不明', '敷石斜坂'
        # 最詳細
        feat[:tippecanoe] = {:minzoom => 15}
      when '水涯線（河川）', '一条河川', '堅ろう建物', '砂防ダム', '桟橋（鉄，コンクリート）', 'ダム', '索道', '堅ろう無壁舎', '電子基準点', '特殊軌道'
        # 詳細
        feat[:tippecanoe] = {:minzoom => 13}
      when '真幅道路', '普通鉄道', '大字・町・丁目界', '大字・町・丁目', '町村・指定都市の区'
        # 概要
        feat[:tippecanoe] = {:minzoom => 12}
      when '海岸線', '都道府県界', '郡市・東京都の区界', '市区町村界', '郡市・東京都の区'
        # 突き抜け
        feat[:tippecanoe] = {:minzoom => 4}
      else
        # デフォルト
        feat[:tippecanoe] = {:minzoom => 13}
      end
      print JSON::dump(feat), "\n"
    }
  }
}
