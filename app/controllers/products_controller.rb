class ProductsController < ApplicationController
  before_action :find_product ,only: [:show, :edit, :update, :destroy] 
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  
  def index
    @products = Product.all.order('created_at ASC').drop(Product.all.length-7)
    # @products = Product.all.drop(Product.all.length-7)

  end

  def show
  end

  def create
    @product = current_user.products.create(product_params)

    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product.destroy

    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :category_id)
    # params.permit(:name, :description, :price, :image, :category_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
