class Achievement < ActiveRecord::Base
  belongs_to :user 
  validates_presence_of :title, :user_id

  def name
    self.title
  end
end
