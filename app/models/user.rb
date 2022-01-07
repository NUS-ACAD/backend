class User < ApplicationRecord
    validates :email, presence: true, uniqueness: {case_sensitive: false}, length:{maximum: 105}, 
                    format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, length: {minimum: 8}, if: -> { password.present? }
    has_many :members, dependent: :destroy
    has_many :plans, foreign_key: 'owner_id'
end
