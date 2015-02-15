class PaperUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :paper

  validates_presence_of :user_id, :paper_id, :user_own_type_id
end
