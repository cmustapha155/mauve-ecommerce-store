class Category < ApplicationRecord
  before_save :generate_slug

  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "id", "name", "slug", "updated_at" ]
  end

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, uniqueness: { case_sensitive: false }

  private def generate_slug
      self.slug = name.parameterize if name.present?
  end
end
