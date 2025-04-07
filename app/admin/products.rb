ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :price, :description, :slug, :category_id, :featured_image
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :description]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # remove problematic filter options for the page which were breaking it
  remove_filter :featured_image_attachment
  remove_filter :featured_image_blob

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :price
      f.input :description
      f.input :slug
      f.input :category
      f.input :featured_image, as: :file
    end
    f.actions
  end

  # Add a section for the image
sidebar "Featured Image", only: :show do
  if resource.featured_image.attached?
    image_tag url_for(resource.featured_image), style: "max-width: 100%; height: auto;"
  else
    "No image uploaded"
  end
end

end
