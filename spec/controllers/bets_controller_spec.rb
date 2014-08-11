require 'rails_helper'

RSpec.describe BetsController, :type => :controller do

  context "when user with role user logged in" do
    let(:user) { FactoryGirl.create(:user, role: :user, balance: 500)}
    let(:event) { FactoryGirl.create(:event) }
    subject { FactoryGirl.create(:bet, event: event, user: user) }

    before do
      sign_in user
    end
    
    
    
  end
  
end
