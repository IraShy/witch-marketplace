class OrdersController < ApplicationController
  def create
# checking user's orders - if there is an open order, the next product will be added to it; else a new order is created
    if !current_user.orders.any?
      order = Order.create(state: 'open', user_id: current_user.id)
    elsif !current_user.orders.where(state: 'open').any?
    # elsif current_user.orders.last.state != 'open'
      order = Order.create(state: 'open', user_id: current_user.id)
    else
      order = current_user.orders.where(state: 'open')[0]
    end 
    product = Product.find(params[:product_id])
    order.products << product
    product.sold = true
    redirect_to order_path(id: order.id)
  end

  def show
    @order = current_user.orders.where(state: 'open')[0]
  end
end
