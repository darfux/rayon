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

private
  def match_client
    if session[:step]==-1|| session[:step]==nil
      session[:step] = 0
    else
      return {status: NO_CHANGE} if rand(10)>4
    end
    case session[:step]
    when 0
      session[:step] = 1
      return {status: CHANGE, loaded: [], loading: [0], rate: 0}
    when 1
      session[:step] = 2
      return {status: CHANGE, loaded: [0], loading: [1], rate: 25}
    when 2
      session[:step] = 3
      return {status: CHANGE, loaded: [0,1], loading: [2], rate: 50}
    when 3
      session[:step] = 4
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
