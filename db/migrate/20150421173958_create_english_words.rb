class CreateEnglishWords < ActiveRecord::Migration
  def change
    create_table :english_words do |t|
      t.string :word
      t.integer :chapter

      t.timestamps
    end
  end
end
