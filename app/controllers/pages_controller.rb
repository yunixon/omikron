class PagesController < ApplicationController
  
  def home
    @events = Event.where(complete: false)
  end
  
  def archive
    @events = Event.where(complete: true)
  end

  def help
  end

  def about
  end
  
end
