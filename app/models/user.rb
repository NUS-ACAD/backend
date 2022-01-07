class User < ApplicationRecord
    validates :email, presence: true, uniqueness: {case_sensitive: false}, length:{maximum: 105}, 
                    format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, presence: true, length: {minimum: 8}
    has_many :plans, foreign_key: 'owner_id'
    has_secure_password
end
