require 'rails_helper'

RSpec.describe Event, :type => :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:event)).to be_valid
  end
  
  it { expect have_many :bets }
  
  it { is_expected.to belong_to(:event_type).class_name('EventType') }
  it { is_expected.to belong_to(:complete_type).class_name('CompleteType') }

end
