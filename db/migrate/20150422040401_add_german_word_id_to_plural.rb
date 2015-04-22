class AddGermanWordIdToPlural < ActiveRecord::Migration
  def change
    add_column :plurals, :german_word_id, :integer
  end
end
