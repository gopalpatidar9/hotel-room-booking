class UserMailer < ApplicationMailer
  default :from => "from@example.com"  

  def welocme_email(user)
     @user = user
     @url = 'https://github.com/gopalpatidar9'
     mail(to: @user.email, subject: 'Welcome to HotelBooking')
  end
end
