class CreateEditionPackagings < ActiveRecord::Migration[5.2]
  def change
    create_table :edition_packagings do |t|
      t.references :edition, foreign_key: true
      t.references :packaging, foreign_key: true
    end
  end
end
