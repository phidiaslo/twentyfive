class Gig < ActiveRecord::Base
    has_attached_file :cover, :styles => { :medium => "300x300>", :thumb => "100x100>", }, :default_url => "default.png"
    validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
    validates_presence_of :images

    PROCESSING_SELECT = ['1 Business Day', '1-2 Business Days', '1-3 Business Days', '3-5 Business Days', '1-2 Weeks', '2-3 Weeks', '3-4 Weeks']
    
    extend FriendlyId
    friendly_id :gig_title, use: :slugged

    belongs_to :user
    belongs_to :category
    belongs_to :subcategory
    has_many :orders
    has_many :customer_orders
    has_many :images, dependent: :destroy
    accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['graphic'].nil? }, :allow_destroy => true

    #after_create :send_gig_notification

    def send_gig_notification
    AdminMailer.new_gig(self).deliver
    #AdminMailer.new_gig(self)
    end
end
