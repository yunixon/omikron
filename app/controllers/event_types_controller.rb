class EventTypesController < ApplicationController
  load_and_authorize_resource param_method: :event_type_params
  before_action :find_event_type, only: [:show, :edit, :update]
  
  def index
  end

  def new
    @event_type = EventType.new
  end

  def create
    @event_type = EventType.new(event_type_params)
    if @event_type.save
      flash[:success] = "Category successfully added."
      redirect_to event_types_path
    else
      render 'new'
    end
    
  end

  def update
    if @event_type.update_attributes(event_type_params)
      flash[:success] = "Category updated."
      redirect_to @event_type
    else
      render 'edit'
    end
  end

  def destroy
    EventType.find(params[:id]).destroy
    flash[:success] = "Category destroyed."
    redirect_to event_types_path
  end
  
  private
  
  def find_event_type
    @event_type = EventType.find(params[:id])
  end

  def event_type_params
    params.require(:event_type).permit(:name, :event_type_type_id, :description)
  end
  
end
