json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :name, :email, :score
  json.url teacher_url(teacher, format: :json)
end
