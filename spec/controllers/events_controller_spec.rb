require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  
  context "when user not logged in" do
    describe "Get #index" do
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  
  context "when user with role admin logged in" do
    let(:admin) { FactoryGirl.create(:user, role: :admin)}
    let(:event_type) { FactoryGirl.create(:event_type) }
    subject { FactoryGirl.create(:event, event_type_id: :event_type) }

    before do
      sign_in admin
    end

    describe "Get #index" do
      it "render :index view" do
        get :index
        expect(response).to render_template :index
      end
    end
    
    describe "Get #show" do
      it "render :show view" do
        get :show, id: subject
        expect(response).to render_template :show
      end
    end
    
    describe "Get #new" do
      it "assigns the requested event to new event" do
        get :new
        expect(assigns(:event)).to be_new_record
      end
      
      it "render :new view" do
        get :new
        expect(response).to render_template :new
      end
    end
    
    describe "Get #edit" do
      it "assigns the requested event to subject" do
        get :edit, id: subject
        expect(assigns(:event)).to eq(subject)
      end
      
      it "renders the :edit view" do
        get :edit, id: subject
        expect(response).to render_template :edit
      end
    end
    
    describe "POST #create" do
      context "with valid attributes" do
        it "creates new object" do
          expect{
            post :create, event: FactoryGirl.attributes_for(:event)
            }.to change(Event, :count).by(1)
        end
      
        it "redirects to index path" do
          post :create, event: FactoryGirl.attributes_for(:event)
          expect(response).to redirect_to events_path
        end
      end
      context "with not valid attributes" do
        it "it not save object to db" do
          expect{
            post :create, event: FactoryGirl.attributes_for(:event, name: nil)
            }.to_not change(Event, :count)
        end
      
        it "render new view" do
          post :create, event: FactoryGirl.attributes_for(:event, name: nil)
          expect(response).to render_template :new
        end
      end
    end
    
    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{
            patch :update, id: subject, event: {name: 'new event'}
            }.to change{ subject.reload.name }.to('new event')
        end
      
        it "redirects to index path" do
          patch :update, id: subject, event: {name: 'new event'}
          expect(response).to redirect_to event_path(subject)
        end
      end
    end
  
    describe "DELETE #destroy" do
      before(:each) { @event = FactoryGirl.create :event, event_type_id: :event_type,
        complete_type_id: :complete_type }
      it "deletes the event" do
        expect{
          delete :destroy, id: @event
          }.to change(Event, :count).by(-1)
      end
      
      it "redirects to index path" do
        delete :destroy, id: @event
        expect(response).to redirect_to events_path
      end
    end
    
  end

end
