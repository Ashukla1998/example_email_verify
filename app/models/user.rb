class User < ApplicationRecord
    validates :email, presence: true, uniqueness: true
    before_create :generate_verification_token
    before_create :validate_token_within_duration
  
    def generate_verification_token
        # debugger
      self.verification_token = SecureRandom.hex
      self.verification_sent_at = Time.now
    end

    def validate_token_within_duration
        # debugger
        if verification_sent_at.nil? || verification_sent_at < 3.minutes.ago
            self.verification_token = nil
            errors.add(:verification_token, "Token has expired")
        end
    end
  
    # def validate_token_within_duration
    #     self.verification_sent_at = Time.now
    #     expiration_time = verification_sent_at + 10.minutes
      
    #     if verification_sent_at < expiration_time
    #       errors.add(:verification_token, "Token has expired")
    #       throw(:abort)
    #     end
    # end
      
  end
  