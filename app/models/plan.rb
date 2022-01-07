class Plan < ApplicationRecord
    belongs_to :user, :foreign_key => :owner_id
    has_many :semesters, dependent: :destroy
    accepts_nested_attributes_for :semesters
end
