ActiveAdmin.register CatalogueVariant do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :catalogue_id, :catalogue_variant_color_id, :catalogue_variant_size_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:catalogue_id, :catalogue_variant_color_id, :catalogue_variant_size_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
