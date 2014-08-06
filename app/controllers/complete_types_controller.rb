class CompleteTypesController < ApplicationController
  load_and_authorize_resource param_method: :complete_type_params
  before_action :find_complete_type, only: [:show, :edit, :update]
  
   def new
    @complete_type = CompleteType.new
  end

  def show
  end

  def create
    @complete_type = CompleteType.new(complete_type_params)
    if @complete_type.save
      flash[:success] = "Complete type successfully added."
      redirect_to complete_types_path
    else
      render 'new'
    end
  end
  
  def edit
  end

  def update
    if @complete_type.update_attributes(complete_type_params)
      flash[:success] = "Complete type updated."
      redirect_to @complete_type
    else
      render 'edit'
    end
  end

  def destroy
    CompleteType.find(params[:id]).destroy
    flash[:success] = "Complete type destroyed."
    redirect_to complete_types_path
  end
  
  private
  
  def find_complete_type
    @complete_type = CompleteType.find(params[:id])
  end

  def complete_type_params
    params.require(:complete_type).permit(:result, :description)
  end
end
