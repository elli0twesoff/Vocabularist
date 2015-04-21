class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :english
      t.string :german
      t.integer :chapter
      t.string :article
      t.string :gender
      t.string :plural_key

      t.timestamps
    end
  end
end
