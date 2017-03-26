class ListsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])

    if current_user != @list.user
      redirect_to root_path, alert: "You have no permission."
    end

  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      redirect_to lists_path
    else
      render :new
    end
  end

  def update
    @list = List.find(params[:id])

    if current_user != @list.user
      redirect_to root_path, alert: "You have no permission."
    end

    if @list.update(list_params)
      redirect_to lists_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])

    if current_user != @list.user
      redirect_to root_path, alert: "You have no permission."
    end
    
    @list.destroy
    flash[:alert] = "Movie deleted"
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:title, :profile)
  end
end
