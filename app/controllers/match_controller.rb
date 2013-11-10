class MatchController < ApplicationController
  def index
  	respond_to do |format| 
      format.js
    end
  end

  def match
  end
end
