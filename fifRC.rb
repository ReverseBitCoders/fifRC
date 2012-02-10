require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'


source = "http://feeds.feedburner.com/railscasts"

content =""

open(source) do |s| content = s.read end

rss =RSS::Parser.parse(content, false)

name =[] #=> to store the name of videos

base_url="http://media.railscasts.com/assets/episodes/videos/"

#SAMPLE_URL => http://media.railscasts.com/assets/episodes/videos/316-private-pub.webm

0.upto(rss.items.count-1) { |f| name.push(rss.items[f].title) } #=> to fetch the titles from RSS feed
0.upto(name.count-1) { |n| name[n] = name[n].sub("#","") } #=> Slice off # from the beginning
0.upto(name.count-1) { |n| name[n] = name[n].gsub(" ","-") } #=> replace all blank spaces with "-"
#print name

final_url=[] #=> to store the final URL that needs to be passed to wget

0.upto(name.count-1) { |n| final_url[n] = base_url + name[n].downcase + ".webm" }

#print final_url

0.upto(final_url.count-1) { |n| `wget -c #{final_url[n].downcase}` }
