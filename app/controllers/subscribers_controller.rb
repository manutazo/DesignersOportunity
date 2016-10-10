class SubscribersController < ApplicationController


  def new
    @subscriber = Subscriber.new
  end

  def create
     @subscriber = Subscriber.new(subscriber_params)
       respond_to do |format|
         if @subscriber.save
          SendEmailJob.set(wait: 20.seconds).perform_later(@subscriber)
           format.html { redirect_to index_path, notice: "great Your subscriber was created successfully." }
           format.json { render action: 'show', status: :created, location: @subscriber }
         else
           format.html { redirect_to index_path, :flash => { :error => @subscriber.errors.full_messages.join(', ') }}
           format.json { render json: @subscriber.errors, status: :unprocessable_entity }
         end
     end
   end

   private

      def subscriber_params
        params.require(:subscriber).permit(:email)
      end

end
