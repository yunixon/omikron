class EventsController < ApplicationController
  load_and_authorize_resource param_method: :event_params
  before_action :find_event, only: [:show, :edit, :update]
  
  def index
    @search = Event.search(params[:q])
    @events = @search.result(distinct: true).sort_by_dt.page(params[:page]).per(8)
    
    @event = Event.new
    @event.complete_type = CompleteType.new
  end

  def show
  end

  def new
    @event = Event.new
    @event.complete_type = CompleteType.new
  end

  def create
    @event = Event.new(event_params)
    @event.complete_type = CompleteType.new
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
        format.js   { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.js   { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    if @event.complete_type.nil?
      @event.complete_type = CompleteType.new
    end
  end

  def update
    if @event.update_attributes(event_params)
      flash[:success] = "Event updated"
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    flash[:success] = "Event destroyed."
    redirect_to events_path
  end
  
  def search
   @search = params[:search][:q]
  end
  
  private
  
  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :event_type_id, :first_side, :second_side,
      :datetime_start, :count, :complete, complete_type_attributes: complete_type_params)
  end
  
  def complete_type_params
    [:id, :result, :description, :event_id, :_destroy]
  end
  
end
