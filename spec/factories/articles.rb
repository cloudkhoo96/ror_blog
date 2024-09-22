FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentence }

    trait :displayed do
      status { "displayed" }
    end

    trait :hidden do
      status { "hidden" }

    end

    trait :archived do
      status { "archived" }

    end
  end
end
