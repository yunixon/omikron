require 'rails_helper'

RSpec.describe EventType, :type => :model do
  it "has a valid factory" do
  	expect(FactoryGirl.build(:event_type)).to be_valid
  end

  it { expect have_many :events }
  it { should validate_uniqueness_of(:name) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to ensure_length_of(:name).is_at_least(2) }
  it { is_expected.to ensure_length_of(:name).is_at_most(80) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to ensure_length_of(:description).is_at_least(2) }
  it { is_expected.to ensure_length_of(:description).is_at_most(1000) }
    
end
