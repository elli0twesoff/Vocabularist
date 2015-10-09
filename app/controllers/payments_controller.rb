class PaymentsController < ApplicationController
  before_action :authenticate_user!, except: [:disclaimer, :webhooks]

  respond_to :html

  def new
    @payment = Payment.new
    respond_with(@payment)
  end

  def create
    @amount = 500 # cents, not dollars :P
    @user = User.find_by(email: params[:stripeEmail])

    customer = if current_user.stripe_id
      Stripe::Customer.retrieve(current_user.stripe_id)
    else
      Stripe::Customer.create
    end
     
    customer.email = @user.email
    customer.card  = params[:stripeToken]
    customer.save

    @user.stripe_id = customer.id
    @user.save

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Vocabularist customer',
      :currency    => 'usd'
    )

    @user.activated = true
    @user.save

    Payment.create(
      email:      @user.email,
      stripe_id:  @user.stripe_id,
      status:     "success"
    )

    VocabularistMailer.signup_receipt(current_user).deliver!

    redirect_to root_path, notice: "Your payment has been recieved, and you are now free to use the rest of the site.  Thank you!"

  rescue Stripe::CardError => e
    puts "Stripe card error: #{e.message}"
    e.backtrace.each { |m| "\tfrom #{m}" }
    redirect_to :back, flash: { alert: e.message }
  rescue Exception => e
    puts "Unexpected error in user signup: \n => #{e.message}"
    e.backtrace.each { |m| puts "\tfrom #{m}" }
    redirect_to :back, flash: { alert: "An unexpected error occurred processing your payment. Sorry about that." }
  end

  def disclaimer
    # hide the link from the footer.
    @disclaimer = true
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

  def signup_email
    VocabularistMailer.signup_receipt(current_user).deliver!
    redirect_to :back, flash: { notice: 'test email sent.' }
  end

  private

  def set_payment
    @payment = Payment.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:email, :stripe_id, :amount, :status)
  end
end
