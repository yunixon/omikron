class User < ActiveRecord::Base
  extend Enumerize
  
  enumerize :role, in: { user: 0, admin: 1 }, default: :user
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :bets
  
  accepts_nested_attributes_for :bets
  
  validates :balance, numericality: { greater_than_or_equal_to: 0.0 }
  
end
