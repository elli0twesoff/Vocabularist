class CreatePlurals < ActiveRecord::Migration
  def change
    create_table :plurals do |t|
      t.string :word
      t.string :article
      t.string :gender

      t.timestamps
    end
  end
end
