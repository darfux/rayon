require 'nokogiri'
require 'net/http'
require 'yaml'
require 'Pathname'

begin

filename = Pathname.new(__FILE__).basename(".rb")
$log = File.open("#{filename}.log", "a")

def puts(*args)
	super
	$log.puts args
end

puts "==Spider creeping up web=="
puts Time.new


host = 'sms.nankai.edu.cn'
people = Net::HTTP.get(host, '/teacher/szdw')
doc = Nokogiri::HTML(people)

ar = [{teacher_counter: 0, record_time: nil}]
teacher_counter = 0
(doc/'.xingzheng-txt1')[0..7].each do |dep|
	depname = (dep/'.xingzheng-txt1-tit').inner_text
	puts depname
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
		sa = (doc/'.xinwen-txt_4'/'samp').inner_text.strip.each_line.to_a.collect { |e| e.split('：')[1].strip.chomp rescue nil}

		email = sa[0]
		tel = sa[1]
		faxes = sa[2]
		website = sa[3]

		xt4 = (doc/'.xinwen-txt_4')
		title_label_ar = (xt4/'label').collect { |e| e.inner_text }
		xt4dt = (xt4/'dt').inner_text
		tmp = xt4dt.split("社会兼职：")

		c = tmp[0].strip.each_line.to_a.collect do |e| 
			next unless e
			e.strip!
			e.empty? ? nil : e 
		end

		research_direction = c.join("\n")[5..-1]
		ptjob = tmp[1].nil? ? nil : tmp[1].strip
		name = (doc/'.neiye-shizi-name').inner_text


		xt5 = (doc/'.xinwen-txt_5')
		otherinfo = xt5.inner_text.strip
		table = {
			name: name,
			title_label_ar: title_label_ar,
			tel: tel,
			email: email,
			faxes: faxes,
			website: website,
			ptjob: ptjob,
			otherinfo: otherinfo,
			url: href
		}
		deptable[:teachers]<<table
		puts "	#{name} got"
		teacher_counter+=1
		# break
	end
	puts "Leave #{depname}"
	ar<<deptable
end

ar[0][:teacher_counter] = teacher_counter
ar[0][:record_time] = Time.new
File.open("#{filename}.yml", "w") { |file| file.write(YAML.dump(ar)) }
puts "==================="
puts "Sipder's job done!"
puts "#{teacher_counter} teachers got!"
$log.close

rescue => e
	$log.puts e.inspect
	$log.close
end