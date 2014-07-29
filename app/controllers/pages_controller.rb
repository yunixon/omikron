class PagesController < ApplicationController
  def home
    @events = Event.where(complete: false)
  end
  
  def history
    @events = Event.where(complete: true)
  end

  def help
  end

  def about
  end

  def faq
  end
  
end
