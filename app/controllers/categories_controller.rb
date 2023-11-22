class CategoriesController < ApplicationController
  def index
    @user = current_user
    @categories = @user.categories
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user
    if @category.save
        flash[:success] = "New Category added successfully!"
        redirect_to categories_path
    else
        flash.now[:error] = "Error: Failed to add new Category!!"
        render :new, locals: {category: @category}
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
        flash[:success] = "Category successfully updated."
        redirect_to categories_path
    else
        flash.now[:error] = "Error: Failed to update the category!"
        render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.expenditures.each do |expenditure|
      expenditure.destroy
    end
    if @category.destroy
        flash[:success] = "Category successfully deleted."
        redirect_to categories_path
    else
        flash.now[:error] = "Error: Failed to delete category!"
        render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end