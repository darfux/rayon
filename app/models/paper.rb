class Paper < ActiveRecord::Base
  has_many :paper_users
  has_many :users, through: :paper_users
end
