class EventsController < ApplicationController
  load_and_authorize_resource param_method: :event_params
  before_action :find_event, only: [:show, :edit, :update]
  after_action :play_bets, only: [:update]
  
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
    @event = Event.new(event_params)
    @event.complete_type = CompleteType.new
    if @event.save
      flash[:success] = "Event added!"
      redirect_to events_path
    else
      render 'new'
    end
    
  end

  def edit
    if @event.complete_type == nil
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
  
  # Как исправить этот говнокод?
  def play_bets
    # Высчитать сумму проигравших ставок и забрать от них 3% себе :)
    #all_sum = @event.bets.sum("sum")
    #all_win_sum = @event.bets.where("side_bet = ? and (side_bet = 0 or side_bet = 1)", @event.complete_type.result).sum("sum")
    #all_lose_sum = all_sum - all_win_sum
    #fee = 0.03 #3% fee
    #all_win_sum = @event.bets.where("side_bet = ?", @event.complete_type.result).sum("sum")
    if @event.bets.any?
      @event.bets.each do |bet|
        case @event.complete_type.result
        when 0, 1
          if @event.complete_type.result == bet.side_bet
            bet.update(complete_type: :win)
            #add_to_user_balance(win_amount())
          else
            bet.update(complete_type: :lose)
          end
        when 2
          bet.update(complete_type: :draw)
          # Возвращаем ставку
          # add_to_user_balance(bet.sum)
        end
      end
    end
  end
  
  private
  
  # Правильно ли так вычитать из баланса пользователя?
  def add_to_user_balance(sum)
    current_user.balance += sum
    if current_user.save
      flash[:success] = "Bet is returned!"
    else
      flash[:danger] = "Error update user balance"    
    end
  end
  
  def win_amount(sum, all_lose_sum, all_win_sum, fee)
    return sum + sum * (all_lose_sum - fee) / all_win_sum
  end
  
end
