class SearchResult
  attr_reader :results, :num
  def initialize(type, user, project, achiev, paper)
    case type.to_sym
    when :expert
      @results = user
    when :project
      @results = project
    when :achievement
      @results = achiev
    when :paper
      @results = paper
    else
      @results = (user+project+achiev+paper).flatten
    end
    @num = {
      expert: user.size,
      project: project.size,
      achievement: achiev.size,
      paper: paper.size,
      total: (user+project+achiev+paper).size
    }
  end
  def each
    @results.each do |result|
      yield result
    end
  end
end
class Searcher
  def self.search(params)
    user = User.search{ fulltext params[:content]}
    project= Project.search { fulltext params[:content] }
    achievement = Achievement.search{ fulltext params[:content]}
    paper = Paper.search{ fulltext params[:content]}

    SearchResult.new(params[:type], user.results, project.results, achievement.results, paper.results) 
  end
end