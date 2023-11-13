# require 'rails_helper'

# RSpec.describe UsersController, type: :controller do
#   describe 'POST #signup' do
#     context 'when user signup is successful' do
#       it 'creates a new user, sends verification email, and returns a token' do
#         user_attributes = attributes_for(:user)
#         post :signup, params: { user: user_attributes }
#         expect(response).to have_http_status(:ok)
#         expect(response.body).to include('User created successfully')
#         expect(response.body).to include('Please check your email for verification instructions.')
#         expect(response.body).to include('token')
#       end
#     end

#     context 'when user signup fails' do
#       it 'returns an error message' do
#         user_attributes = attributes_for(:user, email: nil) # Invalid user attributes
#         post :signup, params: { user: user_attributes }
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.body).to include('error')
#       end
#     end
#   end

#   describe 'POST #login' do
#     let(:user) { create(:user) }

#     context 'when login is successful' do
#       it 'returns a token' do
#         post :login, params: { email: user.email }
#         expect(response).to have_http_status(:ok)
#         expect(response.body).to include('Login successful.')
#         expect(response.body).to include('token')
#       end
#     end

#     context 'when login fails' do
#       it 'returns an error message' do
#         post :login, params: { email: 'nonexistent@example.com' }
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.body).to include('Invalid email, password, or unverified account.')
#       end
#     end
#   end
# end
require 'rails_helper'

RSpec.describe UsersController, type: :request do
    before(:each) do
        #   @user = create(:user)
        #   @token = JWT.encode({ user_id:  user.id}, 'secret')
          @user = User.create(name: "ashu",email: "ashu26@yopmail.com",mob:1239567892,verified: 'true')
        end
  describe '#create and login' do
    let(:base_url) {"/users"}
    let(:create_params) {
      {user: {name: "ashu",email: "test12@gmail.com",mob:1234567892}}
    }
    context "Create User" do
        let(:base_url) {"/signup"}
        it 'return a user for show user api' do
            pre_user_count = User.count
            post base_url, params: create_params
            expect(response).to have_http_status(200)
            res = JSON response.body
            expect(User.count).to eq(pre_user_count+1)
            
        end
        it 'raise error when pass wrong arguments' do
            post base_url, params: {user: {name: "",email: "", mob:nil}}
            expect(response).to have_http_status(422)
        end
    end
  
    context 'Login' do
      it 'returns a valid user and token' do
        # debugger
        post  "/login", params: { email: @user.email, varified: 'true' }
        expect(response).to have_http_status(:ok)
      end
      it 'returns invalid user error' do
        post  "/login", params: { email: "asdfg@gmail.com"}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  describe '#Homepage' do
    context 'GET root' do
      # debugger
      base_url = "http://localhost:3000"
      it 'renders the home page with a plain text message' do
        get "#{base_url}"        
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('This is my Home page , Thankyou for visiting my website !@')
      end
    end
  end
end