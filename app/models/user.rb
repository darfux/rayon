class User < ActiveRecord::Base
	has_many :project_users
  has_many :projects, through: :project_users
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