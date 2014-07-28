require 'rails_helper'

RSpec.describe EventType, :type => :model do
  it "has a valid factory" do
  	expect(FactoryGirl.build(:event_type)).to be_valid
  end

  #it { expect have_many :events }
end
