class Admin::DashboardController < ApplicationController

  def index
    @calculations = Calculation.all.order(created_at: :desc)
  end 
end
  