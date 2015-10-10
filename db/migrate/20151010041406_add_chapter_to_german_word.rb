class AddChapterToGermanWord < ActiveRecord::Migration
  def change
    add_column :german_words, :chapter, :integer
  end
end
