class CategoriesController < ApplicationController
  before_action :find_category ,only: [ :edit, :update, :destroy] 
  before_action :authenticate_user!, except: [:show]
  before_action :find_unsold, only: [:show]
  load_and_authorize_resource
  
  def index
    @categories = Category.all.order('name')

  end

  def show
  end

  def create
    @category = Category.create(category_params)

    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def find_unsold
    find_category()
    @products = @category.products.where(sold: false)
  end
end
