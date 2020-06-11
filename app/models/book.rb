class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: :true

  has_many :user_books
  has_many :users, through: :user_books

  has_many :groups, through: :users
end
