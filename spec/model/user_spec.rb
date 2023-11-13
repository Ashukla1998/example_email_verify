require 'rails_helper'      
# t.string "password"

RSpec.describe User, type: :model do
  context "Checkin the validation" do
        it " save user by enter valid data " do
        user = build(:user)
        t = user.save
        expect(t).to eq(true)
        end
    end

    context "if validation_time is more than 3 minutes" do
        it "user is not verified" do
          user = build(:user, verification_sent_at: 4.minutes.ago)
          t = user.verified?
          expect(t).to eq(false)
        end  
    end
      
end
# require 'rails_helper'

# RSpec.describe User, type: :model do


#   describe 'callbacks' do
#     let(:user) { create(:user) }

#     it 'generates verification token and sets verification_sent_at before create' do
#       expect(user.verification_token).not_to be_nil
#       expect(user.verification_sent_at).not_to be_nil
#     end

#     context 'validate_token_within_duration' do
#       it 'validates token within 3 minutes' do
#         user.verification_sent_at = 2.minutes.ago
#         user.validate_token_within_duration
#         expect(user.errors[:verification_token]).to be_empty
#       end

#       it 'invalidates expired token' do
#         user.verification_sent_at = 4.minutes.ago
#         user.validate_token_within_duration
#         expect(user.errors[:verification_token]).to include('Token has expired')
#         expect(user.verification_token).to be_nil
#       end

#       it 'skips validation for new records' do
#         new_user = build(:user)
#         new_user.validate_token_within_duration
#         expect(new_user.errors[:verification_token]).to be_empty
#       end
#     end
#   end
# end