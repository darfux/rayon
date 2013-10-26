class ParticipationType < ActiveRecord::Base
	has_one :project_user
end
