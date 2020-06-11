FactoryBot.define do
  factory :group do
    name { Faker::Name.name }
    created_by factory: :user
  end

  factory :group_with_users, :parent => :group do
    users factory: :user
  end
end
