json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :comments, :ratings
  json.url feedback_url(feedback, format: :json)
end
