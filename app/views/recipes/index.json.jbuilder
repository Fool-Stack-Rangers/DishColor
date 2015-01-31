json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :description, :user_id, :photo_id
  json.url recipe_url(recipe, format: :json)
end
