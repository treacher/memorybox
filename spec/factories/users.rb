# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	first_name "Bill"
  	last_name "Bob"
  	email "bill@gmail.com"
  	password "password"
  	password_confirmation "password"
  end
end
