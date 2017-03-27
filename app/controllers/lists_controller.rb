class ListsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
  before_action :find_list_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @reviews = @list.reviews.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def edit
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      current_user.join!(@list)
      redirect_to lists_path
    else
      render :new
    end
  end

  def update
    if @list.update(list_params)
      redirect_to lists_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    flash[:alert] = "Movie deleted"
    redirect_to lists_path
  end

  def join
    @list = List.find(params[:id])

    if !current_user.is_member_of?(@list)
      current_user.join!(@list)
      flash[:notice] = "成功收藏该影片！"
    else
      flash[:warning] = "您已经收藏了该影片！"
    end

    redirect_to list_path(@list)
  end

  def quit
    @list = List.find(params[:id])
    if current_user.is_member_of?(@list)
      current_user.quit!(@list)
      flash[:alert] = "已经取消收藏该影片！"
    else
      flash[:warning] = "您没有收藏该影片，怎么取消收藏？"
    end

    redirect_to list_path(@list)
  end

  private

  def find_list_and_check_permission
    @list = List.find(params[:id])

    if current_user != @list.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def list_params
    params.require(:list).permit(:title, :profile)
  end
end
