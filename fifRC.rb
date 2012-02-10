require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'


source = "http://feeds.feedburner.com/railscasts"

content = ""

open(source) do |s| 
  content = s.read
end

rss = RSS::Parser.parse(content, false)

base_url = "http://media.railscasts.com/assets/episodes/videos/"

#SAMPLE_URL => http://media.railscasts.com/assets/episodes/videos/316-private-pub.webm

final_url = rss.items.collect do |item|
  "#{ base_url }#{ item.title.sub("#","").gsub(" ","-").downcase }.webm"
end

#p final_url.inspect #=> printing this is only for debugging purpose

final_url.each do |url|
  `wget -c #{url.downcase}`
end