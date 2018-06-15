json.array!(@owner_centers) do |owner_center|
  json.extract! owner_center, :id, :user_id, :rut_centro
  json.url owner_center_url(owner_center, format: :json)
end
