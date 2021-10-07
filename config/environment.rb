# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  port: 465,
  user_name: 'numair.majid@devsinc.com',
  password: 'Num686247air',
  authentication: 'plain',
  ssl: true,
  tsl: true,
  enable_starttls_auto: true

}
