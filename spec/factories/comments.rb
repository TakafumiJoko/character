FactoryBot.define do
  factory :comment do
    form { "MyString" }
    body { "MyString" }
    user { nil }
    post { nil }
  end
end
