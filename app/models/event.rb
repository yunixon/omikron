class Event < ActiveRecord::Base
  
  has_many :bets
  
  belongs_to :event_types
  belongs_to :complete_types
  
  accepts_nested_attributes_for :bets
  
end
