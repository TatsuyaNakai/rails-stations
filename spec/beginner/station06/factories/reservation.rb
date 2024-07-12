FactoryBot.define do
  factory :reservation do
    date { Date.today }

    association :schedule
    association :sheet
    association :user
  end
end
