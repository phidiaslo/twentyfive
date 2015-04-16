# Preview all emails at http://localhost:3000/rails/mailers/status_mailer
class StatusMailerPreview < ActionMailer::Preview
  def send_notification_to_buyer
    StatusMailer.notification_to_buyer(User.first, Order.first)
  end

  def send_notification_to_seller
    StatusMailer.notification_to_seller(User.first, self)
  end

    def send_invoice_to_buyer
      StatusMailer.invoice_to_buyer(User.first, self)
    end
end
