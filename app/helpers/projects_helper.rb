module ProjectsHelper
  def get_owner
    User.find_by_id(session[:user_id])
  end
  def get_year_options
  	base_year = 1990
  	options = Array.new(50) { |index| year = base_year+index; [year, year] }
	end
end
