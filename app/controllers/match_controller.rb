class MatchController < ApplicationController
  CHANGE = :CHANGE
  NO_CHANGE = :NOCHANGE
  FINISH = :FINISH
  def index
  	respond_to do |format| 
  		format.html
      format.js
    end
  end

  def match
    @user = User.find(session[:user_id])
    session[:step] = nil
    respond_to do |format| 
      format.html
      format.js
      format.json #render json: User.all.first }
    end
  end

  def status
    respond_to do |format| 
      format.json { 
        render json: match_client.to_json
      }
    end
  end

  def result
    @user = User.find(session[:user_id])
    @expert = (
      if session[:expert_id]==-1
        User.new(name: "无匹配") 
      else 
        User.find(session[:expert_id])
      end
    )
    @achievement = get_matched(:achievement)
    @paper = get_matched(:paper)
    @project = get_matched(:project)
  end
  
private
  def get_matched(name)
    (
    if session["#{name}_id".to_sym]==-1
      name.to_s.classify.constantize.new(name: "无匹配") 
    else 
      name.to_s.classify.constantize.find(session["#{name}_id".to_sym])
    end
    )
  end

  def match_relate(klass)
    (
        tmp = @user.relate(klass)
        if tmp
          tmp[0].id
        else
          -1
        end
    )
  end
  def match_client
    @user = User.find(session[:user_id])
    if session[:step]==-1|| session[:step]==nil
      session[:step] = 0
    else
      return {status: NO_CHANGE} if rand(10)>8
    end
    case session[:step]
    when 0
      session[:step] = 1
      session[:achievement_id] = match_relate(Achievement)
      return {status: CHANGE, loaded: [], loading: [0], rate: 0}
    when 1
      session[:step] = 2
      session[:expert_id] = (
        expert = @user.relate_expert.sort_by{ |k,v| v }.last
        if expert
          expert[0].id
        else
          -1
        end
      )
      return {status: CHANGE, loaded: [0], loading: [1], rate: 25}
    when 2
      session[:step] = 3
      session[:paper_id] = match_relate(Paper)
      return {status: CHANGE, loaded: [0,1], loading: [2], rate: 50}
    when 3
      session[:step] = 4
      session[:project_id] = match_relate(Project)
      return {status: CHANGE, loaded: [0,1,2], loading: [3], rate: 75}
    when 4
      session[:step] = -1
      return {status: FINISH, loaded: [0,1,2,3], loading: [], rate: 100}
    else
      raise 'Wrong status'
    end
  end
  # def branch
  #   p 1
  #   Thread.new { dosome } 
  #   p 3
  #   render
  # end

  # def dosome
  #   loop do
  #     p 1
  #     sleep 1
  #   end
  # end
end
