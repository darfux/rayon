class Achievement < ActiveRecord::Base
  belongs_to :user 
  validates_presence_of :title, :user_id

  searchable do
    text :title, :as => :project_description
  end 
  
  def name
    self.title
  end
end
