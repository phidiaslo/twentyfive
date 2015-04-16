class Cashout < ActiveRecord::Base
  belongs_to :user

  STATUS_SELECT = ['Pending', 'In Progress', 'Transfered']

end
