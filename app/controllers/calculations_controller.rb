class CalculationsController < ApplicationController

  def index; end

  def create
    @calculation = Calculation.new(calculation_params)
    
   
    if @calculation.valid? 
      calculate_totals(@calculation)
      @calculation.save
      render json: { calculation: @calculation }, status: :created
    else
      render json: { errors: @calculation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def calculation_params
    params.require(:calculation).permit(:bill_amount, :tip_percentage, :number_of_people)
  end
  
  def calculate_totals(calculation) 
    calculation.tip_amount = (calculation.bill_amount * calculation.tip_percentage / 100).to_f / calculation.number_of_people
    total_amount = calculation.bill_amount + (calculation.tip_amount * calculation.number_of_people)
    calculation.per_person_amount = calculation.number_of_people > 0 ? (total_amount / calculation.number_of_people).round(2) : 0
  end
end
