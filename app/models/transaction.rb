class Transaction < ActiveRecord::Base
  extend Enumerize
  enumerize :t_type, in: { set_bet: 0, win_bet: 1, add_to_balance: 2,
    withdraw_from_balance: 3 }, default: :set_bet
  
  validates :user_id, presence: true
  validates :t_type,  presence: true
  validates :amount,  presence: true, numericality: { greater_than: 0.0 }
  
  belongs_to :user, inverse_of: :transactions
  
end
