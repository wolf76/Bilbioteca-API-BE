FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
  end

  factory :book_with_users, :parent => :book do
    users factory: :user
  end
end
