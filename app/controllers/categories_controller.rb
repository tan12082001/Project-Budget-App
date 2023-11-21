class CategoriesController < ApplicationController
  def index
    @user = current_user
    @categories = @user.categories
  end
end
