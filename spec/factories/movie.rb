FactoryBot.define do
  factory :movie do
    sequence(:name) { |n| "TEST_MOVIE#{n}" }
    year { 2021 }
    description { 'この映画は最高です。改行しました' }
    image_url { 'https://picsum.photos/300/440' }
    is_showing { true }
  end
end
