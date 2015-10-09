ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => ENV['VOCABULARIST_GMAIL_USERNAME'],
  :password             => ENV['VOCABULARIST_GMAIL_PASSWORD'],
  :authentication       => "plain",
  :enable_starttls_auto => true,
  #:openssl_verify_mode  => 'none'
}
