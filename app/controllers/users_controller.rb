
class UsersController < ApplicationController
  def signup
    @user = User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).verification_email.deliver_now
      token = encode_token({ user_id: @user.id })
      render json: { message: 'User created successfully. Please check your email for verification instructions.' ,token: token}, status: :ok
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    # debugger
    user = User.find_by(email: params[:email])
    if user && user.verified?
      token = encode_token({ user_id: user.id })
      render json: { message: 'Login successful.', token: token }, status: :ok
      # return render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email, password, or unverified account.' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name,:mob)
  end
end
