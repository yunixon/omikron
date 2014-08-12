require 'rails_helper'

RSpec.describe Event, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:event)).to be_valid
  end
  
  it { expect have_many :bets }
  
  it { is_expected.to belong_to(:event_type).class_name('EventType') }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:first_side) }
  it { is_expected.to validate_presence_of(:datetime_start) }
  it { is_expected.to ensure_length_of(:name).is_at_least(2) }
  it { is_expected.to ensure_length_of(:name).is_at_most(80) }
  it { is_expected.to ensure_length_of(:first_side).is_at_least(2) }
  it { is_expected.to ensure_length_of(:first_side).is_at_most(80) }
  it { is_expected.to ensure_length_of(:second_side).is_at_least(2) }
  it { is_expected.to ensure_length_of(:second_side).is_at_most(80) }
  
end
