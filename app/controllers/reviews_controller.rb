class ReviewsController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create]

  def new
    @list = List.find(params[:list_id])
    @review = Review.new
  end

  def create
    @list = List.find(params[:list_id])
    @review = Review.new(review_params)
    @review.list = @list
    @review.user = current_user

    if @review.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
  
end
