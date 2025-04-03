class Product < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "id_value", "name", "price", "updated_at" ]
  end

  # validation required for each property, AND by property type (except strings)
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
end
