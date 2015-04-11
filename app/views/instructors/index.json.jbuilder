json.array!(@instructors) do |instructor|
  json.extract! instructor, :name, :id, :email, :teams
  json.url instructor_url(instructor, format: :json)
end
