class Event < ActiveRecord::Base 
  
  has_many   :bets
  has_one    :complete_type
  belongs_to :event_type
  
  accepts_nested_attributes_for :bets, allow_destroy: true
  accepts_nested_attributes_for :complete_type, allow_destroy: true  
  
  validates :name, :first_side, :second_side, :datetime_start, presence: true
  validates :name, :first_side, :second_side, length: {minimum: 2}
  validates_associated :event_type
  
  scope :completed, -> (bool)  { where(complete: bool) }
  scope :category, -> (cat) { where(event_type: cat) }
  scope :upcoming, -> (count) { where(complete: false).last(count) }
  scope :recent, -> (count) { where(complete: true).last(count) }
  scope :sort_by_dt, -> { order(:datetime_start) }

  after_save :play_bets
  
  protected
  
  def play_bets
    # Высчитать сумму проигравших ставок и забрать от них 3% себе :)
    all_bets_sum = self.bets.sum("sum") # Сумма всех ставок
    all_bets_lose_sum = self.bets.where.not("side_bet = ?", self.complete_type).sum("sum")
    all_bets_win_sum = all_bets_sum - all_bets_lose_sum
    fee = 0.03*all_bets_lose_sum #3% fee
    if self.bets.any?
      self.bets.each do |bet|
        case self.complete_type.result
        when "first_win", "second_win"
          if self.complete_type.result == bet.side_bet
            bet.update(complete: true, complete_type: :win) unless bet.complete
            # add transaction
            win_amount = bet.sum + bet.sum * (all_bets_lose_sum - fee) / all_bets_win_sum
            add_to_user_balance(win_amount) unless bet.complete
          else
            bet.update(complete: true, complete_type: :lose) unless bet.complete
          end
        when "draw"
          bet.update(complete: true, complete_type: :draw) unless bet.complete
          #На данном этапе draw - это тоже lose ставка
        when "unplayed"
          # отмена розыгрыша
          bet.update(complete: false, complete_type: :unplayed) if bet.complete
          #Создать возвратные транзакции unless bet.complete
        end
      end
    end
  end
  
  # А может работа с балансом пользователя в user модели?
  def add_to_user_balance(sum)
    self.user.balance += sum
    if self.user.save
      true
      puts "Added to user"
    else
      false
      errors.add(:msg, "Error in update user balance!")
    end
  end
  
  def win_amount(sum, all_lose_sum, all_win_sum, fee)
    return sum + sum * (all_lose_sum - fee) / all_win_sum
  end
  
end
