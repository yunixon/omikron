require 'rails_helper'

RSpec.describe BetsController, :type => :controller do

  context "when user with role user logged in" do
    let(:user) { FactoryGirl.create(:user, role: :user)}
    let(:event) { FactoryGirl.create(:event) }
    subject { FactoryGirl.create(:bet) }

    before do
      sign_in user
    end
    
    
  end
  
end
