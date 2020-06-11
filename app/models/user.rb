class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  validates :email, presence: true, uniqueness: :true

  has_many :user_books
  has_many :books, through: :user_books

  has_many :user_groups
  has_many :groups, through: :user_groups
end
