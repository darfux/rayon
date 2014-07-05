require 'nokogiri'
require 'net/http'
require 'yaml'
require 'pathname'

begin

filename = Pathname.new(__FILE__).basename(".rb")
$log = File.open("#{filename}.log", "a")

def puts(*args)
	super
	$log.puts args
end

puts "==Spider creeping up web=="
puts Time.new

host = 'fcollege.nankai.edu.cn'
people = Net::HTTP.get(host, '/s/49/t/28/p/1/c/804/list.htm')
doc = Nokogiri::HTML(people)

ar = [{teacher_counter: 0, record_time: nil}]
teacher_counter = 0

dep_style = %|'background:url(/page/main28/images/list-tt-bg.gif) no-repeat;'|
deplinks = (doc/"table[@style=#{dep_style}]"/'a')[0..3]

deplinks.each do |l|
	depname = l.inner_text
	href = l.attributes['href'].to_s
	doc = Nokogiri::HTML(Net::HTTP.get(host, href))

	puts "Entering #{depname}:"
	deptable = {
		dep: depname,
		teachers: []
	}

	dephref = (doc/'p'/'a')[0].attributes['href'].to_s
	dep = Nokogiri::HTML(Net::HTTP.get(host, dephref))
	teacher_tables = ((dep/'table')[14]/'table')[0..-2] #-1 is an invalid table

	teacher_tables.each do |tb|
		name = (tb/'td')[2].inner_text
		introduction = (tb/'p')[0].inner_text
		research_direction = (tb/'p')[1]
		(research_direction/'strong').remove
		
		link = (tb/'a')[0]
		infohref = "#"
		infohref = (tb/'a')[0].attributes['href'].to_s unless link.nil?

		info_ar = []
		unless infohref.match("htm").nil? || infohref.match("#")
			uri = URI("http://"+host+infohref)  
	    http = Net::HTTP.start(uri.host, uri.port)
	    resp = http.get(uri, nil, nil)


			if resp.code!=:'404'.to_s
				info = Nokogiri::HTML(resp.body)
				puts "	getting #{infohref}"

				info_tables = ((info/'table')[14]/"td[@colspan='2']")
				info_ar = []
				info_tables.each do |it|
					next if it.nil?
					info_ar << it.inner_text.strip.each_line.to_a.collect { |e| e.strip }.join
				end
			end
		end
		table = {
			name: name,
			introduction: introduction,
			research_direction: research_direction,
			info_ar: info_ar,
			url: infohref
		}

		deptable[:teachers]<<table
		puts "	#{name} got"
		teacher_counter+=1
		# break
	end
	puts "Leave #{depname}"
	ar<<deptable
	# break
end

ar[0][:teacher_counter] = teacher_counter
ar[0][:record_time] = Time.new
File.open("#{filename}.yml", "w") { |file| file.write(YAML.dump(ar)) }
puts "==================="
puts "Sipder's job done!"
puts "#{teacher_counter} teachers got!"
$log.close

rescue => e
	puts "!!!-Something wrong-!!!"
	puts e.inspect
	puts e.backtrace
	$log.close
end
