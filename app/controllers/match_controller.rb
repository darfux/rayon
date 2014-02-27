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

private
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
