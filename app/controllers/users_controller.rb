
class UsersController < ApplicationController
  def signup
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).verification_email.deliver_now
      render json: { message: 'User created successfully. Please check your email for verification instructions.' }, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    # debugger
    user = User.find_by(email: params[:email])
    if user && user.verified?
      render json: { message: 'Login successful.'}, status: :ok
    else
      render json: { error: 'Invalid email, password, or unverified account.' }, status: :unprocessable_entity
    end
  end

  def home
    render plain: "This is my Home page , Thankyou for visiting my website !@" 
  end

  private

  def user_params
    params.require(:user).permit(:email, :name,:mob)
  end
end
