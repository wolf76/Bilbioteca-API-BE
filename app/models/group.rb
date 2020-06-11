class Group < ApplicationRecord
  validates :name, presence: true

  has_many :user_groups
  has_many :users, through: :user_groups

  has_many :books, through: :users

  belongs_to :created_by, class_name: 'User', foreign_key: "created_by"
end
