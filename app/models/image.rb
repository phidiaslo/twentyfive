class Image < ActiveRecord::Base
	has_attached_file :graphic, :styles => { :large => "800x542>", :medium => "300x300>", :thumb => "100x100>", }, :default_url => "no-image.jpg"

	validates_attachment_content_type :graphic, :content_type => /\Aimage\/.*\Z/
    validates_attachment_size :graphic, :less_than => 1.megabytes

	belongs_to :gig, inverse_of: :images
end
