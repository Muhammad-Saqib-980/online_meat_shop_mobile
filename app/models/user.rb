class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true,
                      uniqueness: { case_sensitive: false},
                      format: /@/
end
