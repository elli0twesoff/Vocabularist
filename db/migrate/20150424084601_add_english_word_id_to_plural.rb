class AddEnglishWordIdToPlural < ActiveRecord::Migration
  def change
    add_column :plurals, :english_word_id, :integer
  end
end
