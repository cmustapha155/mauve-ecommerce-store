class Category < ApplicationRecord
  before_save :generate_slug
  # prevent deletion of miscellaneous category, which is required as a default for products
  before_destroy :prevent_misc_deletion, if: :misc?
  # when a a category is being deleted assign the misc category to products with that category
  before_destroy :reassign_products_to_misc, unless: :misc?

  # allowlist attributes as searchable for activeadmin
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "name", "slug", "updated_at" ]
  end

  # allowlist association as searchable for activeadmin (allow access to associated product info from here)
  def self.ransackable_associations(auth_object = nil)
    ["products"] # plural
  end

  has_many :products

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: { case_sensitive: false }

  private def generate_slug
    self.slug = name.parameterize if name.present?
  end

  private def misc?
    name == "Miscellaneous"
  end

  private def prevent_misc_deletion
    errors.add(:base, "Miscellaneous category required for products who's category is deleted.")
    throw(:abort)
  end

  private def reassign_products_to_misc
    misc = Category.find_by(name: "Miscellaneous") || raise("Miscellaneous category not found.")
    products.update_all(category_id: misc.id)
  end
end
