class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :email
      t.string :stripe_id
      t.string :amount
      t.string :status

      t.timestamps
    end
  end
end
