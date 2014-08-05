class PagesController < ApplicationController
  
  def home
    @upcoming_events = Event.where(complete: false).last(10)
    @recent_events = Event.where(complete: true).last(10)
  end
  
  def archive
    @search = Event.where(complete: true).search(params[:q])
    @events = @search.result(distinct: true).order(:datetime_start).page(params[:page]).per(10)
  end

  def help
  end

  def about
  end
  
end
