class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(subscriber)
    @subscriber = subscriber
    SubscriptionMailer.welcome_subcripcion(@subscriber).deliver_later
  end
end
