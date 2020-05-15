class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def get_stripe_id
    @product = Product.find(params[:id])
    products = []
    for i in 1..3 do
      products << {
        name: 'name',
        description: 'description',
        amount: 200,
        currency: 'aud',
        quantity: i,
      }

    end
    session_id = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: products,
      # line_items: [{
      #   name: @product.name,
      #   description: @product.description,
      #   amount: @product.price,
      #   currency: 'aud',
      #   quantity: 1,
      # }],
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

  def webhook
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    listing_id = payment.metadata.listing_id
    user_id = payment.metadata.user_id

    head 200
  end

  def success
    @product = Product.find(params[:productId])
  end
end
