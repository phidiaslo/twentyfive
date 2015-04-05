json.array!(@reviews) do |review|
  json.extract! review, :id, :gig_id, :user_id, :subject, :body, :communication_rating, :service_rating, :recommend_rating
  json.url review_url(review, format: :json)
end
