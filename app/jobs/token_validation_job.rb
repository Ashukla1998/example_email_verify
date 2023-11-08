class TokenValidationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user

    if user.verification_sent_at && user.verification_sent_at < 3.minutes.ago
      user.errors.add(:verification_token, "Token has expired")
      user.save(validate: false) 
    end
  end
end
