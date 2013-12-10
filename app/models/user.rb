class User < ActiveRecord::Base
	has_many :project_users, :dependent => :destroy
  has_many :projects, through: :project_users, :dependent => :destroy

  has_many :achievements, :dependent => :destroy

  has_many :paper_users, :dependent => :destroy
  has_many :papers, through: :paper_users, :dependent => :destroy

  has_and_belongs_to_many :research_directions
  
  belongs_to :title

  validates :uid, :presence => true, :uniqueness => true
  validates :password, :presence => true, :on => :create
  validates :name, :presence => true
  has_secure_password
  searchable do
    text :name
  end
 	cattr_reader :search_show_attrs
  @@search_show_attrs = [["姓名", :name]]
end
