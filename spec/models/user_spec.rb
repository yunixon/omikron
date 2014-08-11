require 'rails_helper'

RSpec.describe User, :type => :model do
 
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
  
  it { is_expected.to have_many(:bets) }
  it { is_expected.to have_many(:transactions) }
  it { is_expected.to validate_numericality_of(:balance) }
  it { is_expected.to ensure_inclusion_of(:role).in_array(%w(user admin)) }
  
  let(:user) { FactoryGirl.create :user, role: :user }
end