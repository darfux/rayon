require 'nokogiri'
require 'net/http'
require 'yaml'
require 'Pathname'

filename = Pathname.new(__FILE__).basename(".rb")
$log = File.open("#{filename}.log", "w")
def puts(*args)
	super
	$log.puts args
end

host = 'wxy.nankai.edu.cn'
people = Net::HTTP.get(host, '/People/3/1')
doc = Nokogiri::HTML(people)
ar = [0]
teacher_counter = 0
doc.search(".peopleList")[0..4].each do |dep|
	depname = dep.previous_element.inner_text;
	puts "Entering #{depname}:"
	deptable = {
		dep: depname,
		teachers: []
	}
	dep.search("a").each do |a|
		href = a.attributes['href'].to_s
		puts "	getting #{href}"
		info = Net::HTTP.get(host, href)
		str = info.force_encoding('utf-8')
		doc = Nokogiri::HTML(str)

		detail = doc.search(".peopleDetail")[0]
		basic = detail.search(".basicInfo")[0]
		name = basic.search("h3")[0].inner_text
		ps = basic.search("p")
		
		# ps[0] is department info
		title = ps[1].inner_text
		tel = ps[2].inner_text
		email = ps[3].inner_text
		otherinfo = detail.search(".otherInfo")[0].inner_text

		table = {
			name: name,
			title: title,
			tel: tel,
			email: email,
			otherinfo: otherinfo,
			url: href
		}
		deptable[:teachers]<<table
		puts "	#{name} got"
		teacher_counter+=1
	end
	puts "Leave #{depname}"
	ar<<deptable
end
ar[0] = teacher_counter
File.open("#{filename}.yml", "w") { |file| file.write(YAML.dump(ar)) }
puts "==================="
puts "Sipder's job done!"
puts "#{teacher_counter} teachers got!"
$log.close

