class Achievement < ActiveRecord::Base
  include Tagable
  belongs_to :user 
  validates_presence_of :title, :user_id

  alias_attribute :name, :title

  searchable do
    text :name, :as => :project_description
  end 

end
