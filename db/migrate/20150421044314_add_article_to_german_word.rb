class AddArticleToGermanWord < ActiveRecord::Migration
  def change
    add_column :german_words, :article, :string
  end
end
