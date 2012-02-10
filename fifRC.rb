require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

source = "http://feeds.feedburner.com/railscasts"

content =""

open(source) do |s| content = s.read end

rss =RSS::Parser.parse(content, false)

base_url="http://media.railscasts.com/assets/episodes/videos/"

final_url=[] #=> to store the final URL that needs to be passed to wget

#0.upto(name.count-1) { |n| final_url[n] = base_url + name[n].downcase + ".webm" }

#print final_url
1.upto(rss.items.count) { |n| final_url[n] = rss.items[n].to_s.split('"')[1] }

#print final_url

1.upto(final_url.count) { |n| `wget -c #{final_url[n].downcase}` }
