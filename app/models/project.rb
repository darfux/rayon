class Project < ActiveRecord::Base
  has_many :project_users
	has_many :users, through: :project_users
	belongs_to :source 
	belongs_to :project_type
	validates_presence_of :name


	searchable do
    text :name, :as => :project_description
  end 

  cattr_reader :search_show_attrs
  @@search_show_attrs = [["名称", :name]]
end
