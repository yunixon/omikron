class EventType < ActiveRecord::Base
	
  has_many :events
  
  accepts_nested_attributes_for :events

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
end
