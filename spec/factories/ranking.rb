FactoryBot.define do
  factory :ranking do
    date { Date.yesterday }
    reservation_count { 0 }

    association :movie
  end
end
