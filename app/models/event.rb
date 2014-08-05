class Event < ActiveRecord::Base
  
  has_many   :bets
  belongs_to :event_type
  belongs_to :complete_type
  
  accepts_nested_attributes_for :bets
  
  validates :name,             presence: true, length: { in: 3..120 }
  validates :first_side,       presence: true, length: { in: 3..80 }
  validates :second_side,      presence: true, length: { in: 3..80 }
  validates :event_type_id,    presence: true
  validates :datetime_start,   presence: true
end
