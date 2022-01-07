class User < ApplicationRecord
    validates :email, presence: true, uniqueness: {case_sensitive: false}, length:{maximum: 105}, 
                    format: {with: URI::MailTo::EMAIL_REGEXP}
    validates :password, length: {minimum: 8}, if: -> { password.present? }
    has_many :members, dependent: :destroy
    has_many :groups, :through => :members 
    has_many :plans, foreign_key: 'owner_id'
    has_secure_password
    has_many :followed_associations, :class_name => 'Follow', :foreign_key => 'followed_id'
    has_many :followers_associations, :class_name => 'Follow', :foreign_key => 'follower_id'
    has_many :followers, :through => :followers_associations, :source => :followed
    has_many :followeds, :through => :followed_associations, :source => :follower
end
