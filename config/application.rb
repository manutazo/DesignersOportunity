require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DesignersOportunity
  class Application < Rails::Application
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
   config.action_mailer.delivery_method = :smtp
   config.action_mailer.perform_deliveries = true
   config.action_mailer.raise_delivery_errors = true
   config.action_mailer.default :charset => "utf-8"

   ActionMailer::Base.smtp_settings = {
     :address              => "smtp.gmail.com",
       :port                 => 587,
       :domain               => "gmail.com",
       :user_name            => "manuelgomez@grupoariza.es",
       :password             => "Hagamoslo.01",
       :authentication       => "plain"
   }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = "Europe/Madrid"
  end
end
