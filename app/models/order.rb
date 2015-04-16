class Order < ActiveRecord::Base
	belongs_to :gig
	belongs_to :buyer, class_name: "User"
    belongs_to :seller, class_name: "User"

    def send_notification_to_buyer
      StatusMailer.notification_to_buyer(buyer, self).deliver
    end

    def send_notification_to_seller
      StatusMailer.notification_to_seller(seller, self).deliver
    end

    def send_invoice_to_buyer
      StatusMailer.invoice_to_buyer(buyer, self).deliver
    end

    def paypal_url(return_path)
        values = {
            business: "seller@twenty.com",
            cmd: "_cart",
            upload: 1,
            return: "#{Rails.application.secrets.app_host}#{return_path}",
            invoice: id,
            currency_code: 'MYR',
            item_name_1: gig.gig_title,
            amount_1: 25,
            quantity_1: '1',
            item_name_2: 'Processing Fee',
            amount_2: 3.5,
            notify_url: "#{Rails.application.secrets.app_host}/payment_notifications"
        }
        "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
      end
end
