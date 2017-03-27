class Account::ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.participated_lists
  end 
end
