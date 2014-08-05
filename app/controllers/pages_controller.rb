class PagesController < ApplicationController
  
  def home
    @upcoming_events = Event.upcoming(10)
    @recent_events = Event.recent(10)
  end
  
  def archive
    @search = Event.completed(true).search(params[:q])
    @events = @search.result(distinct: true).sort_by_dt.page(params[:page]).per(10)
  end

  def help
  end

  def about
  end
  
end
