class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true

    def generate_reset_otp!
        update!(
            reset_otp: rand.to_s[2..7],
            reset_otp_sent_at: Time.current
        )
        reset_otp
    end

    def valid_reset_otp?(otp)
        reset_otp = otp && reset_otp_sent_at && reset_otp_sent_at > 10.minutes.ago
    end

    def clear_reset_otp!
        update!(reset_otp: nil, reset_otp_sent_at: nil)
    end
end
