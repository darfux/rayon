class ProjectUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :participation_type
  validates_presence_of :user_id, :project_id, :participation_type_id
end
