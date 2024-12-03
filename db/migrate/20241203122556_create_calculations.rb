class CreateCalculations < ActiveRecord::Migration[8.0]
  def change
    create_table :calculations do |t|
      t.decimal :bill_amount
      t.decimal :tip_percentage
      t.integer :number_of_people
      t.decimal :tip_amount
      t.decimal :total_amount
      t.decimal :per_person_amount

      t.timestamps
    end
  end
end
