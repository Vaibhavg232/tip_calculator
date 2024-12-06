class CalculationDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    @view_columns ||= {
      bill_amount: { source: "Calculation.bill_amount", cond: :eq },
      tip_percentage: { source: "Calculation.tip_percentage", cond: :like }
      number_of_people: { source: "Calculation.number_of_people", cond: :eq },
      tip_amount: { source: "Calculation.tip_amount", cond: :like }
      per_person_amount: { source: "Calculation.per_person_amount", cond: :eq },
      created_at: { source: "Calculation.created_at", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        bill_amount: record.bill_amount,
        tip_percentage: record.tip_percentage
        number_of_people: record.number_of_people,
        tip_amount: record.tip_amount
        per_person_amount: record.per_person_amount,
        created_at: record.created_at
      }
    end
  end

  def get_raw_records
    Calculation.all
  end

end
