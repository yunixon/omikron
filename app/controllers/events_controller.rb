class EventsController < ApplicationController
  load_and_authorize_resource param_method: :event_params
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @search = Event.search(params[:q])
    @events = @search.result(distinct: true).sort_by_dt.page(params[:page]).per(8)
  end

  def show
  end

  def new
    @event = Event.new
    @event.complete_type = CompleteType.new
  end

  def create
    @search = Event.category(@event.event_type_id).search(params[:q])
    @events = @search.result(distinct: true).sort_by_dt.page(params[:page]).per(8)
    @event = Event.new(event_params)
    @event.complete_type = CompleteType.new
    @event.save
  end

  def delete
    @event = Event.find(params[:event_id])
  end

  def edit
    if @event.complete_type.nil?
      @event.complete_type = CompleteType.new
    end
  end

  def update
    @search = Event.category(@event.event_type_id).search(params[:q])
    @events = @search.result(distinct: true).sort_by_dt.page(params[:page]).per(8)
    @event.update(event_params)
  end

  def destroy
    @search = Event.category(@event.event_type_id).search(params[:q])
    @events = @search.result(distinct: true).sort_by_dt.page(params[:page]).per(8)
    @event.destroy
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
