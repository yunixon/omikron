require 'rails_helper'

RSpec.describe EventType, :type => :model do
  it "has a valid factory" do
  	expect(FactoryGirl.build(:event_type)).to be_valid
  end

  it { expect have_many :events }
  it { should validate_uniqueness_of(:name) }
  it { is_expected.not_to allow_value('').for(:name) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.not_to allow_value('').for(:description) }
  it { is_expected.to validate_presence_of(:description) }
end
