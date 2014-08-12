class Bet < ActiveRecord::Base
  extend Enumerize
  enumerize :side_bet, in: { first_win: 0, second_win: 1, draw: 2 }
  enumerize :complete_type, in: { lose: 0, win: 1, unplayed: 2 }, default: :unplayed
 
  belongs_to :user
  belongs_to :event
  
  validates :side_bet, :complete_type, :sum, presence: true
  validates :sum, numericality: { greater_than: 0.0 } 
  validates_associated :event
  validates_associated :user

  default_scope -> { order('created_at DESC') }
  scope :unplayed, -> { where(complete_type: 2) }
  
  before_validation :check_balance, on: :create
  before_validation :check_event, on: :create
  after_create :create_transaction
  
  protected
  
  def check_balance
    if self.sum <= self.user.balance 
      true
    else
      self.errors.add(:msg, "Error: not money")
      false
    end
  end
  
  def check_event
    if self.event.complete
      self.errors.add(:msg, "Error: event is completed")
      false
    else
      true
    end
  end
  
  def create_transaction
    @transaction = Transaction.new(user: self.user, bet_id: self.id, amount: -self.sum,
      t_type: :set_bet)
    if @transaction.save
      @transaction.update(complete: true)
    else
      errors.add(:msg, "Error: transaction not saved")
    end
  end
  
end