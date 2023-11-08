class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    before_create :generate_verification_token
    before_create :validate_token_within_duration
  
    private
  
    def generate_verification_token
      self.verification_token = SecureRandom.hex
    end
  
    def validate_token_within_duration
        verification_sent_at = Time.now
        expiration_time = verification_sent_at + 10.minutes
      
        if verification_sent_at < expiration_time
          errors.add(:verification_token, "Token has expired")
          throw(:abort)
        end
    end
      
  end
  