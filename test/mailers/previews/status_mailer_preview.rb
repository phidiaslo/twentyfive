# Preview all emails at http://localhost:3000/rails/mailers/status_mailer
class StatusMailerPreview < ActionMailer::Preview
  def send_notification_to_buyer!
    StatusMailer.notification_to_buyer(User.first, Order.first)
  end
end
