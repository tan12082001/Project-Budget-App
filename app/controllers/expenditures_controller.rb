class ExpendituresController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @expenditures = @category.expenditures.order(created_at: :desc)
  end

  def show
    @category = Category.find(params[:category_id])
    @expenditure = Expenditure.find(params[:id])
  end

  def new
    @category = Category.find(params[:category_id])
    @expenditure = Expenditure.new
    @current_category_id = @category.id
  end

  def create
    @expenditure = Expenditure.new(expenditure_params.except(:category_ids))
    @expenditure.author = current_user
    @categories = Category.where(id: expenditure_params[:category_ids])
    @categories.each do |category|
      @expenditure.categories << category
    end
    if @expenditure.save
      flash[:success] = 'Successfully added New Expenditure.'
      redirect_to category_expenditures_path(params[:category_id])
    else
      flash.now[:error] = 'Error: Failed to Add new Expenditure!'
      render :new
    end
  end

  def destroy
    @expenditure = current_user.expenditures.find(params[:id])

    if @expenditure.destroy
      flash[:success] = 'Successfully delete the Expenditure.'
      redirect_to category_expenditures_path(params[:category_id])
    else
      flash[:error] = 'Error: Failed to delete the Expenditure!'
      render :show
    end
  end

  def all_expenditures
    @expenditures = current_user.expenditures
    render 'expenditures/all_expenditures'
  end

  private

  def expenditure_params
    params.require(:expenditure).permit(:name, :amount, category_ids: [])
  end
end
