class Semester < ApplicationRecord
    has_many :mods, dependent: :destroy
    belongs_to :plan
    accepts_nested_attributes_for :mods
end
