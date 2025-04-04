class Product < ApplicationRecord
  before_save :generate_slug

  # allowlist attributes as searchable for activeadmin
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "description", "id", "id_value", "name", "price", "updated_at", "slug", "category_id" ]
  end

  # allowlist associations as searchable for activeadmin (allow access to associated category info from here)
  def self.ransackable_associations(auth_object = nil)
    ["category"] # singular
  end

  belongs_to :category

  # validation required for each property, AND by property type (except strings)
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :slug, uniqueness: { case_sensitive: false }

  private def generate_slug
      self.slug = name.parameterize if name.present?
  end
end
