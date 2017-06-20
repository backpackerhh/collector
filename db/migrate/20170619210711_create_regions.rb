class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.references :format, foreign_key: true

      t.timestamps
    end
  end
end
