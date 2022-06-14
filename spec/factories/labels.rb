FactoryBot.define do
  factory :label do
    name { "Blue" }
  end

  factory :label2, class: Label do
    name { "Black" }
  end
end
