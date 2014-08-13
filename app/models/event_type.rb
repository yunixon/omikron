class EventType < ActiveRecord::Base
	
  has_many :events, dependent: :destroy
  
  accepts_nested_attributes_for :events

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 60 }
  validates :description, presence: true, length: { minimum: 2, maximum: 300 }
  
end
