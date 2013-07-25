# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    description "MyString"
    media_url "http://google.com/1"
    media_identifier "1"
    media_format "jpg"
    media_type "image"
  end
end
