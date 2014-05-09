
require 'nokogiri'
require 'net/http'
require 'yaml'
require 'pathname'



host = 'law.ybu.edu.cn'
people = Net::HTTP.get(host, '/index.php?id=120')
people.force_encoding('gbk')
people.encode!('utf-8')
doc = Nokogiri::HTML(people)
((doc/"td[@bgcolor='#f3f3f3']")[0]/'a').each do |link|
  puts link
end

exit
