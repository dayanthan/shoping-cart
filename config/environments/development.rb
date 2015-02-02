Mytestapp::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.perform_deliveries = true 
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true


  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    ::GATEWAY = ActiveMerchant::Billing::AuthorizeNetGateway.new(
      :login => "23nAN8mg8g",
      :password => "5cmAv22J4J8n7xjs"
    )

    ::CIMGATEWAY = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
      :login => "23nAN8mg8g",
      :password => "5cmAv22J4J8n7xjs"
    )

  end
#   config.after_initialize do
#   ActiveMerchant::Billing::Base.mode = :test
#   ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
#     :login => " daya.naukri_api1.gmail.com",
#     :password => "GGFLLVKY7QTFJKZK",
#     :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31AVG0tGR97O1AhtTmmgaANtJwPSVM"
#   )
# end
  config.assets.debug = true
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,  #this is the important shit!
    :address        => 'smtp.gmail.com',
    :port           => 587,
    :domain         => 'localhost:3000',
    :authentication => :plain,
     :user_name      => 'dayanthan86@gmail.com',
     :password       => 'dayac2010'
  }



end
