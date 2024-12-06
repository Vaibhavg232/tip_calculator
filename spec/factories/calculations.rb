FactoryBot.define do
  factory :calculation do
    bill_amount { 100.00 }
    tip_percentage { 15 }
    number_of_people { 2 }
  end
end
