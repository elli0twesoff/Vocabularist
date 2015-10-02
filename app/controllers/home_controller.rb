class HomeController < ApplicationController
  before_action :verify_admin, only: :log

  def index
  end

  def stripe_log
    @stripe_log = File.open('log/stripe_webhooks.txt').read
  end

end
