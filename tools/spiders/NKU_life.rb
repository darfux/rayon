require 'nokogiri'
require 'net/http'
require 'yaml'
require 'pathname'



@host = 'sky.nankai.edu.cn'

def doc_get(path)
	html = Net::HTTP.get(@host, path)
	html.force_encoding("gbk") #pgae charset isn't gb2312 as it declared

	html = html.encode!('utf-8') 
	Nokogiri::HTML(html)
end

doc = doc_get '/list.asp?id=198'

# charset = Nokogiri::HTML(html).meta_encoding  
# doc = Nokogiri::HTML(html, 'utf-8', charset)


# (doc/'.pos'/'a')[1].inner_text 		=> category name
# (doc/'.detail'/'table'/'a')[0] 	=> people list

(doc/'.detail'/'table'/'a').each do |l|
	# (people/'.detail'/'h2') => name

	href = '/'+l.attributes['href'].to_s
	people = doc_get('/teacher.asp?id=buwj')
	# name = (people/'.detail'/'h2').inner_text
	name = (people/'.detail'/'h2').inner_text

	handle = lambda { |str| str.split('：')[1]}
	brief = (people/'.detail'/'table'/'td')
	sex			=	handle.call brief[2].inner_text
	title		=	handle.call brief[3].inner_text
	dep			=	handle.call brief[4].inner_text
	admissions	= handle.call brief[5].inner_text
	research_direction =	handle.call brief[6].inner_text
	info = (people/'.detail'/'pre').inner_text
	trs = (people/'.detail'/'table'/'tr')
	papers =  trs[10]
	projects = trs[12]

	table = {
			name: name,
			sex: sex,
			title: title,
			dep: dep,
			admissions: admissions,
			research_direction: research_direction,
			info: info,
			papers: papers,
			projects: projects,
			url: href
		}
	break
end
# (doc/'.detail'/'a').each { |e| puts e }