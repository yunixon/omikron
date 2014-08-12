class BetsController < ApplicationController
  load_resource :event
  load_and_authorize_resource :bet, through: :event
  before_action :find_event, only: [:create, :check_event]
   
  def new
    @bet = Bet.new
  end
  
  def create
    @bet = Bet.new(bet_params.merge(event: @event, user: current_user))
    if @bet.save   
      redirect_to events_path
    else
      render "new"
    end
  end
  
private
 
  def find_event
    @event = Event.find(params[:event_id])
  end
  
  def bet_params
    params.require(:bet).permit(:sum, :side_bet, :event_id, :user_id,
      :complete_type)
  end
  
end