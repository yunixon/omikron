class UsersController < ApplicationController
  load_and_authorize_resource  param_method: :user_params
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :admin_user,   only: [:index, :destroy]
    
  def index
    @search = User.search(params[:q])
    @users = @search.result.order(:email).page(params[:page])
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
  
  def admin_user
    flash[:error] = "Access denied."
    redirect_to(root_url) unless current_user.role.admin?
  end
  
end
