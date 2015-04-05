json.array!(@gigs) do |gig|
  json.extract! gig, :id, :gig_title, :category, :description, :duration, :video
  json.url gig_url(gig, format: :json)
end
