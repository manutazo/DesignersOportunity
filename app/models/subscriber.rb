class Subscriber < ApplicationRecord
  
 validates :email, presence: true, uniqueness: true, on: :create


 def send_email_to_subscribers
   Subscriber.all.each do |subscriber|
     SubscriptionMailer.send_email(subscriber.email,self)
   end
  end
end
