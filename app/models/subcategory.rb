class Subcategory < ActiveRecord::Base
	extend FriendlyId
    friendly_id :name, use: :slugged
    
	belongs_to :category
	has_many :gigs
end
