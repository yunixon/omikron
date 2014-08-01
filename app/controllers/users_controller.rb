class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :correct_user,   only: [:show, :edit, :update]
    
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def edit
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :balance)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user || current_user.role.admin?
  end
  
end
