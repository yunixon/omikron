class BetsController < ApplicationController
  load_resource :event
  load_and_authorize_resource :bet, through: :event
  before_action :find_event, only: [:create, :check_event]
   
  def new
    @bet = Bet.new
  end
  
  def create
    @bet = Bet.create(bet_params.merge(event: @event, user: current_user))
    respond_to do |format|
      if @bet.save
        format.html { redirect_to @event, notice: 'Bet was successfully created.' }
        format.json { render :show, status: :created, location: @bet }
        format.js #create.js.haml
      else
        format.html { render :new }
        format.json { render json: @bet.errors, status: :unprocessable_entity }
      end
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