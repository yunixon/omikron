class TransactionsController < ApplicationController
  load_and_authorize_resource param_method: :transaction_params
  before_action :find_bet, only: [:create]
   
  def create
    @transaction = Transaction.new(transaction_params.merge(user: current_user, bet: @bet))
    if @transaction.save            
      flash[:success] = "Transaction create - set bet and deduct balance"
    else
      flash[:danger] = "Error - Transaction not save"
    end
  end
  
  private
  
  def transaction_params
    params.require(:transaction).permit(:user_id, :bet_id, :amount, :t_type,
      :complete, :complete_type)
  end

  def find_bet
    @event = Bet.find(params[:bet_id])
  end
  
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  
end
