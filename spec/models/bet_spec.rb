require 'rails_helper'

RSpec.describe Bet, :type => :model do
  
  let(:user) { FactoryGirl.create(:user, role: :user, balance: 500)}
  
  it "has a valid factory" do
    expect(FactoryGirl.build(:bet)).to be_valid
  end

  it { is_expected.to belong_to(:user).class_name('User') }
  it { is_expected.to belong_to(:event).class_name('Event') }

end
