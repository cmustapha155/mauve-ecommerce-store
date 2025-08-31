class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: true, foreign_key: true
      t.string :status
      t.decimal :subtotal
      t.decimal :provincial_sales_tax
      t.decimal :general_sales_tax
      t.decimal :total_price
      t.string :email
      t.string :address
      t.string :apartment_number
      t.string :city
      t.string :state
      t.string :zip
      t.string :country

      t.timestamps
    end
  end
end
