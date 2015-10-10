class AddBookToGermanWord < ActiveRecord::Migration
  def change
    add_column :german_words, :book, :string
  end
end
