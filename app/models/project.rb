class Project < ActiveRecord::Base
  has_many :project_users, :dependent => :destroy
  has_many :users, through: :project_users
  belongs_to :source 
  belongs_to :project_type
  validates_presence_of :name, :project_type_id, :project_state_id, :source_id


  searchable do
    text :name, :as => :project_description
  end 

  cattr_reader :search_show_attrs
  @@search_show_attrs = [["名称", :name]]

  def owner
    User.find_by_id(session[:user_id])
  end

  def source
    Source.find_by_id(self.source_id).name
  end

  def type
    ProjectType.find_by_id(self.project_type_id).name
  end

  def state
    ProjectState.find(self.project_state_id).name
  end

  def participation(user)
    ParticipationType.find(
        ProjectUser.where(user_id: user.id, project_id: self.id
            ).first.participation_type_id
                ).name
  end

  def during
    self.start.to_s+'/'+self.end.to_s
  end

  def get_year_options
    base_year = 1990
    options = Array.new(50) { |index| year = base_year+index; [year, year] }
  end
end
