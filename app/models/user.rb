class User < ApplicationRecord
<<<<<<< HEAD
    validates :email, presence: true, uniqueness: {case_sensitive: false}, length:{maximum: 105}, 
                    format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, presence: true, length: {minimum: 8}
    has_many :plans
    has_secure_password
=======
>>>>>>> 3f29ab899cb856f4c19ac7d548b86f68d0d238a1
end
