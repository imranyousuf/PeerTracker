json.array!(@students) do |student|
  json.extract! student, :name, :sid, :email, :instructor, :team
  json.url student_url(student, format: :json)
end
