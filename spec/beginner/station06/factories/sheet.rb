FactoryBot.define do
  factory :sheet do
    sequence(:column) { |n| n }
    row { 'a' }

    association :screen
  end
end
