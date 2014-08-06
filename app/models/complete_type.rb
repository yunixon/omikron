class CompleteType < ActiveRecord::Base  
  extend Enumerize

  enumerize :result, in: { first_win: 0, second_win: 1, draw: 2, unplayed: 3 }, default: :unplayed
  
  validates :result, presence: true
  
	belongs_to :event
end
