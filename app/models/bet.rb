class Bet < ActiveRecord::Base
  extend Enumerize
  enumerize :side_bet, in: { first_win: 0, second_win: 1 }
  enumerize :complete_type, in: { lose: 0, win: 1, draw: 2, unplayed: 3 }, default: :unplayed
 
  belongs_to :user
  belongs_to :event
  
  validates :side_bet, :complete_type, :sum, presence: true
  validates :sum, numericality: { greater_than: 0.0 } 
  validates_associated :event
  validates_associated :user

  # TODO error on current_user
  #scope :for_this_user, -> { where("user_id = ?", current_user) }
  
  after_save :deduct_from_user_balance
  
  protected
  
  # Может это в модель User?
  def deduct_from_user_balance
    self.user.balance -= self.sum
    if self.user.save
      true
      puts "Bet is added"
    else
      false
      errors.add(:msg, "Error in update user balance!")
    end
  end
  
end
