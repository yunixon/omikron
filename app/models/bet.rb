class Bet < ActiveRecord::Base
  extend Enumerize

  enumerize :side_bet, in: { first: 0, second: 1 }
  enumerize :complete_type, in: { lose: 0, win: 1, draw: 2, unplayed: 3 }, default: :unplayed
 
  belongs_to :users
  belongs_to :events

end
