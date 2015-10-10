class AddSelectedBookToUser < ActiveRecord::Migration
  def change
    add_column :users, :book_selected, :string
  end
end
