class Review < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates :content, presence: true 
end
