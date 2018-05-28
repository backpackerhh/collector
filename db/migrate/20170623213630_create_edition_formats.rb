class CreateEditionFormats < ActiveRecord::Migration[5.1]
  def change
    create_table :edition_formats do |t|
      t.integer :number_of_discs, default: 1
      t.references :edition, foreign_key: true
      t.references :format, foreign_key: true
    end
  end
end
