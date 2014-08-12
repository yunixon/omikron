class EventType < ActiveRecord::Base
	
  has_many :events
  
  accepts_nested_attributes_for :events

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 80 }
  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }
  
end
