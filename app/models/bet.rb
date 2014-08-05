class Bet < ActiveRecord::Base
  extend Enumerize

  enumerize :side_bet, in: { first: 0, second: 1 }
  enumerize :complete_type, in: { lose: 0, win: 1, draw: 2, unplayed: 3 }, default: :unplayed
 
  belongs_to :user
  belongs_to :event
  
  validates :side_bet, presence: true
  validates :sum,      presence: true, numericality: { greater_than: 0.0 }
  
  validates_associated :event
  validates_associated :user

end
