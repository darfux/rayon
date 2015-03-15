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
    # user_list.flatten!
    # uhash = {}
    # user_list.each do |u|
    #   if uhash[u.uid] then uhash[u.uid]+=1  else uhash[u.uid]=0 end
    # end
    # uhash
  end

end
