class ProductsController < ApplicationController
  
  before_action :find_product ,only: [:show, :edit, :update, :destroy] 
  before_action :authenticate_user!, except: [:index, :show]
  before_action :show_sidebar, only: [:index, :show]
  before_action :find_unsold, only: [:index]
  load_and_authorize_resource
  
  def index
    num_prod = @unsold_products.length
    products_shown = 6
    
    if num_prod > products_shown 
      @products = @unsold_products.order('created_at ASC').drop(num_prod - products_shown).reverse
    else
      @products = @unsold_products.order('created_at DESC')
    end

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

  def show_sidebar
    @show_sidebar = true
  end

  def find_unsold
    @unsold_products = Product.all.where(sold: false)
  end
end
