require 'rails_helper'

RSpec.describe User, :type => :model do
  
  it { expect have_many :bets }

  before :all do
    @first_user = FactoryGirl.create :first_user
    @second_user = FactoryGirl.create :second_user
  end

  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  
end