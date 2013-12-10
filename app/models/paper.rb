class Paper < ActiveRecord::Base
  has_many :paper_users, :dependent => :destroy
  has_many :users, through: :paper_users

  validates_presence_of :title
end
