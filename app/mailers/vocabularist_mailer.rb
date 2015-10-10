class VocabularistMailer < ActionMailer::Base
  default from: "no-reply@vocabularist.com"

  def signup_receipt(user)
    @user = user
    recipient = Rails.env == "production" ? @user.email : 'ewesoff@gmail.com'
    mail(to: recipient, subject: 'thank you so much!')
  end

  def signup_notification(user)
    @user = user
    mail(to: 'ewesoff@gmail.com', subject: 'New Vocabularist subscription!')
  end

end
