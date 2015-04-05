class Category < ActiveRecord::Base
	
    
	has_many :gigs
	has_many :subcategories
end
