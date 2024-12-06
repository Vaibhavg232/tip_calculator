require 'rails_helper'

RSpec.describe Calculation, type: :model do
  it 'is valid with valid attributes' do
    calculation = Calculation.new(bill_amount: 100, tip_percentage: 15, number_of_people: 2)
    expect(calculation).to be_valid
  end

  it 'is not valid without a bill_amount' do
    calculation = Calculation.new(tip_percentage: 15, number_of_people: 2)
    expect(calculation).not_to be_valid
  end

  it 'is not valid with a non-numerical bill_amount' do
    calculation = Calculation.new(bill_amount: 'abc', tip_percentage: 15, number_of_people: 2)
    expect(calculation).not_to be_valid
  end

  it 'is not valid with a bill_amount less than or equal to 0' do
    calculation = Calculation.new(bill_amount: 0, tip_percentage: 15, number_of_people: 2)
    expect(calculation).not_to be_valid
  end

  it 'is not valid without a tip_percentage' do
    calculation = Calculation.new(bill_amount: 100, number_of_people: 2)
    expect(calculation).not_to be_valid
  end

  it 'is not valid with a tip_percentage less than 1' do
    calculation = Calculation.new(bill_amount: 100, tip_percentage: 0, number_of_people: 2)
    expect(calculation).not_to be_valid
  end

  it 'is not valid without a number_of_people' do
    calculation = Calculation.new(bill_amount: 100, tip_percentage: 15)
    expect(calculation).not_to be_valid
  end

  it 'is not valid with a number_of_people less than or equal to 0' do
    calculation = Calculation.new(bill_amount: 100, tip_percentage: 15, number_of_people: 0)
    expect(calculation).not_to be_valid
  end
end
