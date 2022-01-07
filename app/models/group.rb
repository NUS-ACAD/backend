class Group < ApplicationRecord
    has_many :members, depedent: :destroy
end
