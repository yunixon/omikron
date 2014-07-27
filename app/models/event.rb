class Event < ActiveRecord::Base
  
  has_many :bets
  
  belongs_to :event_types
  belongs_to :complete_types
  
end
