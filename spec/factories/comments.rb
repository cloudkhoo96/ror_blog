FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    association :article

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
