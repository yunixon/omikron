class BetsController < ApplicationController
  load_resource :event
  load_and_authorize_resource :bet, through: :event
  before_action :find_event
  before_action :check_balance, only: [:create]
  after_action  :deduct_from_user_balance, only: [:create]
 
  def new
    @bet = Bet.new
  end
  
  def create
    @bet = @event.bets.new(bet_params)
    @bet.user = current_user #Можно ли так?
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
  
  def check_balance
    if current_user.balance < @bet.sum
      flash[:danger] = "Not enough money. Recharge balance"
      redirect_to root_url
    end
  end
  
  # Правильно ли так вычитать из баланса пользователя?
  def deduct_from_user_balance
    current_user.balance -= @bet.sum
    if current_user.save
      flash[:success] = "Bet is added!"
    else
      flash[:danger] = "Error update user balance"    
    end
  end
  
end
