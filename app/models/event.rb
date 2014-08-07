class Event < ActiveRecord::Base
  
  has_many   :bets
  has_one    :complete_type
  belongs_to :event_type
  
  accepts_nested_attributes_for :bets, allow_destroy: true
  accepts_nested_attributes_for :complete_type, allow_destroy: true  
  
  validates :name,             presence: true
  validates :first_side,       presence: true
  validates :second_side,      presence: true
  validates :datetime_start,   presence: true
  
  validates_associated :event_type
  
  scope :completed, -> (bool)  { where(complete: bool) }
  scope :category, -> (cat) { where(event_type: cat)}
  scope :upcoming, -> (count) { where(complete: false).last(count) }
  scope :recent, -> (count) { where(complete: true).last(count) }
  scope :sort_by_dt, -> { order(:datetime_start) }

end
