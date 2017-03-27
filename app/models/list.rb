class List < ApplicationRecord
  belongs_to :user
  has_many :reviews
  validates :title, presence: true
  has_many :list_relationships
  has_many :members, throuth: :list_relationships, source: :user 
end
