class Category < ApplicationRecord
  before_save :generate_slug

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
end
