class CreateGermanWords < ActiveRecord::Migration
  def change
    create_table :german_words do |t|
      t.string :word
      t.string :article
      t.string :gender
      t.integer :english_word_id

      t.timestamps
    end
  end
end
