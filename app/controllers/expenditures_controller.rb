class ExpendituresController < ApplicationController
    def index
        @category = Category.find(params[:category_id])
        @expenditures = @category.expenditures
    end
end