class Payment < ActiveRecord::Base

  def self.process_stripe_webhook(params)
    puts "Received a stripe webhook: \n#{params}"
  end

end
