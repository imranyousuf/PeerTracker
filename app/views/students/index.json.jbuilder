json.array!(@students) do |student|
  json.extract! student, :id, :name, :email, :quiz1, :quiz2, :quiz3, :overall
  json.url student_url(student, format: :json)
end
