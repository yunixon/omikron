class CompleteType < ActiveRecord::Base  
  extend Enumerize
  enumerize :result, in: { first_win: 0, second_win: 1, draw: 2, unplayed: 3 }, default: :unplayed
  
  belongs_to :event
  
  validates :result, presence: true
  validates_associated :event
 
end
