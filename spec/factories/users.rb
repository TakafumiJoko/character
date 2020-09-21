# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Sample User' }
    email { 'sample@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
