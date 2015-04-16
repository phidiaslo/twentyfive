class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "80x80>", :small => "50x50>", :xs => "24x24>" }, :default_url => "default-user-icon.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  has_many :gigs
  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  has_many :sales, class_name: "CustomerOrder", foreign_key: "seller_id"
  has_many :purchases, class_name: "CustomerOrder", foreign_key: "buyer_id"

  ROLE_SELECT = ['Member', 'Admin', 'Accountant', 'Super Admin']
end
