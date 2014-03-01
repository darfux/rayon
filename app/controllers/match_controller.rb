class MatchController < ApplicationController
  def index
  	respond_to do |format| 
  		format.html
      format.js
    end
  end

  def match
    respond_to do |format| 
      format.html
      format.js
      format.json #render json: User.all.first }
    end
  end

  def status
    respond_to do |format| 
      format.json { 
        render json: {status: match_fsm}.to_json
      }
    end
  end

private
  def match_fsm
    case session[:step]
    when nil,-1
      session[:step] = 0
    when 0
      session[:step] = 1
    when 1
      session[:step] = 2
    when 2
      session[:step] = -1
    else
      session[:step] = nil
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
