class Group < ApplicationRecord
    has_many :members, dependent: :destroy
end
