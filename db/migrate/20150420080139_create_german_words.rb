class CreateGermanWords < ActiveRecord::Migration
  def change
    create_table :german_words do |t|
      t.string :word
      t.integer :chapter
      t.integer :english_word_id

      t.timestamps
    end
  end
end
