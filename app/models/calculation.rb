class Calculation < ApplicationRecord
  validates :bill_amount, :tip_percentage, :number_of_people, presence: true
  validates :bill_amount, :tip_percentage, :total_amount, :per_person_amount, numericality: { greater_than_or_equal_to: 0 }
  validates :number_of_people, numericality: { greater_than: 0 }
  
  # before_save :calculate_tip_and_total

  # private

  # def calculate_tip_and_total
  #   self.tip_amount = (bill_amount * (tip_percentage / 100)).round(2)
  #   self.total_amount = (bill_amount + tip_amount).round(2)
  #   self.per_person_amount = (total_amount / number_of_people).round(2)
  # end
end
