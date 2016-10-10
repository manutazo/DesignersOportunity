class SubscriptionMailer < ApplicationMailer
  def welcome_subcripcion(subscriber)
     @subscriber = subscriber
    mail(to: @subscriber.email , subject: 'Welcome to My Awesome Site')
  end
end
