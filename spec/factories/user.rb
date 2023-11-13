require 'ffaker'
FactoryBot.define do
    factory :user, class: "User" do
      name { FFaker::Name.unique.name }
      email { FFaker::Internet.unique.email }
      mob { rand(6123456789..9876543210) } 
    end
  end