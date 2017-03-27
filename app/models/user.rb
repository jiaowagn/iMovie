class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lists
  has_many :reviews
  has_many :list_relationships
  has_many :participated_lists, :through => :list_relationships, :source => :list

  def is_member_of?(list)
    participated_lists.include?(list)
  end 
end
