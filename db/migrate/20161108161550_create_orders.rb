class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.integer :city
      t.text :adress
      t.string :email
      t.integer :number

      t.timestamps
    end
  end
end
