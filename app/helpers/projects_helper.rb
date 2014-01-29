module ProjectsHelper
  def get_content(project, meta)
    params = meta[:params]
    handler = meta[:handler]
    content = ""
    if params
      content = project.send(meta[:attri], params)
    else
      content = project.send(meta[:attri])
    end
    return content unless handler
    self.send(handler, content)
  end
 #  def get_owner
 #    User.find_by_id(session[:user_id])
 #  end

 #  def get_source(project)
 #    Source.find_by_id(project.source_id).name
 #  end

 #  def get_type(project)
 #    ProjectType.find_by_id(project.project_type_id).name
 #  end

 #  def get_state(project)
 #    ProjectState.find(project.project_state_id).name
 #  end

 #  def get_participation(project, user)
 #    ParticipationType.find(
 #        ProjectUser.where(user_id: user.id, project_id: project.id
 #            ).first.participation_type_id
 #                ).name
 #  end

 #  def get_participation_id(project, user)
 #    return nil if project.nil? || user.nil?
 #    projectUser = ProjectUser.where(user_id: user.id, project_id: project.id
 #            ).first
 #    return nil if projectUser.nil?
 #    projectUser.participation_type_id
 #  end

 #  def get_year_options
 #  	base_year = 1990
 #  	options = Array.new(50) { |index| year = base_year+index; [year, year] }
	# end

 #  def get_source_select
 #    selects = []
 #    Source.all.each {|source| selects<<[source.name, source.id.to_i]}
 #    selects
 #  end

  def gen_li(dt, dd)
    li = 
      "<dl class='dl-horizontal'>"+
      "  <dt>#{dt}</dt>"+
      "  <dd>#{dd}</dd>"+
      "</dl>"
  end

end
