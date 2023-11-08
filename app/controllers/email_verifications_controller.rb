
class EmailVerificationsController < ApplicationController
    # def verify
    #   user = User.find_by(verification_token: params[:token])
    #   if user && user.verification_sent_at >= 10.minutes.ago
    #     user.update(verified: true, verification_token: nil)
    #     render json: { message: 'Account verified successfully. You can now log in.' }, status: :ok
    #   else
    #     render json: { error: 'Invalid verification token.' }, status: :unprocessable_entity
    #   end
    # end
    def verify
        @user = User.find_by(verification_token: params[:token])
      
        if @user && @user.errors.empty? && user.verification_sent_at < 3.minutes.ago
          if @user.update(verified: true, verification_token: nil)
            render json: { message: 'Email verified successfully!' }
          else
            render json: { error: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Invalid or expired verification token' }, status: :unprocessable_entity
        end
    end

    def resend_verification
        user = User.find_by(email: params[:email])
      
        if user && !user.verified? && user.verification_sent_at  >  3.minutes.ago
          user.generate_verification_token
          UserMailer.with(user: user).verification_email.deliver_now 
          render json: { message: 'Verification email sent successfully. Please check your email.' }, status: :ok
        elsif user&.verified?
          render json: { error: 'Account is already verified.' }, status: :unprocessable_entity
        else
          render json: { error: 'User not found or account is already verified.' }, status: :unprocessable_entity
        end
      end
      
      
end


# if user && !user.verified? && user.verification_sent_at < 3.minutes.ago
#     user.generate_verification_token
#     UserMailer.with(user: user).verification_email.deliver_now 
#     render json: { message: 'Verification email sent successfully. Please check your email.' }, status: :ok
# elsif user&.verified?
#     render json: { error: 'Account is already verified.' }, status: :unprocessable_entity
# else
#     render json: { error: 'User not found or account is already verified.' }, status: :unprocessable_entity
# end