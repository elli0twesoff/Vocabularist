class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @payments = Payment.all
    respond_with(@payments)
  end

  def show
    respond_with(@payment)
  end

  def new
    @payment = Payment.new
    respond_with(@payment)
  end

  def edit
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.save
    respond_with(@payment)
  end

  def update
    @payment.update(payment_params)
    respond_with(@payment)
  end

  def destroy
    @payment.destroy
    respond_with(@payment)
  end

  def webooks
    # thank god stripe provided all this cool stuff.  i'm just wayyy too lazy fo dat.
    Payment.process_stripe_webhook(params)
  
    # Use Stripe's bindings...
  rescue Stripe::CardError => e
    # Since it's a decline, Stripe::CardError will be caught
    body = e.json_body
    err  = body[:error]

    puts "Status is: #{e.http_status}"
    puts "Type is: #{err[:type]}"
    puts "Code is: #{err[:code]}"
    # param is '' in this case
    puts "Param is: #{err[:param]}"
    puts "Message is: #{err[:message]}"
  rescue Stripe::RateLimitError => e
    # Too many requests made to the API too quickly
    puts "Stripe error: #{e.message}"
  rescue Stripe::InvalidRequestError => e
    # Invalid parameters were supplied to Stripe's API
    puts "Stripe error: #{e.message}"
  rescue Stripe::AuthenticationError => e
    # Authentication with Stripe's API failed
    # (maybe you changed API keys recently)
    puts "Stripe error: #{e.message}"
  rescue Stripe::APIConnectionError => e
    # Network communication with Stripe failed
    puts "Stripe error: #{e.message}"
  rescue Stripe::StripeError => e
    # Display a very generic error to the user, and maybe send
    # yourself an email
    puts "Stripe error: #{e.message}"
  rescue => e
    # Something else happened, completely unrelated to Stripe
  end

  private
    def set_payment
      @payment = Payment.find(params[:id])
    end

    def payment_params
      params.require(:payment).permit(:email, :stripe_id, :amount, :status)
    end
end
