require 'open-uri'

  # This file should ensure the existence of records required to run the application in every environment (production,
  # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
  # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
  #
  # Example:
  #
  #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
  #     MovieGenre.find_or_create_by!(name: genre_name)
  #   end

  # AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

  # to allow the seed file to be rerun without issue, use find_or_create_by. Additionally activeadmin doesn't directly hold the password info, devise does, and so the statement must be structured as such
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end

# seed Categories table (4)
Category.find_or_create_by!(name: "Miscellaneous") # protected from deletion
Category.find_or_create_by!(name: "Sofas")
Category.find_or_create_by!(name: "Chairs")
Category.find_or_create_by!(name: "Storage")
Category.find_or_create_by!(name: "Lighting")


# seed Products (curated)
# CONSIDERATIONS: Miscellaneous category must exist, no image attached by default (in fact peep Product.column_names in console...), slug is automatically set and so omitted
# FOR DEV. FOR MARKS SEEDING MUST HAVE 100, OR BE DONE THROUGH FILE
# Product.find_or_create_by!(name: "Aero T4100 Office Desk", price: 279.99, description: "Streamlined for Productivity. With its modern design and efficient layout, the Aero T4100 provides a dedicated workspace for today's professional. Offering ample surface area and thoughtful features, it's the perfect foundation for a productive day.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Colton Throw Pillow", price: 24.99, description: "Add instant comfort and style to any space with the Colton Throw Pillow. Perfect for layering on sofas, chairs, or beds, this plush cushion offers extra support and a touch of personality to your décor.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Theta-5 Utility Cart", price: 119.99, description: "The newly updated Theta Utility Cart offers five tiers of storage, perfect for organizing everything from craft supplies to kitchen essentials. Its sturdy construction and smooth-rolling wheels make it easy to move wherever you need it.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Theta-3 Utillity Cart", price: 69.99, description: "This versatile cart offers three tiers of storage, perfect for organizing everything from craft supplies to kitchen essentials. Its sturdy construction and smooth-rolling wheels make it easy to move wherever you need it.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Essentials Mirror", price: 39.99, description: "Its thin frame design and clean edges create a contemporary piece that enhances any room. Ideal for bathrooms, dressing areas, or entryways, the ICU Mirror brings a sense of modern precision to your décor. 24\"W 36\"L.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Docker Bar Stool", price: 49.99, description: "Inspired by classic workshop designs, the Docker Bar Stool brings a rugged yet refined edge to your kitchen or bar area. Its sturdy construction and minimalist silhouette offer a comfortable and stylish seating solution.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Levi Dining Chair", price: 74.99, description: "Bring understated modern style to your table with the Levi Dining Chair. Its minimalist silhouette and comfortable seat make it a versatile choice for any dining room. Designed for both everyday meals and special occasions, the Levi is a timeless addition to your home.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Aero T4100 Desk Lamp", price: 49.99, description: "A testament to modern design, the Aero T4100's sleek lines and sturdy form create a sophisticated presence, while providing focused, high-quality illumination exactly where you need it. Crafted with premium materials.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Nexus Bookshelf", price: 149.99, description: "More than just storage, the Nexus is a central point for your literary world. Its modern design and sturdy construction offer a stylish and reliable home for your cherished books and treasured objects, creating a focal point in any room.", category_id: Category.find_by(name: "Miscellaneous").id)
# Product.find_or_create_by!(name: "Forma Performance Sofa", price: 329.99, description: "Effortless comfort meets lasting durability in the Forma Performance Sofa. This compact 2-seater is upholstered in a robust canvas fabric, ideal for high-traffic areas. Its clean lines and neutral tones make it a versatile piece that complements any décor, while providing comfortable seating for two.", category_id: Category.find_by(name: "Miscellaneous").id)

# seed Products (faker)
# miscellaneous
20.times do
  product = Product.find_or_create_by!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price(range: 10..100), category_id: Category.find_by(name: "Miscellaneous").id)

  image_url = "https://picsum.photos/600/400"
  file = URI.open(image_url)

  product.featured_image.attach(io: file, filename: "product-#{product.id}.jpg", content_type: "image/jpeg")
end

# sofas
20.times do
  product = Product.find_or_create_by!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price(range: 10..100), category_id: Category.find_by(name: "Sofas").id)

  image_url = "https://picsum.photos/600/400"
  file = URI.open(image_url)

  product.featured_image.attach(io: file, filename: "product-#{product.id}.jpg", content_type: "image/jpeg")
end

# chairs
20.times do
  product = Product.find_or_create_by!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price(range: 10..100), category_id: Category.find_by(name: "Chairs").id)

  image_url = "https://picsum.photos/600/400"
  file = URI.open(image_url)

  product.featured_image.attach(io: file, filename: "product-#{product.id}.jpg", content_type: "image/jpeg")
end

# storage
20.times do
  product = Product.find_or_create_by!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price(range: 10..100), category_id: Category.find_by(name: "Storage").id)

  image_url = "https://picsum.photos/600/400"
  file = URI.open(image_url)

  product.featured_image.attach(io: file, filename: "product-#{product.id}.jpg", content_type: "image/jpeg")
end

# lighting
20.times do
  product = Product.find_or_create_by!(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price(range: 10..100), category_id: Category.find_by(name: "Lighting").id)

  image_url = "https://picsum.photos/600/400"
  file = URI.open(image_url)

  product.featured_image.attach(io: file, filename: "product-#{product.id}.jpg", content_type: "image/jpeg")
end
