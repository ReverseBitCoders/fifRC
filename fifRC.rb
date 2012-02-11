require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'


source = "http://feeds.feedburner.com/railscasts"

content = ""

open(source) do |s| 
  content = s.read
end

rss = RSS::Parser.parse(content, false)

#=> Fetching the URL of the media

final_url = rss.items.collect do |item|
  item.enclosure.url['mp4']= 'webm'
  "#{item.enclosure.url}"
end

#p final_url.inspect #=> printing this is only for debugging purpose

final_url.each do |url|
  `wget -c #{url.downcase}`
end
