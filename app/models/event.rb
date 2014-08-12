class Event < ActiveRecord::Base 
  
  has_many   :bets, dependent: :destroy
  has_one    :complete_type, dependent: :destroy
  belongs_to :event_type
  
  accepts_nested_attributes_for :bets, allow_destroy: true
  accepts_nested_attributes_for :complete_type, allow_destroy: true  
  
  validates :name, :first_side, :second_side, :datetime_start, presence: true
  validates :name, :first_side, :second_side, length: {minimum: 2, maximum: 80}
  validates_associated :event_type
  
  default_scope -> { order('created_at DESC') }
  scope :completed, -> (bool)  { where(complete: bool) }
  scope :category, -> (cat) { where(event_type: cat) }
  scope :upcoming, -> (count) { where(complete: false).last(count) }
  scope :recent, -> (count) { where(complete: true).last(count) }
  scope :sort_by_dt, -> { order(:datetime_start) }

  after_save :play_bets
   
  protected
  
  def play_bets
    self.bets.each do |bet|
      if self.complete_type.result == bet.side_bet && !bet.complete
        user_win(bet)
      elsif self.complete_type.result != bet.side_bet &&
        user_lose(bet)
      elsif (self.complete_type.result == "unplayed")
        user_return(bet)
      end
    end
  end
  
  def user_win(bet)
    bet.update(complete: true, complete_type: :win)
    @transaction = Transaction.new(user: bet.user, bet_id: bet.id,
      amount: bet.sum, t_type: :win_bet)
    if @transaction.save
      @transaction.update(complete: true)
    else
      errors.add(:msg, "Error: transaction not saved")
    end
  end
  
  def user_lose(bet)
    self.complete_type.result != "unplayed" && !bet.complete
    bet.update(complete: true, complete_type: :lose)
  end
  
  def user_return(bet)
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
  
  def self.start_events
    events = Event.where("datetime_start <= ? and complete = ?", Time.now, false)
    events.each do |event|
      #Посылаем письмо админу о стартанувших евентах
      Notifier.start_event_mail(event).deliver
    end
  end
  
end
