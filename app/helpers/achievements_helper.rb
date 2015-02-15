module AchievementsHelper
  def get_brief(project, num=6)
    description = project.description
    if description[0..num].ascii_only?
      project.description[0..num*2] << '...'
    else
      description[0..num] << '...'
    end
  end
end
