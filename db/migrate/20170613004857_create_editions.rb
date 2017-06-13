class CreateEditions < ActiveRecord::Migration[5.1]
  def change
    create_table :editions do |t|
      t.string :name
      t.references :distributor, foreign_key: true
      t.date :release_date
      t.string :country_code

      t.timestamps
    end
  end
end
