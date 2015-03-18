class User < ActiveRecord::Base
	has_many :project_users, :dependent => :destroy
  has_many :projects, through: :project_users, :dependent => :destroy

  has_many :achievements, :dependent => :destroy

  has_many :paper_users, :dependent => :destroy
  has_many :papers, through: :paper_users, :dependent => :destroy

  has_and_belongs_to_many :research_directions
  
  belongs_to :title
  belongs_to :unit

  validates :uid, :presence => true, :uniqueness => true
  validates :password, :presence => true, :on => :create
  validates :name, :presence => true
  
  has_secure_password

  searchable do
    text :name
  end

  def relate_expert
    result = {}
    research_directions.each do |rd|
      ru = rd.get_relate_user
      ru.delete(self)
      ru.each do |k,v|
        if result[k]
          result[k] += v
        else
          result[k] = v
        end
      end
    end
    result
  end

  def relate(klass)
    result = {}
    research_directions.each do |rd|
      tmp = rd.get_relate(klass)
      tmp.each do |p|
        if result[p]
          result[p] += 1
        else
          result[p] = 1
        end
      end
    end
    result.sort_by{ |k,v| v }.last
  end

  def unit_name
    unit.try(:name)
  end
  
  cattr_reader :search_show_attrs
  @@search_show_attrs = [["姓名", :name]]
end

