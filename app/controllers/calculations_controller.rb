class CalculationsController < ApplicationController
  protect_from_forgery except: :create

  def index
    
  end

  def create
    @calculation = Calculation.new(calculation_params)
    calculate_totals(@calculation)

    if @calculation.save
      render json: { calculation: @calculation }, status: :created
    else
      render json: { errors: @calculation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  #  def admin_dashboard
  #   @calculations = Calculation.order(created_at: :desc)
  #   render json: @calculations
  # end
  
  private

  def calculation_params
    params.require(:calculation).permit(:bill_amount, :tip_percentage, :number_of_people, :tip_amount, :total_amount, :per_person_amount)
  end

  def calculate_totals(calculation)
    calculation.tip_amount = calculation.bill_amount * (calculation.tip_percentage / 100.0)
    calculation.total_amount = calculation.bill_amount + calculation.tip_amount
    calculation.per_person_amount = calculation.total_amount / calculation.number_of_people
  end
end
