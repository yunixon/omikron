require 'rails_helper'

RSpec.describe CompleteTypesController, :type => :controller do
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
    subject { FactoryGirl.create(:complete_type) }

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
      it "assigns the requested category to new category" do
        get :new
        expect(assigns(:complete_type)).to be_new_record
      end
      
      it "render :new view" do
        get :new
        expect(response).to render_template :new
      end
    end
    
    describe "Get #edit" do
      it "assigns the requested category to subject" do
        get :edit, id: subject
        expect(assigns(:complete_type)).to eq(subject)
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
            post :create, complete_type: FactoryGirl.attributes_for(:complete_type)
            }.to change(CompleteType, :count).by(1)
        end
      
        it "redirects to index path" do
          post :create, complete_type: FactoryGirl.attributes_for(:complete_type)
          expect(response).to redirect_to complete_types_path
        end
      end
    end
    
    describe "PATCH #update" do
      context "with valid attributes" do
        it "updates object" do
          expect{
            patch :update, id: subject, complete_type: {result: 'new complete type'}
            }.to change{ subject.reload.result }.to('new complete type')
        end
      
        it "redirects to index path" do
          patch :update, id: subject, complete_type: {result: 'new complete type'}
          expect(response).to redirect_to complete_type_path(subject)
        end
      end
    end
  
    describe "DELETE #destroy" do
      before(:each) { @complete_type = FactoryGirl.create :complete_type }
      it "deletes the category" do
        expect{
          delete :destroy, id: @complete_type
          }.to change(CompleteType, :count).by(-1)
      end
      
      it "redirects to index path" do
        delete :destroy, id: @complete_type
        expect(response).to redirect_to complete_types_path
      end
    end
    
  end
end
