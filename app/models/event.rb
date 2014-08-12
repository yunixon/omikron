class Event < ActiveRecord::Base 
  
  has_many   :bets, dependent: :destroy
  has_one    :complete_type, dependent: :destroy
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
        if (self.complete_type.result == bet.side_bet && (not bet.complete))
          bet.update(complete: true, complete_type: :win)
          win_amount = bet.sum + bet.sum * (all_bets_lose_sum - fee) / all_bets_win_sum
          @transaction = Transaction.new(user: bet.user, bet_id: bet.id,
            amount: bet.sum, t_type: :win_bet)
          if @transaction.save
            @transaction.update(complete: true)
          else
            errors.add(:msg, "Error: transaction not saved")
          end
        elsif (self.complete_type.result != bet.side_bet &&
          self.complete_type.result != "unplayed" && (not bet.complete))
          bet.update(complete: true, complete_type: :lose)
        elsif (self.complete_type.result == "unplayed")
          bet.update(complete: false, complete_type: :unplayed)
          # Возвратные транзакции
          @transaction = Transaction.new(user: bet.user, bet_id: bet.id,
            amount: bet.sum, t_type: :set_bet)
          if @transaction.save
            @transaction.update(complete: true)
          else
            errors.add(:msg, "Error: transaction not saved")
          end
        end
      end
    end
  end
  
  def self.start_events
    events = Event.all.where("datetime_start <= ? and complete = ?", Time.now, false)
    events.each do |event|
      #Посылаем письмо админу о стартанувших евентах
      Notifier.start_event_mail(event).deliver
    end
  end
  
end
