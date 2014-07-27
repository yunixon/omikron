class Event < ActiveRecord::Base
  
  has_many :bets
  
  belongs_to :event_type
  belongs_to :complete_type
  
  accepts_nested_attributes_for :bets
  
end
