class ProfilesController < ApplicationController

  def dashboard
    if current_user.admin
      @unsold_products = Product.where(sold: false)
      @sold_products = Product.where(sold: true)
      @categories = Category.all
    else
      @unsold_products = current_user.products.where(sold: false)
      @sold_products = current_user.products.where(sold: true)
    end
  end
end
