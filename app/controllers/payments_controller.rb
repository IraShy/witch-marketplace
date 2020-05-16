class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def get_stripe_id
    # @order = Order.find(:order_id)
    @order = current_user.orders.where(state: 'open')[0]
    products = []
    @order.products.each do |product|
      products << {
        name: product.name,
        description: product.description,
        amount: product.price,
        currency: 'aud',
        quantity: 1}
    end

    session_id = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: products,
      payment_intent_data: {
        metadata: {
          user_id: current_user.id,
          order_id: @order.id
        }
      },
      success_url: "#{root_url}payments/success?userId=#{current_user.id}&productId=#{@order.id}",
      cancel_url: "#{root_url}products"
    ).id
    render :json => {id: session_id, stripe_public_key: Rails.application.credentials.dig(:stripe, :public_key)}
  end

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    order_id = payment.metadata.product_id
    user_id = payment.metadata.user_id
    order = Order.find(order_id)
    order.products.each do |product|
      product.sold = true
      product.save
    end
    order.state = 'paid'
    order.save
    head 200
  end

  def success
    @order = Order.find(params[:orderId])
    @total = 0
    @order.products.each do |product|
      @total += product.price
    end
  end
end
