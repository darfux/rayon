class ResearchDirection < ActiveRecord::Base
	has_and_belongs_to_many :users

	validates :name, :presence => true, :uniqueness => true

  searchable do
    text :name
  end

  def get_relate_user
    user_list = []
    uhash = {}
    self.class.search{ fulltext name }.results.each  do |r|
      r.users.each do |u|
        if uhash[u] then uhash[u]+=1  else uhash[u]=1 end
      end
    end

    uhash
  end

  def get_relate(klass)
    list = []
    hash = {}
    segs = get_segmentation
    segs.each do |seg|
      klass.search{ fulltext seg }.results.each do |r|
        hash[r] = true
      end
    end
    hash.to_a.collect{ |pair| pair[0] }
  end


  def gen_form_data(list)
    data = ""
    list.each do |key, val|
      data<<"#{key}=#{val}"<<'&'
    end
    data.chop
  end

  def get_segmentation
    uri = URI("http://127.0.0.1:8982/solr/default/analysis/field") 
    http = Net::HTTP.start(uri.host, uri.port)
    data = gen_form_data({
        wt: "json",
        "analysis.showmatch" =>  true,
        "analysis.fieldvalue" => name,
        "analysis.fieldtype" =>  "project_description"
      })
    resp = http.post(uri.request_uri, data, {})
    res = resp.body.to_s
    hash = JSON.parse(res)
    segmentations = hash["analysis"]["field_types"]["project_description"]["index"][1]
    results = []
    segmentations.each do |seg|
      results<<seg["text"] if seg["text"].size>=2
    end
    results
  end

end
