class UserMailer < ApplicationMailer
    default from: 'shuklaashu134@gmail.com'
    def verification_email
      @user = params[:user]
      mail(to: @user.email, subject: 'Verify Your Account', host: 'localhost:3000')
    end
  end