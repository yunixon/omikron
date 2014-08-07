require 'rails_helper'

RSpec.describe CompleteType, :type => :model do
   it "has a valid factory" do
  	expect(FactoryGirl.build(:complete_type)).to be_valid
  end

  it { is_expected.to belong_to(:event).class_name('Event') }
  it { is_expected.to validate_presence_of(:result) }

end
