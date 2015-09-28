class AddStripeAndActivatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :activated, :boolean, default: false
  end
end
