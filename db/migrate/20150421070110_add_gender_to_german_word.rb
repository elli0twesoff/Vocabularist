class AddGenderToGermanWord < ActiveRecord::Migration
  def change
    add_column :german_words, :gender, :string
  end
end
