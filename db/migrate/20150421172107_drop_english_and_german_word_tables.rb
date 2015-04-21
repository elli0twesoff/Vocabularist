class DropEnglishAndGermanWordTables < ActiveRecord::Migration
  def change
		drop_table :english_words
		drop_table :german_words
  end
end
