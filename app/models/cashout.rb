class Cashout < ActiveRecord::Base
  belongs_to :user
  validates :amount, numericality: { greater_than_or_equal_to: 20 }

  STATUS_SELECT = ['Pending', 'In Progress', 'Transfered']

end
