module ProjectsHelper
  def get_owner
    User.find_by_id(session[:user_id])
  end
  def get_brief(project)
  	description = project.description
  	if description[0..6].ascii_only?
  		project.description[0..12] << '...'
  	else
  		description[0..6] << '...'
  	end
  end
  def get_year_options
  	base_year = 1990
  	options = Array.new(50) { |index| year = base_year+index; [year, year] }
	end
end
