require 'rails_helper'

RSpec.describe Transaction, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:transaction)).to be_valid
  end
  
  it { is_expected.to belong_to(:user).class_name('User') }
  it { is_expected.to validate_presence_of(:t_type) }
  it { is_expected.to validate_numericality_of(:amount) }
end
