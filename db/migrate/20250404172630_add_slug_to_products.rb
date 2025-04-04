class AddSlugToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :slug, :string
  end
end
