class Payment < ActiveRecord::Base

  def self.process_stripe_webhook(params)
    puts "Received a stripe webhook: \n#{params}"


    log_file = 'log/stripe_webhooks.txt'
    FileUtils.touch(log_file) unless File.exists?(log_file)
    
    puts "Writing to log file: #{log_file}"

    File.open('log/stripe_webhooks.txt', 'a') do |f|
      f.puts "\n"
      f.puts params.to_s
    end
  end

end
