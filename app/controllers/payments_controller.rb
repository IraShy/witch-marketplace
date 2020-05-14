class PaymentsController < ApplicationController
  def get_stripe_id
    @product = Product.find(params[:id])
    session_id = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: @product.name,
        description: @product.description,
        amount: @product.price,
        currency: 'aud',
        quantity: 1,
      }],
      payment_intent_data: {
        metadata: {
          user_id: current_user.id,
          product_id: @product.id
        }
      },
      success_url: "#{root_url}payments/success?userId=#{current_user.id}&productId=#{@product.id}",
      cancel_url: "#{root_url}products"
    ).id
    render :json => {id: session_id, stripe_public_key: Rails.application.credentials.dig(:stripe, :public_key)}
  end

  def success
    @product = Product.find(params[:productId])
  end
end
