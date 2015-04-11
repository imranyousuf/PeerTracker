json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :assignment_name, :course, :deadline
  json.url assignment_url(assignment, format: :json)
end
